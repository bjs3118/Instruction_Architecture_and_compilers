// Currently set up to run purley havard no wrap

module CPU_MIPS_HARVARD_tb;

timeunit 1n2 / 10ps;

parameter TIMEOUT_CYCLES = 10000; //To be determined

logic clk;
logic reset;

logic active;

logic[31:0] register_v0;

// MEMORY INITILISATION ????

mips_cpu_harvard cpuInst(clk, reset, active, register_v0)

//generate clock 

initial begin
    
    clk = 0;

    repeat (TIMEOUT_CYCLES) begin
        #10;
        clk = !clk;
        #10
        clk = !clk;
    end

    $fatal(2, "Simmulation did not finish with %d cycles.", TIMEOUT_CYCLES)     //What does 2 do here?

end 

//Running CPU

inital begin
   
    //reseting the cpu, edge case here when rst is held on for longer than one cycle

    reset <= 0;    
   
    @(posedge clk);
    reset <= 1;

    @(posedge clk);
    reset <= 0

    @(posedge clk);

    assert(register_v0 == 0)
    else $display("tb : CPU did not reset correctly, v0!=0");

    assert(active == 1)
    else $display("tb : CPU did not set active=1 after reset");

    while(active) begin
        @(posedge clk);
    end

    $display("tb : CPU has finished running");

    $finish;

// how to get output of v0? (do we need to 'return' it?)


end

endmodule 