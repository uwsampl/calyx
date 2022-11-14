/* verilator lint_off MULTITOP */
/// =================== Unsigned, Fixed Point =========================
module std_fp_add #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out
);
  if (WIDTH == 32 && INT_WIDTH == 16 && FRAC_WIDTH == 16) begin
    std_fp_add_32_16_16 impl(.left(left), .right(right), .out(out));
  end
  else if (WIDTH == 32 && INT_WIDTH == 1 && FRAC_WIDTH == 31) begin
    std_fp_add_32_1_31 impl(.left(left), .right(right), .out(out));
  end
  else begin
      $error(
        "std_fp_add unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "INT_WIDTH: %0d\n", INT_WIDTH,
        "FRAC_WIDTH: %0d\n", FRAC_WIDTH
      );
  end
endmodule

module std_fp_sub #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out
);
  if (WIDTH == 32 && INT_WIDTH == 16 && FRAC_WIDTH == 16) begin
    std_fp_sub_32_16_16 impl(.left(left), .right(right), .out(out));
  end
  else if (WIDTH == 32 && INT_WIDTH == 1 && FRAC_WIDTH == 31) begin
    std_fp_sub_32_1_31 impl(.left(left), .right(right), .out(out));
  end
  else begin
      $error(
        "std_fp_sub unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "INT_WIDTH: %0d\n", INT_WIDTH,
        "FRAC_WIDTH: %0d\n", FRAC_WIDTH
      );
  end

endmodule

module std_fp_mult_pipe #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16,
    parameter SIGNED = 0
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    input  logic             go,
    input  logic             clk,
    input  logic             reset,
    output logic [WIDTH-1:0] out,
    output logic             done
);
  if (WIDTH == 32 && INT_WIDTH == 16 && FRAC_WIDTH == 16 && SIGNED == 0) begin
    std_fp_mult_pipe_32_16_16_0 impl(.left(left), .right(right), .out(out), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 32 && INT_WIDTH == 16 && FRAC_WIDTH == 16 && SIGNED == 1) begin
    std_fp_mult_pipe_32_16_16_1 impl(.left(left), .right(right), .out(out), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 32 && INT_WIDTH == 32 && FRAC_WIDTH == 0 && SIGNED == 0) begin
    std_fp_mult_pipe_32_32_0_0 impl(.left(left), .right(right), .out(out), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 32 && INT_WIDTH == 32 && FRAC_WIDTH == 0 && SIGNED == 1) begin
    std_fp_mult_pipe_32_32_0_1 impl(.left(left), .right(right), .out(out), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 32 && INT_WIDTH == 1 && FRAC_WIDTH == 31 && SIGNED == 0) begin
    std_fp_mult_pipe_32_1_31_0 impl(.left(left), .right(right), .out(out), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 4 && INT_WIDTH == 2 && FRAC_WIDTH == 2 && SIGNED == 1) begin
    std_fp_mult_pipe_4_2_2_1 impl(.left(left), .right(right), .out(out), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 4 && INT_WIDTH == 4 && FRAC_WIDTH == 0 && SIGNED == 1) begin
    std_fp_mult_pipe_4_4_0_1 impl(.left(left), .right(right), .out(out), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else begin
      $error(
        "std_fp_mult_pipe unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "INT_WIDTH: %0d\n", INT_WIDTH,
        "FRAC_WIDTH: %0d\n", FRAC_WIDTH,
        "SIGNED: %0d\n", SIGNED
      );
  end

endmodule

/* verilator lint_off WIDTH */
module std_fp_div_pipe #(
  parameter WIDTH = 32,
  parameter INT_WIDTH = 16,
  parameter FRAC_WIDTH = 16
) (
    input  logic             go,
    input  logic             clk,
    input  logic             reset,
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out_remainder,
    output logic [WIDTH-1:0] out_quotient,
    output logic             done
);
  if (WIDTH == 32 && INT_WIDTH == 16 && FRAC_WIDTH == 16) begin
    std_fp_div_pipe_32_16_16 impl(.left(left), .right(right), .out_remainder(out_remainder), .out_quotient(out_quotient), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 32 && INT_WIDTH == 1 && FRAC_WIDTH == 31) begin
    std_fp_div_pipe_32_1_31 impl(.left(left), .right(right), .out_remainder(out_remainder), .out_quotient(out_quotient), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 4 && INT_WIDTH == 2 && FRAC_WIDTH == 2) begin
    std_fp_div_pipe_4_2_2 impl(.left(left), .right(right), .out_remainder(out_remainder), .out_quotient(out_quotient), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else if (WIDTH == 32 && INT_WIDTH == 24 && FRAC_WIDTH == 8) begin
    std_fp_div_pipe_32_24_8 impl(.left(left), .right(right), .out_remainder(out_remainder), .out_quotient(out_quotient), .go(go), .clk(clk), .reset(reset), .done(done));
  end
  else begin
      $error(
        "std_fp_div_pipe unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "INT_WIDTH: %0d\n", INT_WIDTH,
        "FRAC_WIDTH: %0d\n", FRAC_WIDTH
      );
  end

endmodule

module std_fp_gt #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    output logic             out
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

/// =================== Signed, Fixed Point =========================
module std_fp_sadd #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    sadd1_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    sadd4_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    sadd32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_fp_ssub #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  if (WIDTH == 1) begin
    ssub1_2 _impl(left, right, out);
  end
  else if (WIDTH == 4) begin
    ssub4_2 _impl(left, right, out);
  end
  else if (WIDTH == 32) begin
    ssub32_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_fp_smult_pipe #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  [WIDTH-1:0]              left,
    input  [WIDTH-1:0]              right,
    input  logic                    reset,
    input  logic                    go,
    input  logic                    clk,
    output logic [WIDTH-1:0]        out,
    output logic                    done
);
  std_fp_mult_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(INT_WIDTH),
    .FRAC_WIDTH(FRAC_WIDTH),
    .SIGNED(1)
  ) comp (
    .clk(clk),
    .done(done),
    .reset(reset),
    .go(go),
    .left(left),
    .right(right),
    .out(out)
  );
