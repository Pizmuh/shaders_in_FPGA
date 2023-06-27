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
reg [11:0] i = 0;

reg  signed [17:0] x = 0;
reg signed [17:0] y = 0;
reg signed [17:0] zx = 0;
reg signed [17:0]zxx = 0;
reg signed [17:0] zy = 0;/*
reg signed [23:0] barva = 0;*/

reg signed [2:0] vrednost = 0;

reg [1:0] c;


always @ (posedge clock)
begin
if  ((zx<0 && zx >0) ||(zy >0 && zx>0))begin
	c <= 1'b1;
	end else begin
	c <= 0;
	end
end

	
// upravljanje layerjev
always @ (posedge clock)
begin
 if (enable)

		//sub_px <= sub_px + 1;
		//timer <= timer + 1;
		

	
	 //  x <= ((hcount *1000/800) - 500)*2; //Pretvori v decimalni zapis aka, to kr se izpuše so sam decimalke ki ostanejo pri deljenju z nič
		//y <= ((vcount *1000/600) - 500)*2; // Ponovno pretvorba v decimalke in reduciranje vrednosti od 0 do 1
		//d <= 3'b111 &((x*x/1000 + y*y/1000) <= 200) ;
	 


			zxx<=  (((hcount*1000 )/800) - 500)*2 - 729;// +zx*zx/1000 - zy*zy/1000 ;

			if (c ==1)begin
			zy <= (((vcount*1000)/600) - 500)*2 + 210 ;//+ 2*~zx*zy/1000 ;
			end 
			else begin
			zy <= (((vcount *1000)/600) - 500)*2 + 210 ;//+ 2*zx*zy/1000 ;
			end
			zx<= zxx;
		

	
		// vrednost <= 3'b111 & ((zx*zx + zy*zy) >= 10);
	
		//barva <= (zx*zx + zy*zy)/1000;
	
			

		
	if (hcount > 0 && hcount < 800 && vcount > 0 && vcount < 600&& ((zx*zx + zy*zy) <= 100000)) begin
		
	

	 //green <= timer>>10 + a;//{timer[2:0], timer[15:3]}
	   //a <= a - timer;
	  // green_F <= 3'b111;//d>>15; //(x & 3'b001 >= sub_px);//3'b101 == sub_px;
      //blue_F  <= 3'b111;//barva;  &&((x*x + y*y) <= 200000)
      red_F   <= 3'b111 ;//(y & 3'b001 >= sub_px);
	 end
	 else begin
	   green_F <= 3'b000;
      blue_F <= 2'b00; 
      red_F <= 3'b000;
	 end
 end

/*
void mainImage( out vec4 fragColor, in vec2 fragCoord ) {
    vec2 uv = (fragCoord-iResolution.xy/2.)/min(iResolution.x,iResolution.y)*2.;
    //uv /= (iTime+1.);
    //uv /=exp(iTime);
    uv = vec2(uv.x*1000., uv.y*1000.);
    uv+=vec2(-729,.210);

    
    vec2 z = vec2(0);
    vec2 zx = vec2(0);
    
    
        z.x = z.x*z.x/1000. - z.y*z.y/1000. +uv.x;
        z.y = 2.*z.x*z.y/1000.+uv.y;
   
      

    vec3 col = vec3(0);
    if (z.x*z.x+z.y*z.y<=100000.)
     col = vec3(1);

  
    fragColor = vec4(col ,1.0);
}
*/

endmodule

