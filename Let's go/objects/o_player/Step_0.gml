dashcool--
if dashcool <= 0{	//대시 끝나면 대시 스피드 초기화
	dashspeed = 40
}
if (jump_save > 0){	//점프 디버깅
jump_save --
}
//이동 코드
if (dashcool <= 0){
key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
if key_right{	//대시 방향 정하기
	dashdir = 2
}else if key_left{
	dashdir = -2
}
hsp = (key_right - key_left) * movespeed;
if (place_meeting(x+hsp, y, global.mainwalls)){	//벽에 닿을시 멈추는 코드
	while (!place_meeting(x+hsp, y, global.mainwalls)) {
		x += sign(hsp)
}
hsp = 0
}
x += hsp
}
if (dashcool > 0) {	//대시 코드
	repeat(abs(round(dashspeed))) {
		if (!place_meeting(x + dashdir, y, global.dashwalls)) {
			x += dashdir
		}else {
			dashcool = 0
			dashspeed = 0
			break
		}
	}
	dashspeed *= 0.85
	if (abs(dashspeed) < 1) {
		dashcool = 0
		dashspeed = 0
	}
}
	
//----------------------

//점프 및 중력 코드
if (place_meeting(x, y+speedy, global.mainwalls)){	//벽에 닿을시 멈추는거 22
	while (!place_meeting(x, y+sign(speedy), global.mainwalls)) {
		y += sign(speedy)
}
speedy = 0
}
y += speedy
speedy += grav
if (keyboard_check_pressed(vk_space)) {	//점프 코드
jump_save = 7	
}
if (jump_save > 0  && place_meeting(x, y+1, global.mainwalls)) {	//점프 디버깅
speedy -= jumpheight;
jump_save = 0
} 
//---------------------
if (keyboard_check_pressed(ord("E")) && dashcool <= 0){	//대시 버튼
	dashcool = 10
}