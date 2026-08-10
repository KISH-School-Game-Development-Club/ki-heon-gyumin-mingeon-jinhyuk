if (global.paused) exit;
if (used == 0) timer --;

if (place_meeting(x, y, o_player) && used == -1) {
	timer = 300;
	used = 0;
}else if (!place_meeting(x, y, o_player) && used == 0) {
	used = -1;
}
if (timer <= 0 && used == 0){
	instance_create_layer(x, y-64, "Instances", o_press_F);
}else{
	if (instance_exists(o_press_F)){
		instance_destroy(o_press_F)
	}
}

if (place_meeting(x, y, o_player) && keyboard_check_pressed(ord("F"))){
	used = 1;
	if (o_gamecontroller.onoff == 1){
	o_gamecontroller.onoff = 0
}else{
	o_gamecontroller.onoff = 1
}
}

if (o_gamecontroller.onoff == 1){
	image_index = 0
}else{
	image_index = 1
}