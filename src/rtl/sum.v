// Filename: sourcecode/rtl/sum.v

`timescale 1ns/1ps

module Sum_mod #(
    parameter NOF_BITS = 32
) (
    input wire clk,
    input wire rst_n,
    input wire data_first,
    input wire data_last,
    input wire [NOF_BITS-1:0] data_in,
    output reg [NOF_BITS:0] data_out,
    output reg busy,    
    output reg done     
);

    // Internal Registers
    reg [NOF_BITS:0] current_total;
    reg [NOF_BITS:0] current_total_next;
    
    // Next state signals for outputs
    reg [NOF_BITS:0] out_val_next;
    reg busy_flag_next;
    reg done_flag_next;

    // --------------------------------------------------------
    // SEQUENTIAL BLOCK (Registers)
    // --------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            busy          <= 1'b0;
            done          <= 1'b0;
            current_total <= {(NOF_BITS+1){1'b0}};
            data_out      <= {(NOF_BITS+1){1'b0}};
        end else begin
            busy          <= busy_flag_next;
            done          <= done_flag_next;
            current_total <= current_total_next;
            data_out      <= out_val_next;
        end
    end

    // --------------------------------------------------------
    // COMBINATIONAL BLOCK (Next State Logic)
    // --------------------------------------------------------
    
    // 1. Busy Logic
    always @(*) begin
        // Default behavior: hold value
        busy_flag_next = busy; 
        
        if (data_last) begin
            busy_flag_next = 1'b0;
        end else if (data_first) begin
            busy_flag_next = 1'b1;
        end
    end

    // 2. Accumulator Logic
    always @(*) begin
        // Default behavior: hold value
        current_total_next = current_total;

        if (data_first) begin
            // Reset accumulator with new data
            current_total_next = {1'b0, data_in};
        end else if (busy && !data_last) begin
            // Add to accumulator
            current_total_next = current_total + {1'b0, data_in};
        end
    end

    // 3. Output & Done Logic
    always @(*) begin
        // Defaults
        out_val_next = data_out;
        done_flag_next = 1'b0;

        if (data_last) begin
            done_flag_next = 1'b1; // Pulse done high
            
            // Calculate final result directly to output
            if (data_first) begin
                // Case: Sequence length is 1
                out_val_next = {1'b0, data_in};
            end else begin
                // Case: Sequence length > 1
                out_val_next = current_total + {1'b0, data_in};
            end
        end
    end

endmodule