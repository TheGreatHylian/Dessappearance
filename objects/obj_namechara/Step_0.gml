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
	if global.rightbuttonpressed1 and column < 6 and string_lower(selected) != "z" and row != 8{
		column++
	} else if global.rightbuttonpressed1 and column = 6{
        row++
        column = 0
    } else if global.rightbuttonpressed1 and selected = "Z"{ //z-a
        row++
        column = 0
    } else if global.rightbuttonpressed1 and row = 8 and column < 2{
        column++
    } else if global.rightbuttonpressed1 and row = 8 and column = 2{
        column = 0
    }
    
	//left
	if global.leftbuttonpressed1 and column > 0 and selected != "a" and row != 8{
		column--
	} else if global.leftbuttonpressed1 and column = 0 and row != 0 and row != 8{
        row--
        column = 6
    } else if global.leftbuttonpressed1 and selected = "a"{ //a-z
        row--
        column = 4
    } else if global.leftbuttonpressed1 and row = 8 and column != 0{
        column--
    } else if global.leftbuttonpressed1 and row = 8 and column = 0{
        column = 2
    }
    
	//down
	if global.downbuttonpressed1 and row < 7 and string_lower(selected) != "t" and string_lower(selected) != "u"{
		row++
	} else if global.downbuttonpressed1 and row = 8 and column = 0{ //quit-a
        row = 0
        column = 0
    } else if global.downbuttonpressed1 and row = 8 and column = 1{ //backspace-c
        row = 0
        column = 2
    } else if global.downbuttonpressed1 and row = 8 and column = 2{ //done-f
        row = 0
        column = 5
    } else if global.downbuttonpressed1 and row = 7 and column < 2{ //v/w-quit
        row++
        column = 0
    } else if global.downbuttonpressed1 and row = 7 and column < 5{ //x/y/z-backspace
        row++
        column = 1
    } else if global.downbuttonpressed1 and (selected = "t" or selected = "u"){ //t/u-done
        row += 2
        column = 2
    } else if global.downbuttonpressed1 and (selected = "T" or selected = "U"){ //t/u-f/g
        row += 2
    }
	
	//up
	if global.upbuttonpressed1 and row > 0 and row != 8 and selected != "f" and selected != "g"{
		row--
	} else if global.upbuttonpressed1 and row = 8 and column = 0{ //quit-v
        row--
        column = 0
    } else if global.upbuttonpressed1 and row = 8 and column = 1{ //backspace-x
        row--
        column = 2
    } else if global.upbuttonpressed1 and row = 8 and column = 2{ //done-t
        row -= 2
        column = 5
    } else if global.upbuttonpressed1 and row = 0 and column < 2{ //a/b-quit
        row = 8
        column = 0
    } else if global.upbuttonpressed1 and row = 0 and column < 5{ //c/d/e-backspace
        row = 8
        column = 1
    } else if global.upbuttonpressed1 and row = 0 and column < 7{ //f/g-done
        row = 8
        column = 2
    } else if global.upbuttonpressed1 and (selected = "f" or selected = "g"){ //f/g-t/u
        row -= 2
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
		name_size += 0.011
	}
	
    if name_x > -37{
		name_x -= 0.2
	}
    
	if name_y < 80{
		name_y += 0.43
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
		name_size += 0.011
	}
    
    if name_x > -37{
		name_x -= 0.2
	}
	
	if name_y < 80{
		name_y += 0.43
	}
	
	//change name roation with delay
	if timer = 0{
		name_rot_off = scr_shakeval(rotshake)
		timer = rotshake_delay
	}
	timer--
		
}

//show_debug_message(string(row) + " " + string(column) + " " + string(selected) + " " + global.name)