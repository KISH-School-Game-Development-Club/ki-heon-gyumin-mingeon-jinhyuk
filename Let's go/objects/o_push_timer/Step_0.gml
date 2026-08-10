if (global.paused) exit;
timer --;
if (place_meeting(x, y, o_player) && keyboard_check_pressed(ord("F")) && timing == 0){	//누르면 시간재기
	image_speed = (o_gamecontroller.onoff == 1) ? 1:-1
	timer = time*60;	//1분동안 대기
	timing = 1
}
if (floor(image_index) == 3 && timing == 1){	//스프라이트 중간에 멈추기
	image_speed = 0;
}

if (timing == 1 && timer <= 0){	//타이머 끝나면 다시 애니매이션 재생
timing = -1;
image_speed = (o_gamecontroller.onoff == 1) ? 1:-1
}

if (timing == -1){	// 애니메이션 정지 및 onoff 바꾸기
    var current_frame = floor(image_index); 
    if (o_gamecontroller.onoff == 1){
        if (current_frame == 6) {
            image_index = 6;
            image_speed = 0;
            o_gamecontroller.onoff = 0;
            timing = 0;
        }
    }else{
        if (current_frame <= 0) {
            image_index = 0;
            image_speed = 0;
            o_gamecontroller.onoff = 1;
            timing = 0;
        }
    }
}