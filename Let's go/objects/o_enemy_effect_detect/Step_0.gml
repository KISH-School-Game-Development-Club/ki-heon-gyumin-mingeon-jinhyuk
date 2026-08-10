if(floor(image_index) >= 4){
	image_speed = 0;
	image_index = 4;
	image_alpha -= 0.025
}

if (image_alpha <= 0){
	instance_destroy()
};