endmodule

module std_fp_sdiv_pipe #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input                     clk,
    input                     go,
    input                     reset,
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out_quotient,
    output signed [WIDTH-1:0] out_remainder,
    output logic              done
);

  logic signed [WIDTH-1:0] left_abs, right_abs, comp_out_q, comp_out_r, right_save, out_rem_intermediate;

  // Registers to figure out how to transform outputs.
  logic different_signs, left_sign, right_sign;

  // Latch the value of control registers so that their available after
  // go signal becomes low.
  always_ff @(posedge clk) begin
    if (go) begin
      right_save <= right_abs;
      left_sign <= left[WIDTH-1];
      right_sign <= right[WIDTH-1];
    end else begin
      left_sign <= left_sign;
      right_save <= right_save;
      right_sign <= right_sign;
    end
  end

  assign right_abs = right[WIDTH-1] ? -right : right;
  assign left_abs = left[WIDTH-1] ? -left : left;

  assign different_signs = left_sign ^ right_sign;
  assign out_quotient = different_signs ? -comp_out_q : comp_out_q;

  // Remainder is computed as:
  //  t0 = |left| % |right|
  //  t1 = if left * right < 0 and t0 != 0 then |right| - t0 else t0
  //  rem = if right < 0 then -t1 else t1
  assign out_rem_intermediate = different_signs & |comp_out_r ? $signed(right_save - comp_out_r) : comp_out_r;
  assign out_remainder = right_sign ? -out_rem_intermediate : out_rem_intermediate;

  std_fp_div_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(INT_WIDTH),
    .FRAC_WIDTH(FRAC_WIDTH)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left_abs),
    .right(right_abs),
    .out_quotient(comp_out_q),
    .out_remainder(comp_out_r)
  );
endmodule

module std_fp_sgt #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic signed [WIDTH-1:0] left,
    input  logic signed [WIDTH-1:0] right,
    output logic signed             out
);
  if (WIDTH == 1) begin
    sgt1_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

module std_fp_slt #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
   input logic signed [WIDTH-1:0] left,
   input logic signed [WIDTH-1:0] right,
   output logic signed            out
);
  if (WIDTH == 1) begin
    slt1_2 _impl(left, right, out);
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

/// =================== Unsigned, Bitnum =========================
module std_mult_pipe #(
    parameter WIDTH = 32
) (
    input  logic [WIDTH-1:0] left,
    input  logic [WIDTH-1:0] right,
    input  logic             reset,
    input  logic             go,
    input  logic             clk,
    output logic [WIDTH-1:0] out,
    output logic             done
);
  std_fp_mult_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(WIDTH),
    .FRAC_WIDTH(0),
    .SIGNED(0)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left),
    .right(right),
    .out(out)
  );
endmodule

module std_div_pipe #(
    parameter WIDTH = 32
) (
    input                    reset,
    input                    clk,
    input                    go,
    input        [WIDTH-1:0] left,
    input        [WIDTH-1:0] right,
    output logic [WIDTH-1:0] out_remainder,
    output logic [WIDTH-1:0] out_quotient,
    output logic             done
);
  if (WIDTH == 4) begin
    std_div_pipe_4 _impl(.reset(reset), .clk(clk), .go(go), .left(left), .right(right), .out_remainder(out_remainder), .out_quotient(out_quotient), .done(done));
  end
  else if (WIDTH == 32) begin
    std_div_pipe_32 _impl(.reset(reset), .clk(clk), .go(go), .left(left), .right(right), .out_remainder(out_remainder), .out_quotient(out_quotient), .done(done));
  end
  else begin
    $error("Unsupported bitwidth %0d", WIDTH);
  end
