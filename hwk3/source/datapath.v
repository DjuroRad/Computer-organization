module datapath(res, multiplicant, multiplier, lsb_select, init, shift_load, l_lsb, clk, i_eq_0, cycle_finish);
//output reg[63:0] res;
output reg[63:0] res;
output i_eq_0;
input [31:0] multiplicant, multiplier;
input lsb_select, init, shift_load, l_lsb, clk, cycle_finish;

//registers needed are PRODUCT_BUFFER for result and LSB for least significat bit
reg [63:0] product_buffer = 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;

reg [31:0] i_count = 32'b0000_0000_0000_0000_0000_0000_0010_0001;
wire [31:0] substracted_i;

wire [31:0] prod_32_msb;
wire [31:0] prod_32_lsb;
reg lsb;//used to store our lsb which will be stored on each positive edge before the number is shifted on negative edge

wire [31:0] mux_0_mult;
wire [31:0] add_0_mult;

wire [31:0] mux_prev_or_init;
wire[63:0] add_prev_bus; //product buffer either performs addition or shifting (when init is 1 multiplicant needs to be stored )
wire[63:0] shifted_bus, mux_res;
//mux for choosing between MULTIPLICANT and ZERO
//LSB select for MUX - choose MULTIPLICANT or ZERO
//use 32 2x1 muxes here!
reg [31:0]zero32 = 32'b0000_0000_0000_0000_0000_0000_0000_0000;

wire lsb_select_enable;
and(lsb_select_enable, lsb, lsb_select);
mux_32bit mux32_select(mux_0_mult, lsb_select_enable, zero32, multiplicant );
//perform addition with FIRST 32BITs of buffer
wire c_out;
adder_32bit adder32(add_0_mult, c_out, mux_0_mult, product_buffer[63:32], 1'b0);




//NOW CHECK THE INITIAL STAGE TO STORE MULTIPLIER OR JUST COPY IT OTHERWISE
mux_32bit initialize(mux_prev_or_init, init, prod_32_lsb ,multiplier );


//define shifted bus
shift_right64bit sr64(shifted_bus, product_buffer);


//CONNECT THEM IN A 64-bit bus!
genvar i;
generate
	for( i = 0; i<32; i = i+1 )
		begin: parallel_loop_bus64_1
			and( add_prev_bus[i], mux_prev_or_init[i],1'b1);
			and( prod_32_lsb[i], product_buffer[i],1'b1);
		end
endgenerate

generate
	for( i = 32; i<64; i = i+1 )
		begin: parallel_loop_bus64_2
			and( add_prev_bus[i], add_0_mult[i-32],1'b1);
			and( prod_32_msb[i-32], product_buffer[i],1'b1);
		end
endgenerate

//now mux to choose between shift-ing and adding!
//on each clock either it is added or it is shifted
mux_64bit mux64bit(mux_res, shift_load, shifted_bus, add_prev_bus);





//add the counter I
adder_32bit i_adder(substracted_i, c_out, i_count, 32'b1111_1111_1111_1111_1111_1111_1111_1111, 1'b0);
is_zero5bit is_i_zero( i_eq_0, i_count[5:0]);

//add 1 checker to store the result!
wire is_one;
is_one5bit isone(is_one, i_count[5:0]);

always @(posedge clk) begin
	//on each positive edge update the product!
	//	product_buffer = mux_res;
	product_buffer <= mux_res;
	//on each clock I update the counter
	if(l_lsb) begin
		lsb <= product_buffer[0];//set lsb on each cycle!
	end
	
	if(is_one)begin
		//res <= mux_res;
	end
	//res <= mux_res;

	if(init)begin
		i_count <= 32'b0000_0000_0000_0000_0000_0000_0010_0001;
		res <= product_buffer;
		//i_count <= 32'b0000_0000_0000_0000_0000_0000_001_1111;
		//product_buffer <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
	end

	if(i_eq_0) begin
		//res <= product_buffer;
		//i_count <= 32'b0000_0000_0000_0000_0000_0000_0010_0000;
		//product_buffer <= 64'b0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000;
	end
	
	if( cycle_finish )
		i_count <= substracted_i;
		
end
endmodule