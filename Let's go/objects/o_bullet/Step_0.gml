if (global.paused) exit;
if(!place_meeting(x, y, global.mainwalls)){
	switch(op_canon.dir){
		case 1:
		x -= 20
		break;
		case -1:
		x += 20
		break;
		case 2:
		y += 20
		break;
		case -2:
		y -= 20
		break;
	}
 }
 if place_meeting(x, y, global.mainwalls){
	 instance_destroy()
 }