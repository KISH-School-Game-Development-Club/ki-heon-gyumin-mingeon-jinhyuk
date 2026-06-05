enum STATE {
	NORMAL,
	FREEZE_TIME,
}

global.mainwalls = [o_wall, o_floor_test_ver, o_wall2];//벽 그룹
global.dashwalls = [o_wall, o_floor_test_ver];//통과 불가 벽 그룹
global.damage = [op_enemy, o_enemy2, o_trigger_spike1];

function enemyAI (moverange, movesp, view_range, attack_range){
	if (!variable_instance_exists(id, "state")){	//변수 정리
		startpoint = x
		state = EnemyState.PATROL
		movedir = 1
		attacktimer = 0
		DetectPlayer = false
		detecttimer = 60
		attackcool = 0
	}
	if (!instance_exists(o_player)) return;	//플레이어가 없을 시 행동 X
	if (attackcool > 0) attackcool--;	//공격 쿨 감소
	dist = point_distance(x, y, o_player.x, o_player.y)
	See_player = false
	if (dist <= view_range){	//시야에 감지될시 추적
		if (state == EnemyState.CHASE || sign(o_player.x - x) == movedir){
			if (!collision_line(x, y, o_player.x, o_player.y, global.mainwalls, false, true)){
				See_player = true
			}
		}
	}
	if (See_player){
		DetectPlayer = true
		detecttimer = 60
	} else {	//추적 취소 코드
		if (state == EnemyState.CHASE){
			detecttimer--
			if (detecttimer <= 0){
				DetectPlayer = false
				state = EnemyState.PATROL
				detecttimer = 60
			}
		}
	}
	// 상태
	switch(state){	
		case EnemyState.PATROL:
			if (DetectPlayer == true){
				state = EnemyState.CHASE
			}
		break
		
		case EnemyState.CHASE:
			if (dist <= attack_range && attackcool <= 0){
				state = EnemyState.ATTACK
				attacktimer = 40
			}
		break
		
		case EnemyState.ATTACK:
		break
	}
	// 행동
	move_x = 0; 
	switch(state){	
		case EnemyState.PATROL:
			image_index = 0
			move_x = movesp * movedir
			
			if (x + move_x >= startpoint + moverange){
				movedir = -1
			}
			if (x + move_x <= startpoint){
				movedir = 1
			}
		break
		case EnemyState.CHASE:
			image_index = 1
			movedir = sign(o_player.x - x)
			if (movedir == 0) movedir = 1 
			
			move_x = movesp * 1.2 * movedir

			if (place_meeting(x + move_x, y, o_player)) {
				while (!place_meeting(x + sign(move_x), y, o_player)) {
					x += sign(move_x)
				}
				move_x = 0
			}
		break

		case EnemyState.ATTACK:
			image_index = 1
			if (attacktimer == 40){
				if (x < o_player.x){
					movedir = 1
				}else{
					 movedir = -1
				} 
			}
			if (attacktimer > 30){
				move_x = -movedir * 2 // 뒤로 물러남
			} else if (attacktimer < 10){		
				move_x = movedir * 32 // 돌진
			}
			attacktimer--;
			if (attacktimer <= 0){
				state = EnemyState.CHASE
				attacktimer = 0
				attackcool = 120
			}
		break
	}
	// 벽 충돌 
	if (move_x != 0) {
		if (place_meeting(x + move_x, y, global.mainwalls)){
			while (!place_meeting(x + sign(move_x), y, global.mainwalls)) {
				x += sign(move_x)
			}
			movedir = movedir * -1
			if (state == EnemyState.CHASE){
				state = EnemyState.PATROL
			}
		} else {
			x += move_x
		}
	}
}