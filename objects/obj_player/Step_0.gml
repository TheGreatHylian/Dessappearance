/// @description Runs every frame
//control
var cEnabled = mControl.isControlEnabled("player")
var up    = global.upbuttonpressed && cEnabled;
var down  = global.downbuttonpressed && cEnabled;
var left  = global.leftbuttonpressed && cEnabled;
var right = global.rightbuttonpressed && cEnabled;
var sprint= global.sprintbuttonpressed && cEnabled;
var tap = (
    (global.upbuttonpressed1 || global.downbuttonpressed1 ||
     global.leftbuttonpressed1 || global.rightbuttonpressed1)
    &&
    !(up || down || left || right) && cEnabled // ← ensures no key is held
);
var select= global.selectbuttonpressed && cEnabled;

move_spd = sprint ? run_spd : walk_spd;

xspd = (right - left) * move_spd;
yspd = (down - up) * move_spd;

//collision
if(place_meeting(x + xspd, y, obj_collider)){
	xspd = 0
}
if(place_meeting(x, y + yspd, obj_collider)){
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

//step when move key is tapped
if global.upbuttonpressed1 or global.downbuttonpressed1 or global.leftbuttonpressed1 or global.rightbuttonpressed1{
	image_index = 1
	endpress = true
}

if(xspd != 0 or yspd != 0){
	image_speed = 1
} else{
	image_speed = 0
	image_index = 0
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