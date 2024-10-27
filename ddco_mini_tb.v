`timescale 1ns/1ps

module TrafficLight_tb;

    // Declare inputs as regs
    reg clk;
    reg reset;

    // Declare outputs as wires
    wire [1:0] light_n; // North light
    wire [1:0] light_e; // East light
    wire [1:0] light_s; // South light
    wire [1:0] light_w; // West light

    // Instantiate the TrafficLight module
    TrafficLight DUT (
        .clk(clk),
        .reset(reset),
        .light_n(light_n),
        .light_e(light_e),
        .light_s(light_s),
        .light_w(light_w)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Toggle clock every 5 ns
    end

    // Test sequence
    initial begin
        // Initialize inputs
        reset = 1; // Start with reset asserted
        
        // Wait for a few clock cycles to stabilize after reset
        #10;
        
        reset = 0; // Release reset
        
        // Run the simulation for enough time to observe all states
        #3000;  // Adjust this duration based on your timing requirements
        
        // End simulation after sufficient time has passed
        $stop; 
    end

    // Monitor outputs with timestamps
    initial begin
        $monitor("Time: %t | North Light: %b | East Light: %b | South Light: %b | West Light: %b", 
                 $time, light_n, light_e, light_s, light_w);
    end

    initial begin
    $dumpfile("trafficlight.vcd");
    $dumpvars(0,TrafficLight_tb);
    end
    

endmodule