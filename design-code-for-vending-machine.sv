
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
