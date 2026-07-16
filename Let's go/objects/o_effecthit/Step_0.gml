if (global.paused) exit;
if (normalhp != o_player.HP){	//플레이어 피격 확인
	hit = 1;
	normalhp = o_player.HP;
}
if(hit == 1){	//0.5동안 보이기
	if (image_alpha < 1){
		image_alpha = image_alpha + 0.5
	}else{
		hit = 0;
	}
}
if(hit == 0){
	if (image_alpha > 0){
		image_alpha = image_alpha - 0.1;
	}
}
	