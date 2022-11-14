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
  if (WIDTH == 32 && SIZE == 2 && IDX_SIZE == 3) begin
    seq_mem_d1_32_2_3 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 4 && IDX_SIZE == 4) begin
    seq_mem_d1_32_4_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 6 && IDX_SIZE == 4) begin
    seq_mem_d1_32_6_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 8 && IDX_SIZE == 5) begin
    seq_mem_d1_32_8_5 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 16 && IDX_SIZE == 4) begin
    seq_mem_d1_32_16_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 64 && IDX_SIZE == 8) begin
    seq_mem_d1_32_64_8 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 96 && IDX_SIZE == 8) begin
    seq_mem_d1_32_96_8 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 1 && IDX_SIZE == 2) begin
    seq_mem_d1_32_1_2 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 8 && IDX_SIZE == 4) begin
    seq_mem_d1_32_8_4 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
  end
  else if (WIDTH == 32 && SIZE == 144 && IDX_SIZE == 8) begin
    seq_mem_d1_32_144_8 impl(.clk(clk), .reset(reset), .addr0(addr0), .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), .write_done(write_done));
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
  wire [D0_IDX_SIZE+D1_IDX_SIZE-1:0] addr;
  assign addr = addr0 * D1_SIZE + addr1;

  seq_mem_d1 #(.WIDTH(WIDTH), .SIZE(D0_SIZE * D1_SIZE), .IDX_SIZE(D0_IDX_SIZE+D1_IDX_SIZE)) mem
     (.clk(clk), .reset(reset), .addr0(addr), 
    .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), 
    .write_done(write_done));
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
  wire [D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE-1:0] addr;
  assign addr = addr0 * (D1_SIZE * D2_SIZE) + addr1 * (D2_SIZE) + addr2;

  seq_mem_d1 #(.WIDTH(WIDTH), .SIZE(D0_SIZE * D1_SIZE * D2_SIZE), .IDX_SIZE(D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE)) mem
     (.clk(clk), .reset(reset), .addr0(addr), 
    .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), 
    .write_done(write_done));
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
  wire [D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE+D3_IDX_SIZE-1:0] addr;
  assign addr = addr0 * (D1_SIZE * D2_SIZE * D3_SIZE) + addr1 * (D2_SIZE * D3_SIZE) + addr2 * (D3_SIZE) + addr3;

  seq_mem_d1 #(.WIDTH(WIDTH), .SIZE(D0_SIZE * D1_SIZE * D2_SIZE * D3_SIZE), .IDX_SIZE(D0_IDX_SIZE+D1_IDX_SIZE+D2_IDX_SIZE+D3_IDX_SIZE)) mem
     (.clk(clk), .reset(reset), .addr0(addr), 
    .read_en(read_en), .out(out), .read_done(read_done), .in(in), .write_en(write_en), 
    .write_done(write_done));
endmodule
