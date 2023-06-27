`timescale 1ns / 1ps
module pravilen_VGA(
  input clock,
  output reg [2:0] red_F, 
  output reg [2:0] green_F, 
  output reg [1:0] blue_F,
  output reg hsync, 
  output reg vsync

);


reg [11:0] hcount = 0;
reg [11:0] vcount = 0;
reg [1:0] counter = 0;
reg enable;





// sinhronizacija VGA zaslona
always @ (posedge clock)
begin
  if (counter == 2)
  begin
    counter <= 1'b0;
    enable <= 1'b1;
  end
  else
  begin
    counter <= counter + 1'b1;
    enable <= 1'b0;
  end
end

always @(posedge clock)
begin
  if (enable == 1)
  begin
    if(hcount == 1055)
    begin
      hcount <= 0;
		if(vcount == 627)
		  vcount <= 0;
      else 
        vcount <= vcount+1'b1;
    end
    else
      hcount <= hcount+1'b1;

  if (vcount >= 601 && vcount < 605) 
    vsync <= 1'b0;
  else
    vsync <= 1'b1;

  if (hcount >= 840 && hcount < 968) 
    hsync <= 1'b0;
  else
    hsync <= 1'b1;
  end
end



//timer
reg [23:0] steti = 0;
reg [7:0] timer = 1;
/*
always @ (posedge clock)
begin
  if (steti == 0)
  begin
    steti <= 1'b1;
    timer <= timer + 1;
  end
  else
  begin
    steti <= steti + 1'b1;
  end
end
*/


reg [1:0] sub_px = 0;
reg [11:0] i = 0;

reg  signed [17:0] x = 0;
reg signed [17:0] y = 0;
reg signed [17:0] d = 0;
reg signed [17:0] zx = 0;
reg signed [17:0]zxx = 0;
reg signed [17:0] zy = 0;/*
reg signed [23:0] barva = 0;*/

reg signed [2:0] vrednost = 0;


// upravljanje layerjev
always @ (posedge clock)
begin
 if (enable)
	
	for (i = 0; i<10;i++)begin

			zxx<=  ((hcount *1000/800) - 500)*2 - 729 +zx*zx/1000 - zy*zy/1000 ;
			zy <= ((vcount *1000/600) - 500)*2 + 210 + 2*zxx*zy/1000 ;
			zx<= zxx;
			end
	
vrednost <=  ((zx*zx + zy*zy) <= 100000);
end
always @ (posedge clock)
begin
 if (enable)
	if (hcount > 0 && hcount < 800 && vcount > 0 && vcount < 600) begin
		
	

	
	   green_F <= 3'b111 & (1 && vrednost);//d>>15; //(x & 3'b001 >= sub_px);//3'b101 == sub_px;
      blue_F  <= 2'b11&(1 && vrednost);//barva;  &&((x*x + y*y) <= 200000)
      red_F   <= 3'b111 &(1&& vrednost) ;//(y & 3'b001 >= sub_px);
	 end
	 else begin
	   green_F <= 3'b000;
      blue_F <= 2'b00; 
      red_F <= 3'b000;
	 end
 end


endmodule

