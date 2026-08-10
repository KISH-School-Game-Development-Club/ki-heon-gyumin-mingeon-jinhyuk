if (global.paused) exit;
if (place_meeting(x, y+speedy, global.mainwalls)){	//벽에 닿을시 멈추는거 22
	while (!place_meeting(x, y+sign(speedy), global.mainwalls)) {
		y += sign(speedy)
}
speedy = 0
}
y += speedy * jumpslow
speedy += grav

bossAI(1000, 3, 1000, 300, 10)