`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module gcd_top(
input clk,
input clr,
input go,
input [3:0] xin,
input [3:0] yin,
output [7:0]cathode,
output [3:0] anode
);
wire [3:0] greg;
wire xmsel;
wire ymsel;
wire xld;
wire yld;
wire gld;
wire eqflg;
wire ltflg;
wire clock;
wire gotemp; 
wire gotemp1;
wire clrout;
wire clock19;
wire [3:0] ones;
wire [3:0] tens;
wire [3:0] hundreds;
wire [3:0] thousands;


clockdivid19 clk2(.inclk(clk),.outclk(clock19));
clockdivid25 clk1(.inclk(clk),.outclk(clock));
gcd_data data (.clk(clock),.clr(clrout),.xin(xin),.yin(yin),.greg(greg),.xld(xld),.yld(yld),.gld(gld),.xmsel(xmsel),.ymsel(ymsel),.eqflg(eqflg),.ltflg(ltflg));
gcd_ctrl control(.clk(clock),.clr(clrout),.go(gotemp1),.xld(xld),.yld(yld),.gld(gld),.xmsel(xmsel),.ymsel(ymsel),.eqflg(eqflg),.ltflg(ltflg));
clk_pulse clk_pulse(.clk(clock),.deb_in(gotemp),.deb_out(gotemp1));
debouncer clear(.inclk(clock19),.clr(clr),.outclk(clrout));
debouncer goto(.inclk(clock19),.clr(go),.outclk(gotemp));
bin2bcd bin2bcd(.number(greg),.ones(ones),.tens(tens),.hundreds(hundreds),.thousands(thousands));
sevenseg_all sevseg(.clk(clk),.cathode(cathode),.anode(anode),.ones(ones),.tens(tens),.hundreds(hundreds),.thousands(thousands));


     
endmodule
