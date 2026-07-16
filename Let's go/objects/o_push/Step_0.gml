if (global.paused) exit;
if (place_meeting(x, y, o_player) && keyboard_check_pressed(ord("F"))){
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