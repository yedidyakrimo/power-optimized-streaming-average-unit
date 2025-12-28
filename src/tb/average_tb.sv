`timescale 1ns/1ps

interface avg_if #(parameter WIDTH = 32)();
    reg clk;
    reg start;
    reg rst_n;   
    reg data_first; 
    reg data_last; 
    reg [WIDTH-1:0] data_in; 
    reg [WIDTH:0] data_out; 
    wire busy;
    wire done;
    wire TO;
    event check_data_out;
    int data_out_check;
endinterface

class avg_driver #(parameter WIDTH = 32);
    virtual avg_if _if;
    int fd_output;
    // Increased safety margin for SDF simulation
    real hold_delay = 40.0; 

    function new();
    endfunction

    task reset();
        _if.clk = 1'b0;
        _if.start = 1'b0;
        _if.rst_n = 1'b0;
        _if.data_first = 1'b0;
        _if.data_last = 1'b0;
        _if.data_in = '0; 
    endtask

    task generate_data(input int max_iterations);
        int cycles;
        int random_data;

        _if.data_out_check = 0;
        cycles = $urandom_range(1, 20);

        if (cycles == 1) begin 
            @(posedge _if.clk); #hold_delay; 
            _if.data_first = 1; 
            _if.data_last = 1;
            random_data = $urandom_range(1, 20);
            _if.data_in = random_data;
            _if.data_out_check = _if.data_in; 
        end else begin
            @(posedge _if.clk); #hold_delay;
            _if.data_first = 1;
            random_data = $urandom_range(1, 20);
            _if.data_in = random_data;
            _if.data_out_check = _if.data_out_check + _if.data_in; 

            for (int i = 1; i < cycles-1; ++i) begin
                @(posedge _if.clk); #hold_delay;
                random_data = $urandom_range(1, 20);
                _if.data_in = random_data;
                _if.data_out_check = _if.data_out_check + _if.data_in; 
                _if.data_first = 0;
            end

            @(posedge _if.clk); #hold_delay;
            random_data = $urandom_range(1, 20);
            _if.data_in = random_data;
            _if.data_out_check = (_if.data_out_check + _if.data_in); 
            _if.data_first = 0;
            _if.data_last = 1;
        end

        @(posedge _if.clk); #hold_delay;
        _if.data_first = 0;
        _if.data_last = 0;
        _if.data_out_check = (_if.data_out_check) / (cycles); 
    endtask

    task run(input int max_iterations);
        string output_file = "../reports/average_output.txt"; 
        int iteration_count = 0;
        int wait2start = 0;
        
        fd_output = $fopen(output_file, "w");
        
        // Extended Reset sequence for stability
        repeat(20) @(posedge _if.clk);
        #hold_delay;
        _if.rst_n = 1'b1;
        repeat(10) @(posedge _if.clk);

        while (iteration_count < max_iterations) begin
            @(posedge _if.clk); #hold_delay;
            _if.start = 1;
            @(posedge _if.clk); #hold_delay;
            _if.start = 0;
            
            generate_data(max_iterations);
            
            while(!_if.done) @(posedge _if.clk);
            #hold_delay; 
            ->_if.check_data_out; 
       
            iteration_count = iteration_count + 1;
            wait2start = $urandom_range(1, 5);
            repeat(wait2start) @(posedge _if.clk);
        end

        $display("Simulation finished after %0d iterations.", iteration_count);
        $fclose(fd_output);
        $finish;
    endtask

    task check();
        $fdisplay(fd_output,"# EX_3 part 1 %s %d", "yedidya krimolovski", 315212795);
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
    parameter WIDTH = 32;
    // Slow clock to ensure zero timing violations during SDF simulation
    parameter cycle_period = 100; 
    parameter hcycle_period = cycle_period / 2;

    avg_if _if();
    avg_driver d0;
    int max_iterations;

    initial begin
        if (!$value$plusargs("max_iterations=%d", max_iterations)) begin
            max_iterations = 100;
        end
    end

    initial begin
        $display("Running avg with SDF delays - Ultra Stable Mode");
        d0 = new();
        d0._if = _if;
        d0.reset();
        #100
        fork
            d0.run(max_iterations);
            d0.check();
        join_any
    end    

    always begin
        #hcycle_period _if.clk = ~_if.clk;
    end

    average avg(
        .clk(_if.clk),
        .start(_if.start),
        .rst_n(_if.rst_n),
        .data_first(_if.data_first), 
        .data_last(_if.data_last), 
        .data_in(_if.data_in), 
        .data_out(_if.data_out), 
        .TO(_if.TO),
        .busy(_if.busy),    
        .done(_if.done)  
    );
endmodule
