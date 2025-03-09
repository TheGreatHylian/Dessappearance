//animate
if inparty = true{
	sprite_index = spr_ralswd
} else if inparty = true{
	sprite_index = spr_ralswl
} else if inparty = true{
	sprite_index = spr_ralswr
} else if inparty = true{
	sprite_index = spr_ralswu
}

//don't shake
x[0] = round(x[0.1])
y[0] = round(y[0.1])

//party follow
if inparty = true and obj_player.follow_points > 0{


	npc_mode = false
	
	if global.entered_new_room = true{
	
	if global.new_room_facing = spr_noellewd{
		sprite_index = spr_ralswd
		new_room_facing = sprite_index
	}
	
	if global.new_room_facing = spr_noellewl{
		sprite_index = spr_ralswl
		new_room_facing = sprite_index
	}
	
	if global.new_room_facing = spr_noellewr{
		sprite_index = spr_ralswr
		new_room_facing = sprite_index
	}
	
	if global.new_room_facing = spr_noellewu{
		sprite_index = spr_ralswu
		new_room_facing = sprite_index
	}
	
	if sprite_index != new_room_facing{
		global.entered_new_room = false
	}
	
	}
	
	if global.party_member_1 = obj_ralsei{
		switch(obj_player.past_facing[global.party_member_1_follow_distance]){
	
			case spr_noellewd: sprite_index = spr_ralswd; break;
			case spr_noellewl: sprite_index = spr_ralswl; break;
			case spr_noellewr: sprite_index = spr_ralswr; break;
			case spr_noellewu: sprite_index = spr_ralswu; break;
	
		}
	
		if obj_player.player_x[global.party_member_1_follow_distance] != 0{
			x = obj_player.player_x[global.party_member_1_follow_distance]
			y = obj_player.player_y[global.party_member_1_follow_distance]
		} else{
			if instance_exists(obj_fade){
				x = obj_fade.target_x
				y = obj_fade.target_y
			}
		}
	}
	
	if global.party_member_2 = obj_ralsei{
		switch(obj_player.past_facing[global.party_member_2_follow_distance]){
			
			case spr_noellewd: sprite_index = spr_ralswd; break;
			case spr_noellewl: sprite_index = spr_ralswl; break;
			case spr_noellewr: sprite_index = spr_ralswr; break;
			case spr_noellewu: sprite_index = spr_ralswu; break;
	
		}
	
		if obj_player.player_x[global.party_member_2_follow_distance] != 0{
			x = obj_player.player_x[global.party_member_2_follow_distance]
			y = obj_player.player_y[global.party_member_2_follow_distance]
		} else{
			if instance_exists(obj_fade){
				x = obj_fade.target_x
				y = obj_fade.target_y
			}
		}
	}
	
	if x != xprevious or y != yprevious{
		image_speed = 1
	} else{
		image_speed = 0
		image_index = 0
	}
	
}

if inparty = false{

	image_speed = 0
	npc_mode = true

}