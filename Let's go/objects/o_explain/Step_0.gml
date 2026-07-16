if (place_meeting(x, y, o_player) && keyboard_check_pressed(ord("F")) && show == 0){
	show_explain = which_explain;
	show = 1;
}else if (show == 1 && keyboard_check_pressed(ord("F"))){
	if (show_explain == 1){
		show_explain = 2;
	}else{
	show_explain = 0;
	show = 0;
	}
}
if( 4 <= show_explain <= 5 && show == 1 && keyboard_check_pressed(ord("T"))){
	if (show_explain == 5){
	show_explain = 4;
	}else if (show_explain == 4){
		show_explain = 5;
	}
}
global.paused = show;