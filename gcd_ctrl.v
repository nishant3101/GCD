`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module gcd_ctrl(
input clk,
input clr,
input go,
input eqflg,
input ltflg,
output reg xmsel,
output reg ymsel,
output reg xld,
output reg yld,
output reg gld
);

reg [2:0] ps=0;
reg [2:0] ns=0;
parameter start=3'b000,inp=3'b001,test1=3'b010,test2=3'b011,done=3'b100,update1=3'b101,update2=3'b110;

always@(posedge clk or posedge clr)
begin
    if(clr)
        ps<=start;
    else if(~clr) 
        ps<=ns;
end
        
always@(*)
begin
    case(ps)
        start:begin
                if(go) 
                    ns<=inp;
                else if(~go) 
                    ns<=start;
                end
        inp: 
        begin 
             ns<=test1;
             xmsel<=1;
             ymsel<=1;
             xld<=1;
             yld<=1;
             gld<=0;
            end
          
        test1:  
        begin
               if(eqflg)
                begin
                ns<=done;
                gld<=0;
                xld<=0;
                yld<=0; 
               end
               else if(~eqflg)
               begin
               ns<=test2;
               gld<=0;
               xld<=0;
               yld<=0;
              end
        end
        done: begin 
                    if(clr)
                    begin
                    ns<=start;
                    gld<=1;
                    end
                    else if(~clr)
                    begin
                    ns<=done; 
                    gld<=1;
           
                    end
               end     
        test2:  begin if(ltflg)begin ns<=update1;
//                        xmsel<=0;
//                        ymsel<=0;
//                        xld<=0;
//                        yld<=0;
//                        gld<=0;
                        end
                else if (~ltflg)begin 
                        ns<=update2; 
//                        xmsel<=0;
//                        ymsel<=0;
//                        xld<=0;
//                        yld<=0;
//                        gld<=0;
                    end
                     end       
        update1: begin yld<=1;
                ymsel<=0;
                ns<=test1; end              
        update2: begin xld<=1;
                 xmsel<=0;
                 ns<=test1; end
        default :ns<=start;        
     endcase
end        
endmodule
