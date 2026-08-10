if (global.paused) exit;
dashcool --
scool --
sdur --
timenodeath --
if dashcool <= 0{	//대시 끝나면 대시 스피드 초기화
	dashspeed = 40
}
if (jump_save > 0){	//점프 디버깅
jump_save --
}
//이동 코드
if (sdur <= 0){
if (dashcool <= 20){
key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
if key_right{	//대시 방향 정하기
	dashdir = 2
}else if key_left{
	dashdir = -2
}
hsp = (key_right - key_left) * movespeed;

var _dash_dist = dashup ? (dashdir * 3) : dashdir;	//벽 충돌 방지용 변수
if (place_meeting(x + hsp, y, global.mainwalls)) {
    while (!place_meeting(x + sign(hsp), y, global.mainwalls)) {
        x += sign(hsp);
    }
    hsp = 0;
}else if (place_meeting(x + _dash_dist, y, global.mainwalls)) {
    while (!place_meeting(x + sign(_dash_dist), y, global.mainwalls)) {
        x += sign(_dash_dist);
    }
    dashspeed = 0;
}
x += hsp
}

	//벽 끼임 탈출 코드
if (place_meeting(x, y, global.dashwalls)) {
    var _dir = -sign(dashdir)
    if (_dir == 0) _dir = -1; // 혹시 몰라서 넣음. 기본값 왼쪽
    while (place_meeting(x, y, global.dashwalls)) {
        x += _dir;
    }
}else if (!place_meeting(x, y, global.dashwalls) && place_meeting(x, y, global.mainwalls)){
	var _dir = sign(dashdir);
    if (_dir == 0) _dir = -1;
    while (place_meeting(x, y, global.mainwalls)) {
        x += _dir;
    }
}


if (dashcool > 20) {	//대시 코드
	if(dashup == false){
	repeat(abs(round(dashspeed))) {
		if (!place_meeting(x + dashdir, y, global.dashwalls)) {
			x += dashdir;
		}else {
			dashcool = 0;
			dashspeed = 0;
			break;
		}
	}
	dashspeed *= 0.85
	}else if(dashup == true){	//강화 대시
		dashup_jump = 1;
			repeat(abs(round(dashspeed))) {
		if (!place_meeting(x + dashdir, y, global.dashwalls)) {
			x += dashdir * 3;
		}else {
			dashcool = 0;
			dashspeed = 0;
			break;
		}
	}
	dashspeed *= 0.65
	
}
}
}
	
//----------------------

//점프 및 중력 코드
if (place_meeting(x, y+speedy, global.mainwalls)){	//벽에 닿을시 멈추는거 22
	while (!place_meeting(x, y+sign(speedy), global.mainwalls)) {
		y += sign(speedy)
}
speedy = 0
dashup_jump = 0
}
y += speedy
speedy += grav
if(sdur <= 0){	//점프 코드
if (keyboard_check_pressed(vk_space)) {
jump_save = 7	
}
}
if (jump_save > 0) { //점프 디버깅
	if (place_meeting(x, y+1, global.mainwalls)){
		speedy -= jumpheight;
		jump_save = 0
	}else if (dashup_jump == 1){
		dashup_jump = 0
		speedy = 0
		speedy -= power(jumpheight, 2)*0.05;
		jump_save = 0
	}
} 
//---------------------
if place_meeting(x, y, global.damage) && timenodeath <= 0 && dashcool <= 0 && sdur <= 0{	//피격 코드
	global.player_hp -= 1
	timenodeath = 60
}
if (timenodeath > 0) {	//무적시 깜빡이는 효과
    if (timenodeath % 20 < 10) {
        image_alpha = 0.1
    } else {
        image_alpha = 1
    }
}else{
    image_alpha = 1
}
//--------------------

if (keyboard_check_pressed(ord("E")) && dashcool <= 0 && sdur <= 0){	//대시 버튼
	dashcool = 30
}
if (keyboard_check_pressed(ord("Q")) && scool <= 0){	//실드 버튼
	sdur = 60
	scool = 300
}

if (keyboard_check_pressed(ord("N"))){
	if(room = Room2){
		room_goto(Room3)
	}else{
	room_goto_next()
}
}

