import json
import re
import sys
import traceback

from fud import errors

from . import rpt


def find_row(table, colname, key, certain=True):
    for row in table:
        if row[colname] == key:
            return row
    if certain:
        raise Exception(f"{key} was not found in column: {colname}")

    return None


def safe_get(d, key):
    if d is not None and key in d:
        return d[key]
    return -1


def to_int(s):
    if s == "-":
        return 0
    return int(s)


def file_contains(regex, filename):
    strings = re.findall(regex, filename.open().read())
    return len(strings) == 0


def rtl_component_extract(directory, name):
    try:
        with (directory / "synth_1" / "runme.log").open() as f:
            log = f.read()
            comp_usage = re.search(
                r"Start RTL Component Statistics(.*?)Finished RTL", log, re.DOTALL
            ).group(1)
            a = re.findall("{} := ([0-9]*).*$".format(name), comp_usage, re.MULTILINE)
            return sum(map(int, a))
    except Exception as e:
        print(e)
        print("RTL component log not found")
        return 0


def futil_extract(directory):
    directory = directory / "out" / "FutilBuild.runs"
    # The resource information is extracted first for the implementation files, and
    # then for the synthesis files. This is dones separately in case users want to
    # solely use one or the other.
    resourceInfo = {}

    # Extraction for implementation files.
    try:
        impl_parser = rpt.RPTParser(
            directory / "impl_1" / "main_utilization_placed.rpt"
        )
        slice_logic = impl_parser.get_table(re.compile(r"1\. CLB Logic"), 2)
        dsp_table = impl_parser.get_table(re.compile(r"4\. ARITHMETIC"), 2)
        meet_timing = file_contains(
            r"Timing constraints are not met.",
            directory / "impl_1" / "main_timing_summary_routed.rpt",
        )

        clb_lut = to_int(find_row(slice_logic, "Site Type", "CLB LUTs")["Used"])
        clb_reg = to_int(find_row(slice_logic, "Site Type", "CLB Registers")["Used"])
        carry8 = to_int(find_row(slice_logic, "Site Type", "CARRY8")["Used"])
        f7_muxes = to_int(find_row(slice_logic, "Site Type", "F7 Muxes")["Used"])
        f8_muxes = to_int(find_row(slice_logic, "Site Type", "F8 Muxes")["Used"])
        f9_muxes = to_int(find_row(slice_logic, "Site Type", "F9 Muxes")["Used"])
        resourceInfo.update(
            {
                "lut": to_int(find_row(slice_logic, "Site Type", "CLB LUTs")["Used"]),
                "dsp": to_int(find_row(dsp_table, "Site Type", "DSPs")["Used"]),
                "meet_timing": int(meet_timing),
                "registers": rtl_component_extract(directory, "Registers"),
                "muxes": rtl_component_extract(directory, "Muxes"),
                "clb_registers": clb_reg,
                "carry8": carry8,
                "f7_muxes": f7_muxes,
                "f8_muxes": f8_muxes,
                "f9_muxes": f9_muxes,
                "clb": clb_lut + clb_reg + carry8 + f7_muxes + f8_muxes + f9_muxes,
            }
        )

    except Exception:
        traceback.print_exc()
        print("Implementation files weren't found, skipping.", file=sys.stderr)

    # Extraction for synthesis files.
    try:
        synth_parser = rpt.RPTParser(directory / "synth_1" / "runme.log")
        cell_usage_tbl = synth_parser.get_table(re.compile(r"Report Cell Usage:"), 0)
        cell_lut1 = find_row(cell_usage_tbl, "Cell", "LUT1", False)
        cell_lut2 = find_row(cell_usage_tbl, "Cell", "LUT2", False)
        cell_lut3 = find_row(cell_usage_tbl, "Cell", "LUT3", False)
        cell_lut4 = find_row(cell_usage_tbl, "Cell", "LUT4", False)
        cell_lut5 = find_row(cell_usage_tbl, "Cell", "LUT5", False)
        cell_lut6 = find_row(cell_usage_tbl, "Cell", "LUT6", False)
        cell_fdre = find_row(cell_usage_tbl, "Cell", "FDRE", False)

        resourceInfo.update(
            {
                "cell_lut1": to_int(safe_get(cell_lut1, "Count")),
                "cell_lut2": to_int(safe_get(cell_lut2, "Count")),
                "cell_lut3": to_int(safe_get(cell_lut3, "Count")),
                "cell_lut4": to_int(safe_get(cell_lut4, "Count")),
                "cell_lut5": to_int(safe_get(cell_lut5, "Count")),
                "cell_lut6": to_int(safe_get(cell_lut6, "Count")),
                "cell_fdre": to_int(safe_get(cell_fdre, "Count")),
            }
        )
    except Exception:
        traceback.print_exc()
        print("Synthesis files weren't found, skipping.", file=sys.stderr)

    return json.dumps(resourceInfo, indent=2)


def hls_extract(directory):
    directory = directory / "benchmark.prj" / "solution1"
    try:
        parser = rpt.RPTParser(directory / "syn" / "report" / "kernel_csynth.rpt")
        summary_table = parser.get_table(re.compile(r"== Utilization Estimates"), 2)
        instance_table = parser.get_table(re.compile(r"\* Instance:"), 0)

        solution_data = json.load((directory / "solution1_data.json").open())
        latency = solution_data["ModuleInfo"]["Metrics"]["kernel"]["Latency"]

        total_row = find_row(summary_table, "Name", "Total")
        s_axi_row = find_row(instance_table, "Instance", "kernel_control_s_axi_U")

        return json.dumps(
            {
                "total_lut": to_int(total_row["LUT"]),
                "instance_lut": to_int(s_axi_row["LUT"]),
                "lut": to_int(total_row["LUT"]) - to_int(s_axi_row["LUT"]),
                "dsp": to_int(total_row["DSP48E"]) - to_int(s_axi_row["DSP48E"]),
                "avg_latency": to_int(latency["LatencyAvg"]),
                "best_latency": to_int(latency["LatencyBest"]),
                "worst_latency": to_int(latency["LatencyWorst"]),
            },
            indent=2,
        )
    except FileNotFoundError as e:
        raise errors.MissingFile(e.filename)
