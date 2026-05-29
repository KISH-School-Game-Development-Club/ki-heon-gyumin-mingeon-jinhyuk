if (place_meeting(x, y+speedy, global.mainwalls)){	//벽에 닿을시 멈추는거 22
	while (!place_meeting(x, y+sign(speedy), global.mainwalls)) {
		y += sign(speedy)
}
speedy = 0
}
y += speedy
speedy += grav

x += movesp * movedir
if (x >= startpoint + moverange){
	movedir = -1
}
if (x<= startpoint){
	movedir = 1
}
if (place_meeting(x+movesp, y, global.mainwalls)){	//벽에 닿을시 멈추는 코드
		o_player.test = 1
		x += -movesp*movedir
}