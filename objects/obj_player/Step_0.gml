/// @description Runs every frame
//control
var up_key = global.upbuttonpressed
var down_key = global.downbuttonpressed
var left_key  = global.leftbuttonpressed
var right_key = global.rightbuttonpressed

//movement
if(keyboard_check(vk_shift) or keyboard_check(ord("X"))){
	move_spd = run_spd
} else{
	move_spd = walk_spd
}

xspd = (right_key - left_key) * move_spd
yspd = (down_key - up_key) * move_spd

//collision
if(place_meeting(x + xspd, y, obj_collider)){
	xspd = 0
}
if(place_meeting(x, y + yspd, obj_collider)){
	yspd = 0
}

x += xspd
y += yspd

//animate
if(xspd > 0){
	sprite_index = spr_noellewr
} else if(xspd < 0){
	sprite_index = spr_noellewl
} else if(yspd > 0){
	sprite_index = spr_noellewd
} else if(yspd < 0){
	sprite_index = spr_noellewu
}

if(xspd != 0 or yspd != 0){
	image_speed = 1
} else{
	image_speed = 0
	image_index = 0
}

//step when move key is tapped
if global.upbuttonpressed{
	image_index = 1
}
if global.downbuttonpressed{
	image_index = 1
}
if global.leftbuttonpressed{
	image_index = 1
}
if global.rightbuttonpressed{
	image_index = 1
}

//don't shake
x[0] = round(x[0.1])
y[0] = round(y[0.1])

//keep track of direction facing
if(sprite_index = spr_noellewd){
	facing_direction = 2
}
if(sprite_index = spr_noellewu){
	facing_direction = 3
}
if(sprite_index = spr_noellewr){
	facing_direction = 0
}
if(sprite_index = spr_noellewl){
	facing_direction = 1
}

//save direction facing
if place_meeting(x, y, obj_save){

	if sprite_index = spr_noellewd{
		facing_direction = 0
	}
	if sprite_index = spr_noellewl{
		facing_direction = 1
	}
	if sprite_index = spr_noellewr{
		facing_direction = 2
	}
	if sprite_index = spr_noellewu{
		facing_direction = 3
	}

}

//update pos for party follow

	if (x != xprevious or y != yprevious) and !instance_exists(obj_fade){
		
		for(follow_pos = follow_points - 1; follow_pos > 0; follow_pos--){
		
		player_x[follow_pos] = player_x[follow_pos-1]
		player_y[follow_pos] = player_y[follow_pos-1]
		
		past_facing[follow_pos] = past_facing[follow_pos-1]
		
		}
		
		player_x[0] = x
		player_y[0] = y
		past_facing[0] = sprite_index
		
	}

