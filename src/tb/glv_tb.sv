`timescale  1ns/1ps

interface avg_if #(parameter WIDTH = 32)();
    reg clk;
    reg start;
    reg rst_n;   
    reg data_first; // start packet
    reg data_last; // end of packet
    reg [WIDTH-1:0] data_in; // data to process
    reg [WIDTH:0] data_out; // data to process
    wire busy;
    wire done;
    wire TO;
    event check_data_out;
    int data_out_check;
endinterface

class driver #(parameter WIDTH = 32);
    virtual avg_if _if;
    int fd_output;

    function new();
    endfunction

    function reset();
        _if.clk = 'b0;
        _if.start = 'b0;
        _if.rst_n = 'b0;
        _if.data_first = 'b0;
        _if.data_last = 'b0;
        _if.data_in = 0; 
    endfunction

    task generate_data(
        input int max_iterations // Maximum number of iterations
    );

        int cycles;
        int random_data;

        _if.data_out_check = 0;
        // Generate a random number of cycles between 1 and 20
        cycles = $urandom_range(1, 20);

        if (cycles == 1) begin // Only one valid data
            _if.data_first = 1; // Raise signal for one cycle
            _if.data_last = 1;

            // Generate random data in the range 1 to 20
            random_data = $urandom_range(1, 20);
            _if.data_in = random_data;
            _if.data_out_check = _if.data_in; 
        end else begin

            _if.data_first = 1; // Raise signal for one cycle
            random_data = $urandom_range(1, 20);
            _if.data_in = random_data;
            _if.data_out_check = _if.data_out_check + _if.data_in; 

            @(negedge _if.clk);
            for (int i = 1; i < cycles-1; ++i) begin
                // Generate random data for the first cycle
                random_data = $urandom_range(1, 20);
                _if.data_in = random_data;
                _if.data_out_check = _if.data_out_check + _if.data_in; 
                _if.data_first = 0;
                @(negedge _if.clk);
            end

            // For the last cycle, hold `data_last` signal high for one cycle
            random_data = $urandom_range(1, 20);
            _if.data_in = random_data;
            _if.data_out_check = (_if.data_out_check + _if.data_in); 
            _if.data_first = 0;
            _if.data_last = 1;
        end

        @(negedge _if.clk);
        _if.data_first = 0;
        _if.data_last = 0;
        _if.data_out_check = (_if.data_out_check) / (cycles); 

    endtask


    task run(
        input int max_iterations // Maximum number of iterations
    );
        string output_file = "../output/avg_output-part3.txt";
        int iteration_count = 0; // Counter for the number of iterations
        int wait2start = 0;
        
        // open a check file
        fd_output      = $fopen(output_file, "w");
        
        _if.rst_n = 'b1;
        @ (negedge _if.clk); // wait one cycle


        while (iteration_count < max_iterations) begin
            _if.start = 1;
            @ (negedge _if.clk); // wait one cycle
            _if.start = 0;
            generate_data(max_iterations);
            while(!_if.done) @ (negedge _if.clk);  // wait for busy signal to raise up

           ->_if.check_data_out; // report the output            
       
            // Increment the iteration counter
            iteration_count = iteration_count + 1;
       
            // add a delay to the stop condition
            wait2start = $urandom_range(1, 20);
            repeat(wait2start) @(negedge _if.clk);
       
        end

        // Stop the simulation after reaching max_iterations
        $display("Simulation finished after %0d iterations (max_iterations=%0d).", iteration_count, max_iterations);
        $fclose(fd_output);
        $finish;

    endtask

    task check();
        $fdisplay(fd_output,"# EX_3 part 3 %s %d", "yedidya krimo",315212795);
        $fdisplay(fd_output,"_if.data_out_check, _if.data_out, _if.data_out_check == _if.data_out");
        $fdisplay(fd_output,"--------------------------------------------------------------------");
        forever begin
            @(_if.check_data_out);
            $fdisplay(fd_output, "%d,\t\t %d,\t\t %d",_if.data_out_check, _if.data_out, _if.data_out_check == _if.data_out);
            $display("%d, %d, %d",_if.data_out_check, _if.data_out, _if.data_out_check == _if.data_out);                
        end
    endtask

endclass


module avg_tb;

    // parameters
    parameter WIDTH = 32;
    parameter cycle_period = 5;
    parameter hcycle_period = cycle_period / 2;
    parameter VEC_NUM = 8;

    // interface and drivers 
    avg_if _if();
    driver d0;
    int max_iterations;

    // Read the stop condition from a plusarg, defaulting to 15 if not provided
    initial begin
        if (!$value$plusargs("max_iterations=%d", max_iterations)) begin
            max_iterations = 100; // Default value
        end
    end

    initial begin
        $display("Running avg");
        d0 = new();
        d0._if = _if;
        d0.reset();
        #100
        fork
            d0.run(max_iterations);
            d0.check();
        join_any
    end    

    // SDF Configuration
    `ifdef BACKANNOTATION
        initial 
        begin 
            $sdf_annotate("../export/post_synth/average.sdf",avg,,"sdf.log" ,"MAXIMUM"); 
        end
    `endif


    always begin
        #hcycle_period _if.clk =~ _if.clk;
    end

  //REGS and WIRES definitions
  //reg clk;
  
  // For gate level remove the parameterization
  `ifdef GATE_LEVEL
   average avg (
        .clk        (_if.clk),
        .start      (_if.start),
        .rst_n      (_if.rst_n),
        .data_first (_if.data_first), 
        .data_last  (_if.data_last), 
        .data_in    (_if.data_in), 
        .data_out   (_if.data_out), 
        .TO         (_if.TO),
        .busy       (_if.busy),    
        .done       (_if.done)  
    );
  `else 
    average #(WIDTH) avg(.clk(....));
  `endif
  
 
endmodule

