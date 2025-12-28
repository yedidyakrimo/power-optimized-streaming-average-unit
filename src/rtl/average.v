`timescale 1ns/1ps

module average #(
    parameter NOF_BITS = 32,
    parameter WIDTH = 32
) (
    input  wire                     clk,
    input  wire                     rst_n,
    input  wire                     start,
    input  wire                     data_first,
    input  wire                     data_last,
    input  wire [NOF_BITS-1:0]      data_in,
    output wire [NOF_BITS:0]        data_out,
    output reg                      busy,
    output reg                      TO,
    output reg                      done
);

    // 3-state FSM
    typedef enum logic [1:0] { S_IDLE = 2'b00, S_WAIT = 2'b01, S_BUSY = 2'b10 } state_e;
    state_e state, next_state;

    // timeout counter (10 cycles)
    reg [3:0] timeout_cnt;

    // element counter (number of items received)
    reg [NOF_BITS:0] elem_cnt;

    // wires from submodules
    wire [NOF_BITS:0] sum_out;
    wire              sum_done;
    wire              sum_busy;

    wire              div_done;
    wire              div_valid;
    wire              div_dbz;

    // Instantiate Sum (accumulator)
    // Sum_mod is used in this project (implementation in src/rtl/sum.v)
    Sum_mod #(.NOF_BITS(NOF_BITS)) u_sum (
        .clk(clk),
        .rst_n(rst_n),
        .data_first(data_first),
        .data_last(data_last),
        .data_in(data_in),
        .data_out(sum_out),
        .busy(sum_busy),
        .done(sum_done)
    );

    // Divider: start when sum_done asserts
    divu_int #(.WIDTH(NOF_BITS+1)) u_div (
        .clk(clk),
        .rst_n(rst_n),
        .start(sum_done),
        .busy(),
        .done(div_done),
        .valid(div_valid),
        .dbz(div_dbz),
        .a(sum_out),
        .b(elem_cnt),
        .val(data_out),
        .rem()
    );

    // ------------------------------------------------------------------
    // Combinational next-state logic (State Machine Logic)
    // ------------------------------------------------------------------
    always @(*) begin
        next_state = state;
        case (state)
            S_IDLE: begin
                if (start) next_state = S_WAIT;
            end

            S_WAIT: begin
                if (timeout_cnt == 4'd10) next_state = S_IDLE; // timeout -> go back
                else if (data_first) next_state = S_BUSY;     // data arrived -> BUSY
            end

            S_BUSY: begin
                // stay in BUSY while receiving (sum module) and waiting for div
                if (div_done) next_state = S_IDLE; // division finished -> done and back
            end

            default: next_state = S_IDLE;
        endcase
    end

    // ------------------------------------------------------------------
    // Timeout counter logic (dedicated block)
    // - counts while in WAIT state, clears on reset or when data_first/start
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            timeout_cnt <= 4'd0;
        end else begin
            if (state == S_WAIT) begin
                if (data_first) timeout_cnt <= 4'd0; // clear if data arrives
                else if (timeout_cnt < 4'd10) timeout_cnt <= timeout_cnt + 1'b1;
            end else begin
                timeout_cnt <= 4'd0;
            end
        end
    end

    // ------------------------------------------------------------------
    // Element counter logic
    // - When entering BUSY because of data_first, set elem_cnt=1
    // - While sum is still collecting data (sum_busy && !sum_done), increment
    // ------------------------------------------------------------------
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            elem_cnt <= {(NOF_BITS+1){1'b0}};
        end else begin
            if (state == S_WAIT && data_first) begin
                // first element detected -> start count
                elem_cnt <= {{NOF_BITS{1'b0}}, 1'b1};
            end else if (state == S_BUSY) begin
                // while sum is running and not done, count additional elements
                if (!sum_done && sum_busy) begin
                    elem_cnt <= elem_cnt + 1'b1;
                end
                // when sum_done asserted, elem_cnt holds the correct count for div
            end else begin
                // default clear in other states
                elem_cnt <= {(NOF_BITS+1){1'b0}};
            end
        end
    end

    // ------------------------------------------------------------------
    // Output / communication logic
    // - drive busy, TO (timeout pulse), done (one-cycle when div provides valid)
    // ------------------------------------------------------------------
    reg TO_reg;
    reg done_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= S_IDLE;
            busy    <= 1'b0;
            TO_reg  <= 1'b0;
            done_reg<= 1'b0;
        end else begin
            state <= next_state;

            // busy: asserted only in BUSY state
            busy <= (next_state == S_BUSY) || (state == S_BUSY);

            // Timeout pulse: when counter reached 10 while in WAIT
            if (state == S_WAIT && timeout_cnt == 4'd10)
                TO_reg <= 1'b1;
            else
                TO_reg <= 1'b0;

            // done pulse: when divider completes with valid and not dbz
            if (div_done && div_valid && !div_dbz)
                done_reg <= 1'b1;
            else
                done_reg <= 1'b0;

            // data_out is driven by divider 'val' port directly via instance
            // no assignment here to avoid conflict
        end
    end

    // Output registers driven from internal regs
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            TO   <= 1'b0;
            done <= 1'b0;
        end else begin
            TO   <= TO_reg;
            done <= done_reg;
        end
    end

endmodule