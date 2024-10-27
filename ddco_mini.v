module TrafficLight(
    input clk,
    input reset,
    output reg [1:0] light_n, // North light
    output reg [1:0] light_e,  // East light
    output reg [1:0] light_s, // South light
    output reg [1:0] light_w  // West light
);

reg [3:0] state;
parameter GREEN_N = 4'b0000, YELLOW_N = 4'b0001, 
          GREEN_E = 4'b0010, YELLOW_E = 4'b0011, 
          GREEN_S = 4'b0100, YELLOW_S = 4'b0101, 
          GREEN_W = 4'b0110, YELLOW_W = 4'b0111, 
          RED = 4'b1000; // Define all state parameters

reg [3:0] timer;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= GREEN_N;
        timer <= 4'd10; // Start with a green light for 10 cycles
    end else begin
        case (state)
            GREEN_N: if (timer == 0) begin
                        state <= YELLOW_N; timer <= 4'd2; // Switch to yellow for 2 cycles
                      end
                      else timer <= timer - 1;
            YELLOW_N: if (timer == 0) begin
                         state <= GREEN_E; timer <= 4'd10; // Switch to green for east-west
                       end
                       else timer <= timer - 1;
            GREEN_E: if (timer == 0) begin
                        state <= YELLOW_E; timer <= 4'd2; // Switch to yellow for 2 cycles
                      end
                      else timer <= timer - 1;
            YELLOW_E: if (timer == 0) begin
                         state <= GREEN_S; timer <= 4'd10; // Switch to green for south
                       end
                       else timer <= timer - 1;
            GREEN_S: if (timer == 0) begin
                        state <= YELLOW_S; timer <= 4'd2; // Switch to yellow for 2 cycles
                      end
                      else timer <= timer - 1;
            YELLOW_S: if (timer == 0) begin
                         state <= GREEN_W; timer <= 4'd10; // Switch to green for west
                       end
                       else timer <= timer - 1;
            GREEN_W: if (timer == 0) begin
                        state <= YELLOW_W; timer <= 4'd2; // Switch to yellow for 2 cycles
                      end
                      else timer <= timer - 1;
            YELLOW_W: if (timer == 0) begin
                         state <= GREEN_N; timer <= 4'd10; // Switch to green for north
                       end
                       else timer <= timer - 1;
            default: state <= GREEN_N; 
        endcase
    end
end

always @(*) begin
    // Set output light states based on current state
    case (state)
        GREEN_N: begin light_n = 2'b10; light_e = 2'b00; light_s = 2'b00; light_w = 2'b00; end // North green
        YELLOW_N: begin light_n = 2'b01; light_e = 2'b00; light_s = 2'b00; light_w = 2'b00; end // North yellow
        GREEN_E: begin light_n = 2'b00; light_e = 2'b10; light_s = 2'b00; light_w = 2'b00; end // East green
        YELLOW_E: begin light_n = 2'b00; light_e = 2'b01; light_s = 2'b00; light_w = 2'b00; end // East yellow
        GREEN_S: begin light_n = 2'b00; light_e = 2'b00; light_s = 2'b10; light_w = 2'b00; end // South green
        YELLOW_S: begin light_n = 2'b00; light_e = 2'b00; light_s = 2'b01; light_w = 2'b00; end // South yellow
        GREEN_W: begin light_n = 2'b00; light_e = 2'b00; light_s = 2'b00; light_w = 2'b10; end // West green
        YELLOW_W: begin light_n = 2'b00; light_e = 2'b00; light_s = 2'b00; light_w = 2'b01; end // West yellow
        default: begin light_n = 2'b00; light_e = 2'b00; light_s = 2'b00; light_w = 2'b00; end // Red
    endcase
end

endmodule
