if (jump_save > 0){
jump_save --
}
//이동 코드
key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
hsp = (key_right - key_left) * movespeed;
if (place_meeting(x+hsp, y, o_floor_test_ver)){	//벽에 닿을시 멈추는 코드
	while (!place_meeting(x+hsp, y, o_floor_test_ver)) {
		x += sign(hsp)
}
hsp = 0
}
x += hsp
//----------------------

//점프 및 중력 코드

if (place_meeting(x, y+speedy, o_floor_test_ver)){	//벽에 닿을시 멈추는거 22
	while (!place_meeting(x, y+speedy, o_floor_test_ver)) {
		y += sign(speedy)
}
speedy = 0
}
y += speedy
speedy += grav

if (keyboard_check_pressed(vk_space)) {	//점프 코드
jump_save = 30
}
if (jump_save > 0  && place_meeting(x, y+speedy, o_floor_test_ver)) {
speedy -= jumpheight;
jump_save = 0
}
//---------------------