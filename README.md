# Debouncing_Circuit
we implement a simple debouncing Verilog code for buttons on FPGA. 

 Mechanical switches/ buttons cause an unpredictable bounce in the signal when toggled.
 
 The bounces lead to glitches in the signal.
 
 The bounces usually settle within 20 ms.
 
 the design uses a free-running 10-ms counter and an FSM.
 
 The timer generates a one-clock-cycle enable tick every 10 ms,
 
 and the FSM uses this information to keep track of whether the input value is stabilized.
 
 the design changes the value of the debounced output only after the input is stabilized for 20 ms.
 
