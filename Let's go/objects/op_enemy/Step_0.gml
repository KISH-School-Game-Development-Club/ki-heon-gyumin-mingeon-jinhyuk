if (global.paused) exit;
//y축 이동 코드
if (place_meeting(x, y+speedy, global.mainwalls)){	//벽에 닿을시 멈추는거 22
	while (!place_meeting(x, y+sign(speedy), global.mainwalls)) {
		y += sign(speedy)
}
speedy = 0
}
y += speedy
speedy += grav
//x축 이동 코드
enemyAI(moverange, 3, 450, 150, 5, 1)
timenodeath_enemy--
