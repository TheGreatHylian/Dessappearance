/// @description Runs upon creation
//define variables
xspd = 0
yspd = 0

move_spd = 2
walk_spd = 2.4
run_spd = 3.4

facing_direction = 2

party_follow = false

//load direction facing
ini_open("dessappearance.ini")
facing_direction = ini_read_real("Save1", "facing", 2)
if facing_direction = 0{
	sprite_index = spr_noellewd
}
if facing_direction = 1{
	sprite_index = spr_noellewl
}
if facing_direction = 2{
	sprite_index = spr_noellewr
}if facing_direction = 3{
	sprite_index = spr_noellewu
}
ini_close()

//store past positions for the party
follow_points = 100
for(follow_pos = follow_points -1; follow_pos >= 0; follow_pos--){
	player_x[follow_pos] = x
	player_y[follow_pos] = y
	
	past_facing[follow_pos] = sprite_index
}