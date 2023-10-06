module vending_machine_tb;

  // Inputs
  reg clk;
  reg [1:0] in;
  reg rst;

  // Outputs
  wire out;
  wire [1:0] change;

  // Instantiate the vending_machine module
  vending_machine vm (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),
    .change(change)
  );

  initial begin
    // Initialize inputs
    $dumpfile(""); // Specify VCD dump file
    $dumpvars();          // Dump module variables
    rst = 1;
    clk = 0;

    #6 rst = 0;     // Deassert reset after 6 time units
    in = 1;         // Insert 5 rs
    #11 in = 1;     // Keep 5 rs inserted for 11 more time units
    #16 in = 1;     // Keep 5 rs inserted for 16 more time units
    #25 $finish;    // End simulation after 25 time units
  end

  // Generate clock signal with a period of 10 time units
  always #5 clk = ~clk;

endmodule
/*
Explanation:

- The `vending_machine_tb` module is a test bench for the `vending_machine` module you provided earlier.
- It instantiates the vending machine (`uut`) and connects its ports to the test bench's signals.
- The initial block initializes the simulation environment.
- `$dumpfile("vending_machine_18105070.vcd");` specifies the name of the VCD file to which simulation data will be written.
- `$dumpvars(0, vending_machine_tb);` specifies which variables to include in the VCD file for waveform dumping.
- `rst` is set to 1 initially to reset the vending machine.
- `clk` is initialized to 0.
- `#6 rst = 0;` asserts the reset signal for 6 time units and then deasserts it to start the simulation.
- `in` is set to 1, indicating that 5 rs are inserted into the vending machine.
- The subsequent time delays (`#11` and `#16`) simulate the inserted money being present in the machine for specific durations.
- `$finish;` ends the simulation after 25 time units.
- The `always #5 clk = ~clk;` generates a clock signal with a period of 10 time units (5 units high, 5 units low), effectively toggling the clock signal.
*/



















































module vending_machine(
  input clk,
  input rst,
  input [1:0] in,      // 01 = 5 rs, 10 = 10 rs
  output reg out,
  output reg [1:0] change
);

parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;

reg [1:0] c_state, n_state;

always @(posedge clk)
begin
  if (rst == 1)
  begin
    c_state = s0;       // Initialize current state to s0
    n_state = s0;
    change = 2'b00;     // Initialize change to 0 rs
    out = 0;            // Initialize output to 0
  end
  else
    c_state = n_state;

  case (c_state)
    s0:  // State 0: 0 rs
      if (in == 2'b00)
      begin
        n_state = s0;    // Stay in state s0
        out = 0;         // No output
        change = 2'b00;  // No change returned
      end
      else if (in == 2'b01)
      begin
        n_state = s1;    // Move to state s1 (5 rs)
        out = 0;         // No output
        change = 2'b00;  // No change returned
      end
      else if (in == 2'b10)
      begin
        n_state = s2;    // Move to state s2 (10 rs)
        out = 0;         // No output
        change = 2'b00;  // No change returned
      end
    s1:  // State 1: 5 rs
      if (in == 2'b00)
      begin
        n_state = s0;    // Move to state s0 (0 rs)
        out = 0;         // No output
        change = 2'b01;  // Change returned: 5 rs
      end
      else if (in == 2'b01)
      begin
        n_state = s2;    // Move to state s2 (10 rs)
        out = 0;         // No output
        change = 2'b00;  // No change returned
      end
      else if (in == 2'b10)
      begin
        n_state = s0;    // Move to state s0 (0 rs)
        out = 1;         // Output: 1 bottle
        change = 2'b00;  // No change returned
      end
    s2:  // State 2: 10 rs
      if (in == 2'b00)
      begin
        n_state = s0;    // Move to state s0 (0 rs)
        out = 0;         // No output
        change = 2'b10;  // Change returned: 10 rs
      end
      else if (in == 2'b01)
      begin
        n_state = s0;    // Move to state s0 (0 rs)
        out = 1;         // Output: 1 bottle
        change = 2'b00;  // No change returned
      end
      else if (in == 2'b10)
      begin
        n_state = s0;    // Move to state s0 (0 rs)
        out = 1;         // Output: 1 bottle
        change = 2'b01;  // Change returned: 5 rs
      end
  endcase
end

endmodule


/*
Explanation:

- This module models a vending machine that takes inputs (`in`) representing the amount of money inserted (00 for 0 rs, 01 for 5 rs, and 10 for 10 rs).
- It has three states (`s0`, `s1`, and `s2`) that correspond to different amounts of money inserted.
- The `c_state` and `n_state` registers store the current and next states, respectively.
- The module responds to clock (`clk`) edges and reset (`rst`) signals.
- Depending on the current state and input, the module updates the current state, output (`out`), and change (`change`) returned to the user.
*/
