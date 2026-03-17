/// @description Runs every frame
//control
var up_key = global.upbuttonpressed and can_move
var down_key = global.downbuttonpressed and can_move
var left_key  = global.leftbuttonpressed and can_move
var right_key = global.rightbuttonpressed and can_move

//movement
if global.sprintbuttonpressed{
	move_spd = run_spd
} else{
	move_spd = walk_spd
}

xspd = (right_key - left_key) * move_spd
yspd = (down_key - up_key) * move_spd

//collision
if place_meeting(x + xspd, y, obj_collider){
	xspd = 0
}
if place_meeting(x, y + yspd, obj_collider){
	yspd = 0
}

if can_move = true{
	x += xspd
	y += yspd
}

//animate
if(xspd > 0){
	sprite_index = spr_ynoellewr
} else if(xspd < 0){
	sprite_index = spr_ynoellewl
} else if(yspd > 0){
	sprite_index = spr_ynoellewd
} else if(yspd < 0){
	sprite_index = spr_ynoellewu
}

if(xspd != 0 or yspd != 0) and can_move = true{
	image_speed = 1
} else{
	image_speed = 0
	image_index = 0
}

//don't shake
x[0] = round(x[0.1])
y[0] = round(y[0.1])

//keep track of direction facing
if(sprite_index = spr_ynoellewd){
	facing_direction = "down"
}
if(sprite_index = spr_ynoellewu){
	facing_direction = "up"
}
if(sprite_index = spr_ynoellewr){
	facing_direction = "right"
}
if(sprite_index = spr_ynoellewl){
	facing_direction = "left"
}

//update pos for party follow

if (x != xprevious or y != yprevious) and !instance_exists(obj_fade){
		
	for(follow_pos = follow_points - 1; follow_pos > 0; follow_pos--){
		
	mainchara_x[follow_pos] = mainchara_x[follow_pos-1]
	mainchara_y[follow_pos] = mainchara_y[follow_pos-1]
		
	past_facing[follow_pos] = past_facing[follow_pos-1]
		
	}
		
	mainchara_x[0] = x
	mainchara_y[0] = y
	past_facing[0] = sprite_index
		
}

//animation contd
if (xspd != 0 or yspd != 0) {
	image_speed = 1;
}
else {
	image_speed = 0;
	image_index = 0;
}

//tap code
var tap = (global.upbuttonpressed1 or global.downbuttonpressed1 or global.leftbuttonpressed1 or global.rightbuttonpressed1) and can_move = true

if (tap){
    image_index = 1;
    if (global.party_exists) {
        if instance_exists(global.party_member_1) with (global.party_member_1) image_index = 1;
        if instance_exists(global.party_member_2) with (global.party_member_2) image_index = 1;
    }
	
	if xspd = 0 and yspd = 0{
		if global.upbuttonpressed1{
			sprite_index = spr_ynoellewu
		}
		if global.downbuttonpressed1{
			sprite_index = spr_ynoellewd
		}
	
		if global.leftbuttonpressed1{
			sprite_index = spr_ynoellewl
		}
		if global.rightbuttonpressed1{
			sprite_index = spr_ynoellewr
		}
	}
	
}

//interact
if global.selectbuttonpressed  and can_move = true{

//down
if facing_direction = "down"{
	instance_create_depth(x, y+16, depth-1, obj_interactlaser_v)
}

//up
if facing_direction = "up"{
	instance_create_depth(x, y, depth-1, obj_interactlaser_v)
}

//right
if facing_direction = "right"{
	instance_create_depth(x+8, y+6, depth-1, obj_interactlaser_h)
}

//left
if facing_direction = "left"{
	instance_create_depth(x-8, y+6, depth-1, obj_interactlaser_h)
}

}