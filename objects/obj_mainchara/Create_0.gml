/// @description Runs upon creation
//define variables
xspd = 0
yspd = 0

move_spd = 2
walk_spd = 2.4
run_spd = 2.6

can_move = true

facing_direction = "down"

party_follow = false

endpress = false

//load direction facing
facing_direction = global.facing
if facing_direction = "down"{
	sprite_index = spr_ynoellewd
}
if facing_direction = "left"{
	sprite_index = spr_ynoellewl
}
if facing_direction = "right"{
	sprite_index = spr_ynoellewr
}if facing_direction = "up"{
	sprite_index = spr_ynoellewu
}

//store past positions for the party
follow_points = 100
for(follow_pos = follow_points -1; follow_pos >= 0; follow_pos--){
	mainchara_x[follow_pos] = x
	mainchara_y[follow_pos] = y
	
	past_facing[follow_pos] = sprite_index
}