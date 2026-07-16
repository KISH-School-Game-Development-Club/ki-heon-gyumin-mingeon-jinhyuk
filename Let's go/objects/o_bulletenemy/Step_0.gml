if (global.paused) exit;
if(!place_meeting(x, y, global.mainwalls)){
	switch(my_dir){
		case 1:
		x += bulletsp
		bulletsp += 1
		break;
		case -1:
		x -= bulletsp
		bulletsp += 1
		break;
	}
 }
 if place_meeting(x, y, global.mainwalls){
	 instance_destroy()
 }