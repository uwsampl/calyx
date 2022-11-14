/**
 * Core primitives for Calyx.
 * Implements core primitives used by the compiler.
 *
 * Conventions:
 * - All parameter names must be SNAKE_CASE and all caps.
 * - Port names must be snake_case, no caps.
 */
`default_nettype none

// BEGIN GENERATED CODE
// END GENERATED CODE

module std_const #(
    parameter WIDTH = 32,
    parameter VALUE = 0
) (
   output logic [WIDTH - 1:0] out
);
  assign out = VALUE;
endmodule

module std_wire #(
  parameter WIDTH = 32
) (
  input wire logic [WIDTH - 1:0] in,
  output logic [WIDTH - 1:0] out
);
  assign out = in;
endmodule

module std_slice #(
    parameter IN_WIDTH  = 32,
    parameter OUT_WIDTH = 32
) (
   input wire                   logic [ IN_WIDTH-1:0] in,
   output logic [OUT_WIDTH-1:0] out
);
  assign out = in[OUT_WIDTH-1:0];

  `ifdef VERILATOR
    always_comb begin
      if (IN_WIDTH < OUT_WIDTH)
        $error(
          "std_slice: Input width less than output width\n",
          "IN_WIDTH: %0d", IN_WIDTH,
          "OUT_WIDTH: %0d", OUT_WIDTH
        );
    end
  `endif
endmodule

module std_pad #(
    parameter IN_WIDTH  = 32,
    parameter OUT_WIDTH = 32
) (
   input wire logic [IN_WIDTH-1:0]  in,
   output logic     [OUT_WIDTH-1:0] out
);
  localparam EXTEND = OUT_WIDTH - IN_WIDTH;
  assign out = { {EXTEND {1'b0}}, in};

  `ifdef VERILATOR
    always_comb begin
      if (IN_WIDTH > OUT_WIDTH)
        $error(
          "std_pad: Output width less than input width\n",
          "IN_WIDTH: %0d", IN_WIDTH,
          "OUT_WIDTH: %0d", OUT_WIDTH
        );
    end
  `endif
endmodule

module std_not #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] in,
   output logic [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    not1_1 _impl(in, out);
  end
  else if (WIDTH == 5) begin
    not5_2 _impl(in, out);
  end
  else if (WIDTH == 8) begin
    not8_2 _impl(in, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_and #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    and1_2 _impl(left, right, out);
  end
  else if (WIDTH == 2) begin
    and2_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    and4_2 _impl(left, right, out);
  end
  else if (WIDTH == 8) begin
    and8_2 _impl(left, right, out);
  end
  else if (WIDTH == 16) begin
    and16_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    and32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_or #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    or1_2 _impl(left, right, out);
  end
  else if (WIDTH == 8) begin
    or8_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_xor #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  // if (WIDTH == 1) begin
  //   or1_2 _impl(left, right, out);
  // end
  // else if (WIDTH == 8) begin
  //   or8_2 _impl(left, right, out);
  // end
  // else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  // end
endmodule

module std_add #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    add1_2 _impl(left, right, out);
  end
  else if (WIDTH == 2) begin
    add2_2 _impl(left, right, out);
  end
  else if (WIDTH == 3) begin
    add3_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    add4_2 _impl(left, right, out);
  end
  else if (WIDTH == 8) begin
    add8_2 _impl(left, right, out);
  end
  else if (WIDTH == 16) begin
    add16_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    add32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end

endmodule

module std_sub #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    sub1_2 _impl(left, right, out);
  end
  else if (WIDTH == 2) begin
    sub2_2 _impl(left, right, out);
  end
  else if (WIDTH == 3) begin
    sub3_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    sub4_2 _impl(left, right, out);
  end
  else if (WIDTH == 5) begin
    sub5_2 _impl(left, right, out);
  end
  else if (WIDTH == 6) begin
    sub6_2 _impl(left, right, out);
  end
  else if (WIDTH == 7) begin
    sub7_2 _impl(left, right, out);
  end
  else if (WIDTH == 8) begin
    sub8_2 _impl(left, right, out);
  end
  else if (WIDTH == 16) begin
    sub16_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    sub32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_gt #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  if (WIDTH == 1) begin
    ugt1_2 _impl(left, right, out);
  end
  else if (WIDTH == 5) begin
    ugt5_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_lt #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  if (WIDTH == 1) begin
    ult1_2 _impl(left, right, out);
  end
  else if (WIDTH == 2) begin
    ult2_2 _impl(left, right, out);
  end
  else if (WIDTH == 3) begin
    ult3_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    ult4_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    ult32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_eq #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  if (WIDTH == 1) begin
    eq1_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    eq4_2 _impl(left, right, out);
  end
  else if (WIDTH == 5) begin
    eq5_2 _impl(left, right, out);
  end
  else if (WIDTH == 6) begin
    eq6_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    eq32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_neq #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  if (WIDTH == 1) begin
    neq1_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    neq32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_ge #(
    parameter WIDTH = 32
) (
    input wire   logic [WIDTH-1:0] left,
    input wire   logic [WIDTH-1:0] right,
    output logic out
);
  if (WIDTH == 1) begin
    uge1_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    uge4_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_le #(
    parameter WIDTH = 32
) (
   input wire   logic [WIDTH-1:0] left,
   input wire   logic [WIDTH-1:0] right,
   output logic out
);
  if (WIDTH == 1) begin
    ule1_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    ule4_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_lsh #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    shl1_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_rsh #(
    parameter WIDTH = 32
) (
   input wire               logic [WIDTH-1:0] left,
   input wire               logic [WIDTH-1:0] right,
   output logic [WIDTH-1:0] out
);

  if (WIDTH == 1) begin
    shru1_2 _mpl(left, right, out);
  end
  else if (WIDTH == 4) begin
    shru4_2 _mpl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

/// this primitive is intended to be used
/// for lowering purposes (not in source programs)
module std_mux #(
    parameter WIDTH = 32
) (
   input wire               logic cond,
   input wire               logic [WIDTH-1:0] tru,
   input wire               logic [WIDTH-1:0] fal,
   output logic [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    mux1_3 _impl(cond, tru, fal);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

/// Memories
module std_reg #(
    parameter WIDTH = 32
) (
   input wire [ WIDTH-1:0]    in,
   input wire                 write_en,
   input wire                 clk,
   input wire                 reset,
    // output
   output logic [WIDTH - 1:0] out,
   output logic               done
);
  if (WIDTH == 1) begin
    std_reg_1 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else if (WIDTH == 2) begin
    std_reg_2 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else if (WIDTH == 3) begin
    std_reg_3 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else if (WIDTH == 4) begin
    std_reg_4 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else if (WIDTH == 5) begin
    std_reg_5 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else if (WIDTH == 6) begin
    std_reg_6 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else if (WIDTH == 7) begin
    std_reg_7 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else if (WIDTH == 32) begin
    std_reg_32 impl(.clk(clk), .reset(reset), .in(in),.out(out), .done(done), .write_en(write_en));
  end
  else begin
      $error(
        "std_reg unimplemented for\n",
        "WIDTH: %0d\n", WIDTH
      );
  end

endmodule

module std_mem_d1 #(
    parameter WIDTH = 32,
    parameter SIZE = 16,
    parameter IDX_SIZE = 4
) (
   input wire                logic [IDX_SIZE-1:0] addr0,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   output logic [ WIDTH-1:0] read_data,
   output logic              done
);
  if (WIDTH == 32 && SIZE == 16 && IDX_SIZE == 4) begin
    std_mem_d1 impl(.addr0(addr0), .write_data(write_data), .write_en(write_en), .clk(clk), .read_data(read_data), .done(done));
  end
  else begin
      $error(
        "std_mem_d1 unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "SIZE: %0d\n", SIZE,
        "IDX_SIZE: %0d\n", IDX_SIZE
      );
  end

endmodule

module std_mem_d2 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4
) (
   input wire                logic [D0_IDX_SIZE-1:0] addr0,
   input wire                logic [D1_IDX_SIZE-1:0] addr1,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   output logic [ WIDTH-1:0] read_data,
   output logic              done
);
  if (WIDTH == 32 && D0_SIZE == 16 && D1_SIZE == 16 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4) begin
    std_mem_d2_32_16_16_4_4 impl(.addr0(addr0), .addr1(addr1), .write_data(write_data), .write_en(write_en), .clk(clk), .read_data(read_data), .done(done));
  end
  else begin
      $error(
        "std_mem_d2 unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "D0_SIZE: %0d\n", D0_SIZE,
        "D1_SIZE: %0d\n", D1_SIZE,
        "D0_IDX_SIZE: %0d\n", D0_IDX_SIZE,
        "D1_IDX_SIZE: %0d\n", D1_IDX_SIZE
      );
  end

endmodule

module std_mem_d3 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D2_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4,
    parameter D2_IDX_SIZE = 4
) (
   input wire                logic [D0_IDX_SIZE-1:0] addr0,
   input wire                logic [D1_IDX_SIZE-1:0] addr1,
   input wire                logic [D2_IDX_SIZE-1:0] addr2,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   output logic [ WIDTH-1:0] read_data,
   output logic              done
);
  if (WIDTH == 32 && D0_SIZE == 16 && D1_SIZE == 16 && D2_SIZE == 16 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4 && D2_IDX_SIZE == 4) begin
    std_mem_d3_32_16_16_16_4_4_4 impl(.addr0(addr0), .addr1(addr1), .addr2(addr2), .write_data(write_data), .write_en(write_en), .clk(clk), .read_data(read_data), .done(done));
  end
  else begin
      $error(
        "std_mem_d3 unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "D0_SIZE: %0d\n", D0_SIZE,
        "D1_SIZE: %0d\n", D1_SIZE,
        "D2_SIZE: %0d\n", D2_SIZE,
        "D0_IDX_SIZE: %0d\n", D0_IDX_SIZE,
        "D1_IDX_SIZE: %0d\n", D1_IDX_SIZE,
        "D2_IDX_SIZE: %0d\n", D2_IDX_SIZE
      );
  end
endmodule

module std_mem_d4 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D2_SIZE = 16,
    parameter D3_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4,
    parameter D2_IDX_SIZE = 4,
    parameter D3_IDX_SIZE = 4
) (
   input wire                logic [D0_IDX_SIZE-1:0] addr0,
   input wire                logic [D1_IDX_SIZE-1:0] addr1,
   input wire                logic [D2_IDX_SIZE-1:0] addr2,
   input wire                logic [D3_IDX_SIZE-1:0] addr3,
   input wire                logic [ WIDTH-1:0] write_data,
   input wire                logic write_en,
   input wire                logic clk,
   output logic [ WIDTH-1:0] read_data,
   output logic              done
);
  if (WIDTH == 32 && D0_SIZE == 16 && D1_SIZE == 16 && D2_SIZE == 16 && D3_SIZE == 16 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4 && D2_IDX_SIZE == 4 && D3_IDX_SIZE == 4) begin
    std_mem_d4_32_16_16_16_16_4_4_4_4 impl(.addr0(addr0), .addr1(addr1), .addr2(addr2), .addr3(addr3), .write_data(write_data), .write_en(write_en), .clk(clk), .read_data(read_data), .done(done));
  end
  else begin
      $error(
        "std_mem_d4 unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "D0_SIZE: %0d\n", D0_SIZE,
        "D1_SIZE: %0d\n", D1_SIZE,
        "D2_SIZE: %0d\n", D2_SIZE,
        "D3_SIZE: %0d\n", D3_SIZE,
        "D0_IDX_SIZE: %0d\n", D0_IDX_SIZE,
        "D1_IDX_SIZE: %0d\n", D1_IDX_SIZE,
        "D2_IDX_SIZE: %0d\n", D2_IDX_SIZE,
        "D3_IDX_SIZE: %0d\n", D3_IDX_SIZE
      );
  end
endmodule

`default_nettype wire
