/**
Implements a memory with sequential reads and writes.
- Both reads and writes take one cycle to perform.
- Attempting to read and write at the same time is an error.
- The out signal is registered to the last value requested by the read_en signal.
- The out signal is undefined once write_en is asserted.
*/
module seq_mem_d1 #(
    parameter WIDTH = 32,
    parameter SIZE = 16,
    parameter IDX_SIZE = 4
) (
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [IDX_SIZE-1:0] addr0,

   // Read signal
   input wire logic read_en,
   output logic [ WIDTH-1:0] out,
   output logic read_done,

   // Write signals
   input wire logic [ WIDTH-1:0] in,
   input wire logic write_en,
   output logic write_done
);
  if (WIDTH == 32 && SIZE == 16 && IDX_SIZE == 4) begin
    seq_mem_d1_32_16_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else begin
      $error(
        "seq_mem_d1 unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "SIZE: %0d\n", SIZE,
        "IDX_SIZE: %0d\n", IDX_SIZE
      );
  end
endmodule

module seq_mem_d2 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4
) (
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [D0_IDX_SIZE-1:0] addr0,
   input wire logic [D1_IDX_SIZE-1:0] addr1,

   // Read signal
   input wire logic read_en,
   output logic [WIDTH-1:0] out,
   output logic read_done,

   // Write signals
   input wire logic write_en,
   input wire logic [ WIDTH-1:0] in,
   output logic write_done
);
  if (WIDTH == 32 && D0_SIZE == 16 && D1_SIZE == 16 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4) begin
    seq_mem_d2_32_16_16_4_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && D0_SIZE == 1 && D1_SIZE == 2 && D0_IDX_SIZE == 1 && D1_IDX_SIZE == 2) begin
    seq_mem_d2_32_1_2_1_2 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && D0_SIZE == 1 && D1_SIZE == 4 && D0_IDX_SIZE == 1 && D1_IDX_SIZE == 3) begin
    seq_mem_d2_32_1_4_1_3 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && D0_SIZE == 1 && D1_SIZE == 6 && D0_IDX_SIZE == 1 && D1_IDX_SIZE == 3) begin
    seq_mem_d2_32_1_6_1_3 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && D0_SIZE == 1 && D1_SIZE == 8 && D0_IDX_SIZE == 1 && D1_IDX_SIZE == 4) begin
    seq_mem_d2_32_1_8_1_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && D0_SIZE == 8 && D1_SIZE == 8 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4) begin
    seq_mem_d2_32_8_8_4_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && D0_SIZE == 12 && D1_SIZE == 8 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4) begin
    seq_mem_d2_32_12_8_4_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && D0_SIZE == 8 && D1_SIZE == 12 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4) begin
    seq_mem_d2_32_8_12_4_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else begin
      $error(
        "seq_mem_d2 unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "D0_SIZE: %0d\n", D0_SIZE,
        "D1_SIZE: %0d\n", D1_SIZE,
        "D0_IDX_SIZE: %0d\n", D0_IDX_SIZE,
        "D1_IDX_SIZE: %0d\n", D1_IDX_SIZE
      );
  end
endmodule

module seq_mem_d3 #(
    parameter WIDTH = 32,
    parameter D0_SIZE = 16,
    parameter D1_SIZE = 16,
    parameter D2_SIZE = 16,
    parameter D0_IDX_SIZE = 4,
    parameter D1_IDX_SIZE = 4,
    parameter D2_IDX_SIZE = 4
) (
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [D0_IDX_SIZE-1:0] addr0,
   input wire logic [D1_IDX_SIZE-1:0] addr1,
   input wire logic [D2_IDX_SIZE-1:0] addr2,

   // Read signal
   input wire logic read_en,
   output logic [WIDTH-1:0] out,
   output logic read_done,

   // Write signals
   input wire logic write_en,
   input wire logic [ WIDTH-1:0] in,
   output logic write_done
);
  if (WIDTH == 32 && D0_SIZE == 16 && D1_SIZE == 16 && D2_SIZE == 16 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4 && D2_IDX_SIZE == 4) begin
    seq_mem_d3_32_16_16_16_4_4_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .addr2(addr2), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else begin
      $error(
        "seq_mem_d3 unimplemented for\n",
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

module seq_mem_d4 #(
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
   // Common signals
   input wire logic clk,
   input wire logic reset,
   input wire logic [D0_IDX_SIZE-1:0] addr0,
   input wire logic [D1_IDX_SIZE-1:0] addr1,
   input wire logic [D2_IDX_SIZE-1:0] addr2,
   input wire logic [D3_IDX_SIZE-1:0] addr3,

   // Read signal
   input wire logic read_en,
   output logic [WIDTH-1:0] out,
   output logic read_done,

   // Write signals
   input wire logic write_en,
   input wire logic [ WIDTH-1:0] in,
   output logic write_done
);
  if (WIDTH == 32 && D0_SIZE == 16 && D1_SIZE == 16 && D2_SIZE == 16 && D3_SIZE == 16 && D0_IDX_SIZE == 4 && D1_IDX_SIZE == 4 && D2_IDX_SIZE == 4 && D3_IDX_SIZE == 4) begin
    seq_mem_d4_32_16_16_16_16_4_4_4_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .addr1(addr1), .addr2(addr2), .addr3(addr3), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else begin
      $error(
        "seq_mem_d3 unimplemented for\n",
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
