//stage 1 - select name

if stage = 1{
	
	//change letter offset with delay
	if timer = 0{
		for(var i = 0; i < array_length(xoff); i++){
			xoff[i] = scr_shakeval(shake)
			yoff[i] = scr_shakeval(shake)
		}
		timer = timerval
	}
	timer--
	
	//highlight letters
	
	//right
	if global.rightbuttonpressed1 and column < 6{
		column++
	}
	//left
	if global.leftbuttonpressed1 and column > 0{
		column--
	}
	//down
	if global.downbuttonpressed1 and row < 8{
		row++
	}
	
	if global.downbuttonpressed1 and row < 7{
		selected = ""
	}
	
	//up
	if global.upbuttonpressed1 and row > 0{
		row--
	}
	//stop impossible positions
	if (row = 3 or row = 7) and (column > 4){
		column = 4
	}
	
	if row = 8 and column > 2{
		column = 2
	}
	
	//select letter
	if global.selectbuttonpressed and string_length(global.name) < charmax and row != 8{
		global.name += selected
	}
	
}

//stage 2 - confirm name -----------------------------------------

if stage = 2{
	
	//grow name
	if name_size < 3{
		name_size += 0.005
	}
	
	if name_y < 80{
		name_y += 0.2
	}
	
	//change name roation with delay
	if timer = 0{
		name_rot_off = scr_shakeval(rotshake)
		timer = rotshake_delay
	}
	timer--
	
	//select options
	
	//right
	if global.rightbuttonpressed1 and column < 1{
		column++
	}
	//left
	if global.leftbuttonpressed1 and column > 0{
		column--
	}
	
}

if stage = 3{ //starting game stage -----------------------------------------
		
		//grow name
	if name_size < 3{
		name_size += 0.005
	}
	
	if name_y < 80{
		name_y += 0.2
	}
	
	//change name roation with delay
	if timer = 0{
		name_rot_off = scr_shakeval(rotshake)
		timer = rotshake_delay
	}
	timer--
		
}

//show_debug_message(string(row) + " " + string(column) + " " + string(selected) + " " + global.name)