endmodule

/// =================== Signed, Bitnum =========================
module std_sadd #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = $signed(left + right);
endmodule

module std_ssub #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = $signed(left - right);
endmodule

module std_smult_pipe #(
    parameter WIDTH = 32
) (
    input  logic                    reset,
    input  logic                    go,
    input  logic                    clk,
    input  signed       [WIDTH-1:0] left,
    input  signed       [WIDTH-1:0] right,
    output logic signed [WIDTH-1:0] out,
    output logic                    done
);
  std_fp_mult_pipe #(
    .WIDTH(WIDTH),
    .INT_WIDTH(WIDTH),
    .FRAC_WIDTH(0),
    .SIGNED(1)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left),
    .right(right),
    .out(out)
  );
endmodule

/* verilator lint_off WIDTH */
module std_sdiv_pipe #(
    parameter WIDTH = 32
) (
    input                           reset,
    input                           clk,
    input                           go,
    input  logic signed [WIDTH-1:0] left,
    input  logic signed [WIDTH-1:0] right,
    output logic signed [WIDTH-1:0] out_quotient,
    output logic signed [WIDTH-1:0] out_remainder,
    output logic                    done
);

  logic signed [WIDTH-1:0] left_abs, right_abs, comp_out_q, comp_out_r, right_save, out_rem_intermediate;

  // Registers to figure out how to transform outputs.
  logic different_signs, left_sign, right_sign;

  // Latch the value of control registers so that their available after
  // go signal becomes low.
  always_ff @(posedge clk) begin
    if (go) begin
      right_save <= right_abs;
      left_sign <= left[WIDTH-1];
      right_sign <= right[WIDTH-1];
    end else begin
      left_sign <= left_sign;
      right_save <= right_save;
      right_sign <= right_sign;
    end
  end

  assign right_abs = right[WIDTH-1] ? -right : right;
  assign left_abs = left[WIDTH-1] ? -left : left;

  assign different_signs = left_sign ^ right_sign;
  assign out_quotient = different_signs ? -comp_out_q : comp_out_q;

  // Remainder is computed as:
  //  t0 = |left| % |right|
  //  t1 = if left * right < 0 and t0 != 0 then |right| - t0 else t0
  //  rem = if right < 0 then -t1 else t1
  assign out_rem_intermediate = different_signs & |comp_out_r ? $signed(right_save - comp_out_r) : comp_out_r;
  assign out_remainder = right_sign ? -out_rem_intermediate : out_rem_intermediate;

  std_div_pipe #(
    .WIDTH(WIDTH)
  ) comp (
    .reset(reset),
    .clk(clk),
    .done(done),
    .go(go),
    .left(left_abs),
    .right(right_abs),
    .out_quotient(comp_out_q),
    .out_remainder(comp_out_r)
  );

  // Simulation self test against unsynthesizable implementation.
  `ifdef VERILATOR
    logic signed [WIDTH-1:0] l, r;
    always_ff @(posedge clk) begin
      if (go) begin
        l <= left;
        r <= right;
      end else begin
        l <= l;
        r <= r;
      end
    end

    always @(posedge clk) begin
      if (done && out_quotient != $signed(l / r))
        $error(
          "\nstd_sdiv_pipe (Quotient): Computed and golden outputs do not match!\n",
          "left: %0d", l,
          "  right: %0d\n", r,
          "expected: %0d", $signed(l / r),
          "  computed: %0d", $signed(out_quotient),
        );
      if (done && out_remainder != $signed(((l % r) + r) % r))
        $error(
          "\nstd_sdiv_pipe (Remainder): Computed and golden outputs do not match!\n",
          "left: %0d", l,
          "  right: %0d\n", r,
          "expected: %0d", $signed(((l % r) + r) % r),
          "  computed: %0d", $signed(out_remainder),
        );
    end
  `endif
endmodule

module std_sgt #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left > right);
endmodule

module std_slt #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left < right);
endmodule

module std_seq #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left == right);
endmodule

module std_sneq #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left != right);
endmodule

module std_sge #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left >= right);
endmodule

module std_sle #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed             out
);
  assign out = $signed(left <= right);
endmodule

module std_slsh #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = left <<< right;
endmodule

module std_srsh #(
    parameter WIDTH = 32
) (
    input  signed [WIDTH-1:0] left,
    input  signed [WIDTH-1:0] right,
    output signed [WIDTH-1:0] out
);
  assign out = left >>> right;
endmodule
