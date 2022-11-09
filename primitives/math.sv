module fp_sqrt #(
    parameter WIDTH = 32,
    parameter INT_WIDTH = 16,
    parameter FRAC_WIDTH = 16
) (
    input  logic             clk,
    input  logic             reset,
    input  logic             go,
    input  logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out,
    output logic             done
);

  if (WIDTH == 32 && INT_WIDTH == 32 && FRAC_WIDTH == 0) begin
    fp_sqrt_32_32_0 impl(.clk(clk), .reset(reset), .go(go),.in(in),.out(out),.done(done));
  end
  else if (WIDTH == 32 && INT_WIDTH == 16 && FRAC_WIDTH == 16) begin
    fp_sqrt_32_16_16 impl(.clk(clk), .reset(reset), .go(go),.in(in),.out(out),.done(done));
  end
  else begin
      $error(
        "fp_sqrt unimplemented for\n",
        "WIDTH: %0d\n", WIDTH,
        "INT_WIDTH: %0d\n", INT_WIDTH,
        "FRAC_WIDTH: %0d\n", FRAC_WIDTH
      );
  end

endmodule

module sqrt #(
    parameter WIDTH = 32
) (
    input  logic             clk,
    input  logic             go,
    input  logic             reset,
    input  logic [WIDTH-1:0] in,
    output logic [WIDTH-1:0] out,
    output logic             done
);
  fp_sqrt #(
    .WIDTH(WIDTH),
    .INT_WIDTH(WIDTH),
    .FRAC_WIDTH(0)
  ) comp (
    .clk(clk),
    .done(done),
    .reset(reset),
    .go(go),
    .in(in),
    .out(out)
  );

  // Simulation self test against unsynthesizable implementation.
  `ifdef VERILATOR
    logic [WIDTH-1:0] radicand;
    always_ff @(posedge clk) begin
      if (go)
        radicand <= in;
      else
        radicand <= radicand;
    end

    always @(posedge clk) begin
      if (done && out != $floor($sqrt(radicand)))
        $error(
          "\nsqrt: Computed and golden outputs do not match!\n",
          "input: %0d\n", radicand,
          /* verilator lint_off REALCVT */
          "expected: %0d\n", $floor($sqrt(radicand)),
          "computed: %0d", out
        );
    end
  `endif
endmodule
