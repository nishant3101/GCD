`timescale 1ns / 1ps
////////////////
module gcd_data(
input wire clk,
input wire clr,
input wire xmsel,
input wire ymsel,
input wire xld,  
input wire yld,
input wire gld,
input wire [3:0] xin,
input wire [3:0] yin,
output reg [3:0] greg=0,
output reg eqflg=0,  //equal flag
output reg ltflg=0   //less than flag
);
reg [3:0] xreg;
reg [3:0] yreg;
wire [3:0] xmy;
reg  [3:0] x;
reg  [3:0] y;
wire [3:0] ymx;
assign xmy=xreg-yreg;
assign ymx=yreg-xreg;
always @(*)    //initial x mux {2X1}
begin
    case (xmsel)
        1'b1:x<=xin;
        1'b0:x<=xmy;
    endcase
end

always @(*)    //initial y mux (2X1)
begin
    case (ymsel)
        1'b1:y<=yin;
        1'b0:y<=ymx;
    endcase
end
always @(posedge clk or posedge clr)
begin
    if(clr==1)
    begin
        xreg<=0;
        yreg<=0;
        greg<=0;
    end
    else
    begin
        if(xld) xreg<=x;
        else if (~xld) xreg<=xreg;
        
        if(yld) yreg<=y;
        else if (~yld) yreg<=yreg;
        
        if(gld) greg<=xreg;
        else if (~gld) greg<=greg;
    end
end                

always@(*)     //equality checker
begin
    if(xreg==yreg)
         eqflg<=1;
    else
         eqflg<=0;
end     

always@(*)       //less than checker
begin
    if(xreg<yreg)
         ltflg=1;
    else
         ltflg=0;
end                           
endmodule
