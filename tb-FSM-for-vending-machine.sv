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
