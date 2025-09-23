/// @description Runs every frame
//control
var cEnabled = mControl.isControlEnabled("player")
var up    = global.upbuttonpressed && cEnabled and can_move = true;
var down  = global.downbuttonpressed && cEnabled and can_move = true;
var left  = global.leftbuttonpressed && cEnabled and can_move = true;
var right = global.rightbuttonpressed && cEnabled and can_move = true;
var sprint= global.sprintbuttonpressed && cEnabled;
var select= global.selectbuttonpressed && cEnabled;

if instance_exists(mObjDlg){
	can_move = false
}

move_spd = sprint ? run_spd : walk_spd;

xspd = (right - left) * move_spd;
yspd = (down - up) * move_spd;

//collision
if place_meeting(x + xspd, y, obj_collider){
	xspd = 0
}
if place_meeting(x, y + yspd, obj_collider){
	yspd = 0
}

/// @arg inst   Instance of obj_interactbox
/// @arg facing player.facing_direction (0=R,1=L,2=U,3=D)
function can_interact(inst, facing) {
    var off = inst.interact_off;
    switch (facing) {
        case 0: return place_meeting(x + off, y, inst) && x < inst.x;
        case 1: return place_meeting(x - off, y, inst) && x > inst.x;
        case 2: return place_meeting(x, y + off, inst) && y < inst.y;
        case 3: return place_meeting(x, y - off, inst) && y > inst.y;
    }
    return false;
}
var ledx = xspd/4
if (instance_place(x + ledx, y, obj_interact) != noone) {
    var ib = instance_place(x + ledx, y, obj_interact);
    if (ib.blockMovement) {
        x -= xspd;
    }
}
var ledy = yspd/4
if (instance_place(x, y + ledy, obj_interact) != noone) {
    var ib = instance_place(x, y + ledy, obj_interact);
    if (ib.blockMovement) {
        y -= yspd;
    }
}
if (select) {
    var ib_near = instance_nearest(x, y, obj_interact);
    if (ib_near != noone && can_interact(ib_near, facing_direction)) {
        ib_near.interactAct(self);
    }
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
	facing_direction = 2
}
if(sprite_index = spr_ynoellewu){
	facing_direction = 3
}
if(sprite_index = spr_ynoellewr){
	facing_direction = 0
}
if(sprite_index = spr_ynoellewl){
	facing_direction = 1
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

//animation contd
if (xspd != 0 || yspd != 0) {
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
if facing_direction = 2{
	instance_create_depth(x, y+16, depth-1, obj_interactlaser_v)
}

//up
if facing_direction = 3{
	instance_create_depth(x, y, depth-1, obj_interactlaser_v)
}

//right
if facing_direction = 0{
	instance_create_depth(x+8, y+6, depth-1, obj_interactlaser_h)
}

//left
if facing_direction = 1{
	instance_create_depth(x-8, y+6, depth-1, obj_interactlaser_h)
}

}