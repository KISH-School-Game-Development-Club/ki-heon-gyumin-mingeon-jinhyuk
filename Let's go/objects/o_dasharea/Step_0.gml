if (global.paused) exit;
if (o_gamecontroller.onoff_dasharea == 1){
	visible = 1
	if (image_index != 2){
	image_speed = 1
	}else{
	image_speed = 0
	}
	mask_index = -1
}else if (o_gamecontroller.onoff_dasharea == 0){
	if (image_index != 0){
	image_speed = -1
	}else{
	image_speed = 0
		visible = 0
	}
	mask_index = asset_get_index("noone");
}

if (place_meeting(x, y, o_player) && o_gamecontroller.onoff_dasharea == 1){
	o_player.dashup = true;
}else{
	o_player.dashup = false;
}