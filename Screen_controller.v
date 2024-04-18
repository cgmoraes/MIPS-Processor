module Screen_controller
( 
 input clk, vga_clk,
 input [1:0] print,
 input [31:0] x, y, char,
 output reg hsync,
 output reg vsync, 
 output reg [7:0] red,   
 output reg [7:0] green,
 output reg [7:0] blue,  
 output vga_sync,    
 output vga_blank 
 
);

localparam CHAR_WIDTH = 8;
localparam CHAR_HEIGHT = 8;

parameter h_front_porch = 16;
parameter h_sync_pulse = 96;
parameter h_back_porch = 48;
parameter h_total_pixels = 800;

parameter v_front_porch = 10;
parameter v_sync_pulse = 2;
parameter v_back_porch = 33;
parameter v_total_lines = 525;

reg pixel;
reg [9:0] x_pos; 
reg [9:0] y_pos;
reg [9:0] h_count = 0;
reg [9:0] v_count = 0;
reg [5:0] screen_grid[0:4799];
reg [7:0] font[0:511];

wire video_on;

assign video_on = (h_count < 640) && (v_count < 480);
assign vga_sync = 1'b0;
assign vga_blank = (hsync & vsync);

integer i, screen_x, screen_y, screen_id, font_x, font_y, grid_id;
	 
initial begin
  $readmemb("font.txt", font);
  
  for (i = 0; i < 4800; i = i + 1) begin
		 screen_grid[i] = 6'd0;		
  end
end

 always @ (posedge clk) begin
	if(print == 2'b01) begin
		  grid_id <= y * 80 + x;
	end else if(print == 2'b10) begin
		  screen_grid[grid_id] <= char;
	end
end
		
always @(posedge  vga_clk) begin
    if (h_count < h_total_pixels - 1) begin
        h_count <= h_count + 1;
    end else begin
        h_count <= 0;
        if (v_count < v_total_lines - 1) begin
            v_count <= v_count + 1;
        end else begin
            v_count <= 0;
        end
    end
	 
	 if(video_on && pixel) begin
		  red <= 0;
		  green <= 8'b11111111;
		  blue <= 0;
	 end else begin
		  red <= 0;
		  green <= 0;
		  blue <= 0;
	 end
	 
	 screen_x <= x_pos / 8;
	 screen_y <= y_pos / 8;
	 screen_id <= screen_y * 80 + screen_x;
	  
	 font_x <= x_pos - 1 - (screen_x * 8);
	 font_y <= (screen_grid[screen_id] * 8) + (y_pos - (screen_y * 8));
	  
	 pixel <= font[font_y][font_x];

    x_pos <= (h_count < 640) ? h_count : 0;
    y_pos <= (v_count < 480) ? v_count : 0;

    hsync <= ~(h_count >= (640 + h_front_porch) && h_count < (640 + h_front_porch + h_sync_pulse));
    vsync <= ~(v_count >= (480 + v_front_porch) && v_count < (480 + v_front_porch + v_sync_pulse));
end
  
endmodule