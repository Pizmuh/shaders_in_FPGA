`timescale 1ns / 1ps
module game_object(
  input clock,
  output [0:0] red, 
  output [0:0] green, 
  output [0:0] blue,
  input reg [9:0] hcount, 
  input reg [9:0] vcount,
  input enable,
  output layer,
  input inp1,
  input inp2
);

assign layer = 0;



/// Slikica na zaslonu v bistvu ozadje

always @ (posedge clock)
begin
  if (enable)
  begin
	  if ( (60 < hcount && hcount < 70) &&  (vcount > count) && (vcount < 100 + count ) ) //Kvadratek
    begin
      green <= 1'b1;
      blue <= 1'b1; 
      red <= 1'b1;
    end
	 
    else 
    begin
      green <= 1'b0;
      blue <= 1'b0; 
      red <= 1'b0;
    end
  end 
end 


reg [25:0] accumx = 0;
reg [25:0] accumy = 0;
reg [8:0] countx = 0;
reg [8:0] county = 0;
reg [8:0] count1 = 0;
reg [8:0] count2 = 0; 
reg [8:0] count = 0; 

wire ppsx = (accumx == 0);
wire ppsy = (accumy == 0);

reg prev_inp1 = 1;
reg prev_inp2 = 1;

always @(posedge clock) 
begin
    accumx <= (ppsx ? 5_000_000 : accumx) - 1;
	 accumy <= (ppsy ? 5_000_000 : accumy) - 1;

    if (ppsx) 
	 begin
		if ((inp1 == 0) && (count < 380)) // 480
		begin
			count <= count + 3;
		end
		else if ((inp2 == 0) && !(count == 0))
		begin
			count <= count - 3 ;
		end
	end
	
	if (ppsy) begin
		county = county + 1 ;
        //… things to do nce per second 1 = 50 000 000 …
    end
	 
end




// input spreminja pozicije x in y

endmodule
