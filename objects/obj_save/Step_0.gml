if place_meeting(x, y, obj_interactlaserparent){
	audio_play_sound(snd_heal, 1, false)
	//scr_txtb(box, pos, lines)
	wait = true
}

if wait = true{
	instance_create_depth(x, y, -1000, obj_savemenu)
	obj_mainchara.can_move = false
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
		
		scr_save()
		
		obj_savemenu.saved = true
		timer = 1
		
	}
	
	//return
	if (obj_savemenu.selected = 1 or (obj_savemenu.saved = true and timer <= 0)) and global.selectbuttonpressed{
		obj_mainchara.can_move = true
		wait = false
		instance_destroy(obj_savemenu)
	}
	timer--
}