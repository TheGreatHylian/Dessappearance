//draw black rect bg
draw_rectangle_color(0, 0, 400, 400, c_black, c_black, c_black, c_black, false)

//set text draw values
draw_set_font(global.fontsans)

//draw top text
draw_set_halign(fa_left)
draw_text(center.x - 70, center.y - 100, toptext)
draw_set_halign(fa_center)

//draw name

draw_text_transformed(center.x, center.y - 80 + name_y, global.name, name_size, name_size, 0 + name_rot_off)

if stage = 1{ // typing the name stage
	
	toptext = "Name the fallen human."
	name_y = 0
	name_rot_off = 0
	name_size = 1
	
	//draw letters
	
	//uppercase
	
	//row 0
	for(var i = 0; i < 7; i++){
		
		//set color + select letter
		if row = 0 and column = i - row * 6{
			draw_set_color(c_yellow)
			selected = alphabetu[i]
		}
		
		//draw text
		draw_text((center.x - 120) + (i * 40) + xoff[i], (center.y - 60) + yoff[i], alphabetu[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//row 1
	for(var i = 7; i < 14; i++){
		
		//set color + select letter
		if row = 1 and column = i - row * 7{
			draw_set_color(c_yellow)
			selected = alphabetu[i]
		}
		
		//draw text
		draw_text((center.x - 400) + (i * 40) + xoff[i], (center.y - 46) + yoff[i], alphabetu[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//row 2
	for(var i = 14; i < 21; i++){
		
		//set color + select letter
		if row = 2 and column = i - row * 7{
			draw_set_color(c_yellow)
			selected = alphabetu[i]
		}
		
		//draw text
		draw_text((center.x - 680) + (i * 40) + xoff[i], (center.y - 32) + yoff[i], alphabetu[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//row 3
	for(var i = 21; i < 26; i++){
		
		//set color + select letter
		if row = 3 and column = i - row * 7{
			draw_set_color(c_yellow)
			selected = alphabetu[i]
		}
		
		//draw text
		draw_text((center.x - 960) + (i * 40) + xoff[i], (center.y - 18) + yoff[i], alphabetu[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//lowercase
	
	//row 4
	for(var i = 0; i < 7; i++){
		
		//set color + select letter
		if row = 4 and column = (i + array_length(alphabetl) + 2) - row * 7{
			draw_set_color(c_yellow)
			selected = alphabetl[i]
		}
		
		//draw text
		draw_text((center.x - 120) + (i * 40) + xoff[i], (center.y - 60 - lowoff) + yoff[i], alphabetl[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//row 5
	for(var i = 7; i < 14; i++){
		
		//set color + select letter
		if row = 5 and column = (i + array_length(alphabetl) + 2) - row * 7{
			draw_set_color(c_yellow)
			selected = alphabetl[i]
		}
		
		//draw text
		draw_text((center.x - 400) + (i * 40) + xoff[i], (center.y - 46 - lowoff) + yoff[i], alphabetl[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//row 6
	for(var i = 14; i < 21; i++){
		
		//set color + select letter
		if row = 6 and column = (i + array_length(alphabetl) + 2) - row * 7{
			draw_set_color(c_yellow)
			selected = alphabetl[i]
		}
		
		//draw text
		draw_text((center.x - 680) + (i * 40) + xoff[i], (center.y - 32 - lowoff) + yoff[i], alphabetl[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//row 7
	for(var i = 21; i < 26; i++){
		
		//set color + select letter
		if row = 7 and column = (i + array_length(alphabetl) + 2) - row * 7{
			draw_set_color(c_yellow)
			selected = alphabetl[i]
		}
		
		//draw text
		draw_text((center.x - 960) + (i * 40) + xoff[i], (center.y - 18 - lowoff) + yoff[i], alphabetl[i])
		
		//reset color
		draw_set_color(c_white)
		
	}
	
	//options
	
	//quit
	
	//set color and return to title
	if row = 8 and column = 0{
		draw_set_color(c_yellow)
		
		if global.selectbuttonpressed{
			instance_create_depth(160, 32, 100, obj_title)
			instance_destroy()
		}
	}
	//draw text
	draw_text((center.x - 108), (center.y + 70), "Quit")
	//reset color
	draw_set_color(c_white)
	
	//backspace
	
	//set color and delete
	if row = 8 and column = 1{
		draw_set_color(c_yellow)
		
		if global.selectbuttonpressed and string_length(global.name) > 0{
			global.name = string_delete(global.name, string_length(global.name), 1)
		}
	}
	//draw text
	draw_text((center.x - 16), (center.y + 70), "Backspace")
	//reset color
	draw_set_color(c_white)
	
	//done
	
	//set color and advance stage
	if row = 8 and column = 2{
		draw_set_color(c_yellow)
		
		if global.selectbuttonpressed{
			column = 0
			stage++
		}
	}
	//draw text
	draw_text((center.x + 90), (center.y + 70), "Done")
	//reset color
	draw_set_color(c_white)
	
	//delete with x
	
	if global.cancelbuttonpressed and string_length(global.name) > 0{
		global.name = string_delete(global.name, string_length(global.name), 1)
	}
	
	//gaster
	if string_lower(global.name) = "gaster"{
		game_end()
		//game_restart()
	}
	
} else if stage = 2{ //verifying the name stage -----------------------------------------
	
	//default text
	toptext = "Is this name correct?"
	nameforbidden = false
	
	//special names----------------------------
	
	//aaaaaa
	if string_lower(global.name) = "aaaaaa"{
		toptext = "Not very creative...?"
	}
	
	//aaron
	if string_lower(global.name) = "aaron"{
		toptext = "Is this name correct? ; )"
	}
	
	//catty
	if string_lower(global.name) = "catty"{
		toptext = "Bratty! Bratty!\nThat's MY name!"
	}
	
	//bratty
	if string_lower(global.name) = "bratty"{
		toptext = "Like, OK I guess."
	}
	
	//burger
	if string_lower(global.name) = "bpants"{
		toptext = "You are really scrapping the\nbottom of the barrel."
	}
	
	//gerson
	if string_lower(global.name) = "gerson"{
		toptext = "Wah ha ha! Why not?"
	}
	
	//chara
	if string_lower(global.name) = "chara"{
		toptext = "The true name."
	}
	
	//jerry
	if string_lower(global.name) = "jerry"{
		toptext = "Jerry."
	}
	
	//mettaton 1
	if string_lower(global.name) = "mett"{
		toptext = "OOOOH!!! ARE YOU\nPROMOTING MY BAND?"
	}
	
	//mettaton 2
	if string_lower(global.name) = "metta"{
		toptext = "OOOOH!!! ARE YOU\nPROMOTING MY BAND?"
	}
	
	//mettaton 3
	if string_lower(global.name) = "mtt"{
		toptext = "OOOOH!!! ARE YOU\nPROMOTING MY BAND?"
	}
	
	//napstablook 1
	if string_lower(global.name) = "napsta"{
		toptext = "...........\n(They're powerless to\nstop you.)"
	}
	
	//napstablook 2
	if string_lower(global.name) = "blooky"{
		toptext = "...........\n(They're powerless to\nstop you.)"
	}
	
	//papyrus
	if string_lower(global.name) = "papyru"{
		toptext = "I'LL ALLOW IT!!!!"
	}
	
	//shyren
	if string_lower(global.name) = "shyren"{
		toptext = "...?"
	}
	
	//temmie
	if string_lower(global.name) = "temmie"{
		toptext = "hOI!"
	}
	
	//woshua
	if string_lower(global.name) = "woshua"{
		toptext = "Clean name."
	}
	
	//alphy
	if string_lower(global.name) = "alphy"{
		toptext = "Uh... OK?"
	}
	
	//frisk
	if string_lower(global.name) = "frisk"{
		toptext = "WARNING: This name will\nmake your like hell.\nProceed anyway?"
	}
	
	//mercy
	if string_lower(global.name) = "mercy"{
		toptext = "That's a little on-\nthe nose, isn't it...?"
	}
	
	//murder
	if string_lower(global.name) = "murder"{
		toptext = "That's a little on-\nthe nose, isn't it...?"
	}
	
	//forbidden names
	
	//none
	if string_length(global.name) = 0{
		toptext = "You must choose a name."
		nameforbidden = true
	}
	
	//undyne
	if string_lower(global.name) = "undyne"{
		toptext = "Get your OWN name!"
		nameforbidden = true
	}
	
	//toriel
	if string_lower(global.name) = "toriel"{
		toptext = "I think you should\nthink of your own\nname, my child."
		nameforbidden = true
	}
	
	//sans
	if string_lower(global.name) = "sans"{
		toptext = "nope."
		nameforbidden = true
	}
	
	//flowey
	if string_lower(global.name) = "flowey"{
		toptext = "I already CHOSE\nthat name."
		nameforbidden = true
	}
	
	//asriel
	if string_lower(global.name) = "asriel"{
		toptext = "..."
		nameforbidden = true
	}
	
	//asgore
	if string_lower(global.name) = "asgore"{
		toptext = "You cannot."
		nameforbidden = true
	}
	
	//alphys
	if string_lower(global.name) = "alphys"{
		toptext = "D-don't do that."
		nameforbidden = true
	}
	
	//-----------------------------------------
	
	//options
	
	if column > 1{
		column = 0
	}
	
	if !nameforbidden{
		
		//no
		
		if column = 0{
			draw_set_color(c_yellow)
			if global.selectbuttonpressed{
				stage--
			}
		}
		
		draw_text((center.x - 108), (center.y + 70), "No")
		
		draw_set_color(c_white)
		
		//yes
		
		if column = 1{
			draw_set_color(c_yellow)
			if global.selectbuttonpressed{
				instance_create_depth(0, 0, -1000, obj_whitefade)
				audio_stop_all()
				audio_play_sound(snd_cymbal, 1, false)
				stage++
			}
		}
		
		draw_text((center.x + 90), (center.y + 70), "Yes")
		
		draw_set_color(c_white)
		
	}
	
	if nameforbidden{
		
		//go back
		
		column = 0
		if column = 0{
			draw_set_color(c_yellow)
			if global.selectbuttonpressed{
				column = 1
				stage = 1
			}
		}
		
		draw_text((center.x - 108), (center.y + 70), "Go back")
		
		draw_set_colour(c_white)
		
	}
	
}

if stage = 3{ //starting game stage ---------------------------------------
	
	toptext = ""
	
	if !instance_exists(obj_whitefade){
		
		room_goto(global.start_room)
		mControl.enableControl("player");
        mControl.disableControl("title");
		var instantiated = instance_create_layer(global.start_x, global.start_y, "Player", obj_player)
		global.new_game = false
		global.menutime = current_time
		
	}
	
}