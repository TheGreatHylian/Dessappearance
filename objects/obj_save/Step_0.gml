if place_meeting(x, y, obj_interactlaserparent){
	audio_play_sound(snd_heal, 1, false)
	scr_txtb(box, pos, lines)
	wait = true
}

if wait = true and !instance_exists(mObjDlg){
	instance_create_depth(x, y, -1000, obj_savemenu)
	obj_player.can_move = false
}

if instance_exists(obj_savemenu){
	if obj_savemenu.selected = 1 and global.leftbuttonpressed1 and obj_savemenu.saved = false{
		obj_savemenu.selected = 0
		audio_play_sound(snd_squeak, 1, false)
	}
	if obj_savemenu.selected = 0 and global.rightbuttonpressed1 and obj_savemenu.saved = false{
		obj_savemenu.selected = 1
		audio_play_sound(snd_squeak, 1, false)
	}
	
	//save
	if obj_savemenu.selected = 0 and global.selectbuttonpressed and obj_savemenu.saved = false{
		
		ini_open("dessappearance.ini")
		ini_write_string("Save1", "name", global.name)
		ini_write_string("Save1", "room", room_to_save)
		ini_write_real("Save1", "x", obj_player.x)
		ini_write_real("Save1", "y", obj_player.y)
		ini_write_real("Save1", "facing", obj_player.facing_direction)
		
		//time management
		
		global.oldtime = ini_read_real("Save1", "playtime", 0)
		if global.countmenutime = true{
			global.newtime = current_time - global.menutime - global.savetime
			global.countmenutime = false
		} else{
			global.newtime = current_time - global.savetime
		}
		
		newseconds = floor(global.newtime / 1000)
		newmins = floor((newseconds + 1) / 60)
		newhours = floor((newmins + 1) / 60)

		oldseconds = floor(global.oldtime / 1000)
		oldmins = floor(oldseconds / 60)
		oldhours = floor(oldmins / 60)

		totseconds = newseconds + oldseconds
		totmins = newmins + oldmins
		tothours = newhours + oldhours
		
		while totmins >= 60 and tothours < 999{
			totmins -= 60
		}
		
		if totmins < 10{
			global.time = string(tothours) + ":0" + string(totmins)
		} else{
			global.time = string(tothours) + ":" + string(totmins)
		}
		
		if tothours >= 999 and totmins >= 59{
			global.time = "999:59"
		}
		
		ini_write_real("Save1", "playtime", global.oldtime + global.newtime)
		global.savetime = current_time
		
		//party
	
		if global.party_exists = true{
		
			ini_write_string("Save1", "Party Exists", global.party_exists)
	
			if global.party_member_1 = obj_partyplaceholder1{
				ini_write_real("Save1", "Party1", global.pn1)
			}
	
			if global.party_member_1 = obj_susie{
				ini_write_real("Save1", "Party1", global.p0)
			}
			if global.party_member_1 = obj_kris{
				ini_write_real("Save1", "Party1", global.p1)
			}
			if global.party_member_1 = obj_ralsei{
				ini_write_real("Save1", "Party1", global.p2)
			}
		
		
			if global.party_member_2 = obj_partyplaceholder1{
				ini_write_real("Save1", "Party2", global.pn1)
			}
		
		
			if global.party_member_2 = obj_susie{
				ini_write_real("Save1", "Party2", global.p0)
			}
			if global.party_member_2 = obj_kris{
				ini_write_real("Save1", "Party2", global.p1)
			}
			if global.party_member_2 = obj_ralsei{
				ini_write_real("Save1", "Party2", global.p2)
			}
	
		}
		ini_close()
		
		obj_savemenu.saved = true
		timer = 1
		audio_play_sound(snd_save, 1, false)
		
	}
	
	//return
	if (obj_savemenu.selected = 1 or (obj_savemenu.saved = true and timer <= 0)) and global.selectbuttonpressed{
		obj_player.can_move = true
		wait = false
		instance_destroy(obj_savemenu)
	}
	timer--
}

show_debug_message(totseconds)
show_debug_message(totmins)
show_debug_message(global.time)