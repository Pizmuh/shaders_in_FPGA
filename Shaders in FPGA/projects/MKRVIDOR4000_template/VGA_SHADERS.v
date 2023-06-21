`timescale 1ns / 1ps
module VGA_SHADERS(
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

reg  signed[10:0] x = 0;
reg signed[10:0] y = 0;
reg signed [30:0] d = 0;
reg signed [18:0] a = 0;

// upravljanje layerjev
always @ (posedge counter)
begin
 if (enable)
 
		sub_px <= sub_px + 1;
		timer <= timer + 1;
		

	
	   x <= ((hcount *1000/800) - 500)*2; //Pretvori v decimalni zapis aka, to kr se izpuše so sam decimalke ki ostanejo pri deljenju z nič
		y <= ((vcount *1000/600) - 500)*2; // Ponovno pretvorba v decimalke in reduciranje vrednosti od 0 do 1
		d <= 2'b11 & (x*x - y*y <= 250000);
		a <= 3'b001 & ((x<= 125) && (x<= 250));
		
		
		
		
		
		
	if (hcount > 0 && hcount < 800 && vcount > 0 && vcount < 600) begin
		
	

	 //green <= timer>>10 + a;//{timer[2:0], timer[15:3]}
	   //a <= a - timer;
	   green_F <= x>>7;//d>>15; //(x & 3'b001 >= sub_px);//3'b101 == sub_px;
      blue_F  <= d;//barva; 
      red_F   <= y>>7;//(y & 3'b001 >= sub_px);
	 end /*
	 else if (hcount > 0 && hcount < 400 && vcount > 300 && vcount < 600) begin
	
	
	 //green <= timer>>10 + a;//{timer[2:0], timer[15:3]}
	   //a <= a - timer;
	   green_F <= 4'b1100 - y;//d>>15; //(x & 3'b001 >= sub_px);//3'b101 == sub_px;
      blue_F  <= 2'b00;//barva; 
      red_F   <= x;//(y & 3'b001 >= sub_px);
	 end 
	  else if (hcount > 400 && hcount < 800 && vcount > 300 && vcount < 600) begin
	
	
	 //green <= timer>>10 + a;//{timer[2:0], timer[15:3]}
	   //a <= a - timer;
	   green_F <= y;//d>>15; //(x & 3'b001 >= sub_px);//3'b101 == sub_px;
      blue_F  <= 2'b00;//barva; 
      red_F   <= 4'b1000 - x;//(y & 3'b001 >= sub_px);
	 end 
	  else if (hcount > 400 && hcount < 800 && vcount > 0 && vcount < 300) begin
	
	 //green <= timer>>10 + a;//{timer[2:0], timer[15:3]}
	   //a <= a - timer;
	   green_F <= y;//d>>15; //(x & 3'b001 >= sub_px);//3'b101 == sub_px;
      blue_F  <= 2'b00;//barva; 
      red_F   <= 4'b1000 - x;//(y & 3'b001 >= sub_px);
	 end */
	 else begin
	   green_F <= 3'b000;
      blue_F <= 2'b00; 
      red_F <= 3'b000;
	 end
 end



endmodule

