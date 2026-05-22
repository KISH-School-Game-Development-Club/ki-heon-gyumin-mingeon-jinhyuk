//이동 코드
key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
hsp = (key_right - key_left) * movespeed;
if (place_meeting(x+hsp, y, global.collidable)){	//벽에 닿을시 멈추는 코드
	while (!place_meeting(x+hsp, y, global.collidable)) {
		x += sign(hsp)
}
hsp = 0
}

x += hsp
//----------------------

//점프 및 중력 코드
if (place_meeting(x, y+speedy, global.collidable)){	//벽에 닿을시 멈추는거 22
	while (!place_meeting(x, y+speedy, global.collidable)) {
		y += sign(speedy)
}
speedy = 0
}
y += speedy
speedy += grav

if (keyboard_check_pressed(vk_space)) {	//점프 코드
	if (place_meeting(x, y+speedy, global.collidable)) {
	speedy -= jumpheight;
}
}
//---------------------

