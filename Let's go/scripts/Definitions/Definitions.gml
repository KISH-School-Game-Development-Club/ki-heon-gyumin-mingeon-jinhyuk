global.mainwalls = [o_wall, o_floor_test_ver, o_wall2];//벽 그룹
global.dashwalls = [o_wall, o_floor_test_ver, o_onoffwall];//통과 불가 벽 그룹
global.damage = [o_trigger_spike1, o_bullet, o_bullet_opposite, o_bulletenemy];
global.ppwalls = []; //실드 벽(미구현)
global.paused = false; //일시정지
global.player_hp = 10;
enum nothing {
	NORMAL,
	ATTACK_AVOID,
	KILL
	
}


function enemyAI (moverange, movesp, view_range, attack_range, enemyhp, enemyid){
	if (!variable_instance_exists(id, "state")){	//변수 정리
		see_view_range = view_range
		startpoint = x
		enemy_hp = enemyhp
		state = EnemyState.PATROL
		movedir = 1
		attacktimer = 0
		DetectPlayer = false
		detecttimer = 60
		attackcool = 0
		timenodeath_enemy = 0
		stuntimer = 120
		stunning = false
		invisible = false
		effect_stun = 0
		if (enemyid == 3){
			invisible_duration = 180
		}
	}
	if (!instance_exists(o_player)) return;	//플레이어가 없을 시 행동 X
	
	if (attackcool > 0) attackcool--;	//공격 쿨 감소
	
	var dist = collision_rectangle(x + view_range, y - 100, x - view_range, y + 20, o_player, false, true) 
	var See_player = false
	
	if (dist){	//시야에 감지될시 추적
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
				invisible = false
				detecttimer = 60
			}
		}
	}
	
	// 상태
	switch(state){	
		case EnemyState.PATROL:
			if (DetectPlayer == true){
				state = EnemyState.CHASE
				instance_create_layer(x+25, y-25, "Instances", o_enemy_effect_detect);
			}
		break;
		
		case EnemyState.CHASE:
		var attack_dist = collision_rectangle(x + attack_range, y - 20, x - attack_range, y + 20, o_player, false, true);
			if (attack_dist && attackcool <= 0){
				state = EnemyState.ATTACK
				if enemyid != 3{
					attacktimer = 40
				}else{
					attacktimer = 30
				}
			}
		break;
		
		case EnemyState.ATTACK:
		break;
		
		case EnemyState.STUN:
			if stuntimer <= 0{
				state = EnemyState.PATROL;
				stuntimer = 60;
				effect_stun = 0;
				instance_destroy(s_effect_stun);
			}else{
				stuntimer --
			}
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
			if (enemyid == 3) { //암살자 추적
				if (attackcool <= 0) {
					invisible = true;
					movedir = sign(o_player.x - x);
					if (movedir == 0) movedir = 1; 
					move_x = movesp * 1.5 * movedir; // 은신 중엔 약간 빠르게 이동
				}else{
					is_invisible = false;
					if (dist < view_range * 0.6) {
						movedir = -sign(o_player.x - x);
						if (movedir == 0) movedir = 1;
						move_x = movesp * random_range(0.5, 1.2) * movedir; // 뒤로 도망
					}else{
						move_x = 0; 
						movedir = sign(o_player.x - x);
					}
				}
			} else {
			movedir = sign(o_player.x - x)
			if (movedir == 0) movedir = 1 
			move_x = movesp * 1.2 * movedir
			}

			if (place_meeting(x + move_x, y, o_player)) {
				if (enemyid != 3 || attackcool > 0) { 
					while (!place_meeting(x + sign(move_x), y, o_player)) {
						x += sign(move_x)
					}
					move_x = 0
				}
			}
			break

		case EnemyState.ATTACK:
		invisible = false;
		if enemyid == 1{	//일반 몹
			image_index = 1
			if (attacktimer == 40){
				if (x < o_player.x){
					movedir = 1
				}else{
					movedir = -1
				} 
			}
			if (attacktimer > 30){
				move_x = -movedir * 2// 뒤로 물러남
			} else if (attacktimer < 10 && 0 < attacktimer){
				if (array_get_index(global.damage, id) == -1) {
					array_push(global.damage, id);
				}
				move_x = movedir * 32// 돌진
			} else if(attacktimer <= 0){
				if(array_get_index(global.damage, id) != -1){
					var _index = array_get_index(global.damage, id);
					array_delete(global.damage, _index, 1);
				}
			}
		}else if enemyid == 2{	//마법사 몹
				if (x < o_player.x){
					movedir = 1
				}else{
					 movedir = -1
				} 
			if (attacktimer > 15){
				move_x = -movedir * 12// 뒤로 물러남
			}else if (attacktimer <= 1){
			var _bullet = instance_create_layer(x, y, "enemy", o_bulletenemy);
			_bullet.my_dir = movedir; 
			}
			}else if enemyid == 3{
				image_index = 1;
				if (attacktimer == 30){
					movedir = (x < o_player.x)? 1:-1;
				}else if (attacktimer > 20){
					move_x = 0;
				}else if (attacktimer < 10 && attacktimer > 0) {
					if (array_get_index(global.damage, id) == -1) array_push(global.damage, id);
					move_x = movedir * 60; 
				}else if(attacktimer <= 0){
					if(array_get_index(global.damage, id) != -1){
						var _index = array_get_index(global.damage, id);
						array_delete(global.damage, _index, 1);
					}
				}
			}
			attacktimer--;
			
			if (attacktimer <= 0 && array_get_index(global.damage, id) == -1){
				if (stunning == 0){
				state = EnemyState.CHASE
				attacktimer = 0
				if enemyid != 3{
					attackcool = 120
				}else{
					attackcool = 240
				}
				}else{
				state = EnemyState.STUN
				stunning = false
				attacktimer = 0
				if enemyid != 3{
					attackcool = 120
				}else{
					attackcool = 240
				}
				}
			}
		break
		case EnemyState.STUN:
		invisible = false;
		if effect_stun == 0{
			instance_create_layer(x, y, "effect", o_effect_stun);
			effect_stun = 1;
		}
		break;
	}
	//은신 투명도
	if (invisible) {
		if (image_alpha > 0.05){
		image_alpha -= 0.19;
		}
	} else {
		image_alpha = 1;
	}
	// 벽 충돌 
	if (move_x != 0) {
		if (place_meeting(x + move_x, y, global.mainwalls) || place_meeting(x + move_x, y, global.ppwalls)){
			while (!place_meeting(x + sign(move_x), y, global.mainwalls) && !place_meeting(x + sign(move_x), y, global.ppwalls)) {
				x += sign(move_x)
			}
			movedir = movedir * -1
			if (state == EnemyState.CHASE){
				state = EnemyState.PATROL
			}else if (state == EnemyState.ATTACK){
				if (enemyid != 2){
				stunning = true;
				}
			}
		} else {
			x += move_x
		}
	}
	if place_meeting(x, y, o_player){
		if (o_player.dashcool > 0 && timenodeath_enemy <= 0){
			enemy_hp --
			timenodeath_enemy = 30
			if enemy_hp <= 0{
				instance_destroy();
			}
		}
}
}
function bossAI (moverange, movesp, view_range, attack_range, enemyhp){
	if (!variable_instance_exists(id, "boss_state")){
		startpoint = x
		enemy_hp = enemyhp
		boss_state = "CHASE"
		movedir = 1
		attack_timer = 0
		attack_cool = 60
		pattern_choice = 0
		timenodeath_enemy = 0
		jump_stage = 0
		jump_timer = 0
		jumpslow = 1
		see_attack_range = attack_range
	}
	
	if (!instance_exists(o_player)) return;
	if (attack_cool > 0) attack_cool--;	// 공격 쿨타임 감소
	if (timenodeath_enemy > 0) timenodeath_enemy--; // 피격 무적 타이머 감소
	
	var dist = collision_rectangle(x + attack_range, y - 50, x - attack_range, y + 50, o_player, false, true);
	move_x = 0;
	move_y = 0;
	//상태 및 패턴
	switch(boss_state){	
		case "CHASE":
			movedir = (o_player.x > x) ? 1 : -1;
			move_x = movesp * 0.8 * movedir; 
			if (dist && attack_cool <= 0){
				pattern_choice = choose(3); // 1:돌진, 2:점프, 3:땅울림
				if (pattern_choice == 1) {
					boss_state = "dash";
					attack_timer = 120;
				} else if (pattern_choice == 2) {
					boss_state = "jump";
					attack_timer = 180;
					jump_stage = 0;
				} else if (pattern_choice == 3) {
					boss_state = "ground";
					attack_timer = 80; //미완
				}
			}
		break;
		
		case "dash":
			if (attack_timer == 120) {
				movedir = (o_player.x > x) ? 1 : -1; // 돌진 방향 고정
			}
			if (attack_timer > 60) {
				move_x = -movedir * 1;	//잠시 뒷걸음질
			} else if (attack_timer > 80){
				move_x = 0;	//대기
			} else if (attack_timer > 0) {
				if (array_get_index(global.damage, id) == -1) array_push(global.damage, id);
				move_x = movedir * 45; //돌진
			} else {
				if (array_get_index(global.damage, id) != -1) {
					var _index = array_get_index(global.damage, id);
					array_delete(global.damage, _index, 1);
				}
				move_x = 0;
			}
		break;
		
		case "jump":
			if (jump_stage == 0) {
				move_x = 0;
				if (attack_timer < 170) jump_stage = 1;	//10프레임 대기
			}else if (jump_stage == 1){	//점프
				speedy -= 35;
				jump_stage = 2;
				}else if (jump_stage == 2){
				move_x = sign(o_player.x - x) * movesp * 3;
				if (speedy > -15) {
					jump_stage = 3;
					jump_timer = 70; 
				}
			}else if (jump_stage == 3){
				move_x = sign(o_player.x - x) * movesp * 3;
				if (jump_timer > 0) {
					jump_timer--;
					jumpslow = 0.3; 
				}				
				if (speedy >= 0) {
					jump_stage = 4;
				}
			}else if (jump_stage == 4) {
				jumpslow = 1;
				move_x = 0;
				speedy = 100;
				if (place_meeting(x, y + speedy, global.mainwalls)) {
					jump_stage = 5;
					attack_timer = 25;
					if (array_get_index(global.damage, id) == -1) array_push(global.damage, id);
				}
			}else if (jump_stage == 5) {
				move_x = 0;
				if (attack_timer <= 5) {
					if (array_get_index(global.damage, id) != -1) {
						var _index = array_get_index(global.damage, id);
						array_delete(global.damage, _index, 1);
					}
				}
			}
		break;
		
		case "ground":
			move_x = 0;
			if (attack_timer > 70) {
				move_x = -movedir * 3;	//빠른 뒷걸음질
			} else if (attack_timer >= 50) {
				if (speedy >= -1){
					speedy = -10;
				}else{
					speedy = 50
					if (array_get_index(global.damage, id) == -1) array_push(global.damage, id);
				}
				if (dist < attack_range * 1.5) {
					o_player.x += sign(o_player.x - x) * 32; // 플레이어를 반대 방향으로 밀어냄
				}
			} else if (attack_timer <= 20) {
				// [후딜레이] 판정 지우고 자세 회복
				if (array_get_index(global.damage, id) != -1) {
					var _index = array_get_index(global.damage, id);
					array_delete(global.damage, _index, 1);
				}
			}
		break;
	}
	
	// 타이머 감소 및 상태 복귀 처리
	if (boss_state != "CHASE") {
		attack_timer--;
		if (attack_timer <= 0) {
			boss_state = "CHASE";
			attack_cool = choose(90, 120, 150); // 패턴 종료 후 다음 공격까지 현자타임 (무작위)
		}
	}

	// 2. 물리 이동 및 벽 충돌 시스템 (가로)
	if (move_x != 0) {
		if (place_meeting(x + move_x, y, global.mainwalls)  || place_meeting(x + move_x, y, global.ppwalls)){
			while (!place_meeting(x + sign(move_x), y, global.mainwalls) && !place_meeting(x + sign(move_x), y, global.ppwalls)) {
				x += sign(move_x)
			}
			move_x = 0;
		} else {
			x += move_x
		}
	}
	
	// 4. 보스 피격 판정 (플레이어가 대시 공격 중일 때)
	if place_meeting(x, y, o_player){
		if (o_player.dashcool > 0 && timenodeath_enemy <= 0){
			enemy_hp--;
			timenodeath_enemy = 20;
			if (enemy_hp <= 0){
				instance_destroy();
			}
		}
	}
}
	