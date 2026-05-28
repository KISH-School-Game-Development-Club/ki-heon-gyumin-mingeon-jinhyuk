if (collision_rectangle(x-200, y-200, x+200, y+200, o_player, false, true)){
    	image_speed = 1
	if image_index == 2{
		image_speed = 0
		image_index = 2
	}
}else{
    	image_speed = -1
	if image_index == 0{
		image_speed = 0
		image_index = 0
	}
}