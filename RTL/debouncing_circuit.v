module debouncing_circuit (input clk , reset , in , output reg db);

// symbolic state declaration
localparam  zero = 3'b000,
            wait1_1 = 3'b001,
            wait1_2 = 3'b010,
            wait1_3 = 3'b011,
            one = 3'b100,
            wait0_1 = 3'b101,
            wait0_2 = 3'b110,
            wait0_3 = 3'b111;

// number of counter bits (2**N * 2Ons = lOms tick )
localparam N = 19;
wire tick;
reg [N-1:0] count_reg;
wire [N-1:0] count_reg_next;
reg [2:0] state_reg, next_state_reg;

//count register
always@(posedge clk or negedge reset) begin
if(~reset)
           count_reg <= 0;
else 
            count_reg <= count_reg_next;
end

//free running counter
assign count_reg_next = count_reg + 1'b1;

assign tick = (count_reg == 0) ? 1'b1 : 1'b0;



//state register
always@(posedge clk or negedge reset) begin
if(~reset)
           state_reg <= 0;
else 
            state_reg <= next_state_reg;
end



always@(*) begin


case(state_reg)
zero : begin
         db = 1'b0;
         if(in)
               next_state_reg = wait1_1;
          else
               next_state_reg = zero;

       end

wait1_1 : begin
         db = 1'b0;
         if(~in)
               next_state_reg = zero;
          else
             if(tick)
                next_state_reg = wait1_2;

       end

wait1_2 : begin
         db = 1'b0;
         if(~in)
               next_state_reg = zero;
          else
             if(tick)
                next_state_reg = wait1_3;

       end
wait1_3 : begin
         db = 1'b0;
         if(~in)
               next_state_reg = zero;
          else
             if(tick)
                next_state_reg = one;

       end
one : begin
         db = 1'b1;
         if(~in)
               next_state_reg = wait0_1;
          else
                next_state_reg = one;

       end

wait0_1 : begin
         db = 1'b1;
         if(in)
              
               next_state_reg = one;
          else
             if(tick)
                next_state_reg = wait0_2;

       end
wait0_2 : begin
         db = 1'b1;
         if(in)              
               next_state_reg = one;
          else
             if(tick)
                next_state_reg = wait0_3;

       end
wait0_3 : begin
         db = 1'b1;
         if(in)              
               next_state_reg = one;
          else
             if(tick)
                next_state_reg = zero;
       end

endcase



end

endmodule
