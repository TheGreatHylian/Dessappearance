//variable
global.start_room = rm_paps
global.start_x = 160
global.start_y = 140

global.new_game = false

global.party_exists = false
global.entered_new_room = false

//control defaults
global.selectbutton = ord("Z")
global.cancelbutton = ord("X")
global.sprintbutton = ord("X")
global.menubutton = ord("C")
global.upbutton = ord("W")
global.downbutton = ord("S")
global.leftbutton = ord("A")
global.rightbutton = ord("D")

//update controls
scr_updatecontrols()

//party ids
global.pn1 = -1 //placeholder1
global.p0 = 0 //susie
global.p1 = 1 //kris
global.p2 = 2 //ralsei

//rooms ids
global.rm0 = 0
global.rm1 = 1
global.rm2 = 2
global.rm3 = 3
global.rm4 = 4
global.rm5 = 5

if(file_exists("dessappearance.ini")){

	instance_create_depth(-60, 67, 100, obj_buttons_continue)

	ini_open("dessappearance.ini")
	global.start_room = ini_read_string("Save1", "room", rm_paps)
	global.start_x = ini_read_real("Save1", "x", 160)
	global.start_y = ini_read_real("Save1", "y", 140)
	global.party_member_1 = ini_read_real("Save1", "Party1", global.p0)
	global.party_member_2 = ini_read_real("Save1", "Party2", global.p1)
	global.party_member_1_follow_distance = ini_read_real("Save1", "Party1 Distance", 40)
	global.party_member_2_follow_distance = ini_read_real("Save1", "Party2 Distance", 80)
	global.party_exists = ini_read_string("Save1", "Party Exists", "false")
	ini_close()

} else{

	instance_create_depth(-60, 67, 100, obj_buttons)

}

if(global.start_room = 0){

	global.start_room = rm_test

}
if(global.start_room = 1){

	global.start_room = rm_paps

}
if(global.start_room = 2){

	global.start_room = rm_test_waterfall

}

//assign party members to correct spot
if global.party_exists = true{
	
	if(global.party_member_1 = -1){

		global.party_member_1 = obj_partyplaceholder1

	}
	if(global.party_member_2 = -1){

		global.party_member_2 = obj_partyplaceholder1

	}
	
	
	if(global.party_member_1 = 0){

		global.party_member_1 = obj_susie

	}
	if(global.party_member_1 = 1){

		global.party_member_1 = obj_kris

	}
	if(global.party_member_1 = 2){

		global.party_member_1 = obj_ralsei

	}
	if(global.party_member_2 = 0){

		global.party_member_2 = obj_susie

	}
	if(global.party_member_2 = 1){

		global.party_member_2 = obj_kris

	}
	if(global.party_member_2 = 2){

		global.party_member_2 = obj_ralsei

	}
}

layer_depth(layer_get_id("Dialogue"), -999)

//control manager code

with(mControl){
	registerControl("title", true);
	registerControl("player", false);
	registerControl("dialogue", false);
}