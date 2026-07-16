image_xscale = sign(o_player.dashdir)
if (keyboard_check_pressed(ord("E")) && o_player.dashcool <= 0 && o_player.dashup == 1){
	dash = 1;
	image_index = 0
	image_speed = 1
	visible = 1
}
if dash == 0 {
	x = o_player.x
	y = o_player.y

}else if(dash == 1) {
	if(image_index >= image_number -1){
	image_speed = 0
	visible = 0
	dash = 0;
	}
}