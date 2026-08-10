draw_self();
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
if(timing == 1){
	draw_text_transformed(x, y, string(floor(timer/60)), 3, 3, 0)
}