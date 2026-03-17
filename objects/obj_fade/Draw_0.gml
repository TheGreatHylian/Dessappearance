draw_sprite_ext(sprite_index, -1, 0, 0, 300, 300, 0, c_white, image_alpha)

if image_alpha = 1{
    room_goto(target_room)
    obj_mainchara.x = target_x
    obj_mainchara.y = target_y
    
    //party
    if global.party_exists = true{
    
    	party_warp = true
    	global.entered_new_room = true
    	global.new_room_facing = obj_mainchara.sprite_index
    	obj_mainchara.mainchara_x = -1
    	obj_mainchara.mainchara_y = -1
    	obj_mainchara.past_facing = -1
    	obj_mainchara.follow_points = 100
    	
    	for(obj_mainchara.follow_pos = obj_mainchara.follow_points -1; obj_mainchara.follow_pos >= 0; obj_mainchara.follow_pos--){
    	
    		obj_mainchara.mainchara_x[obj_mainchara.follow_pos] = target_x
    		obj_mainchara.mainchara_y[obj_mainchara.follow_pos] = target_y
    	
    	}
    	
    	for(obj_mainchara.follow_pos = obj_mainchara.follow_points -1; obj_mainchara.follow_pos >= 0; obj_mainchara.follow_pos -= 48){
    	
    		obj_mainchara.past_facing[obj_mainchara.follow_pos] = obj_mainchara.sprite_index
    	
    	}
    
    }
    
    //facing
    
    if(facing = "right"){
    	obj_mainchara.sprite_index = spr_ynoellewr
    }
    
    if(facing = "left"){
    	obj_mainchara.sprite_index = spr_ynoellewl
    }
    
    if(facing = "down"){
    	obj_mainchara.sprite_index = spr_ynoellewd
    }
    
    if(facing = "up"){
    	obj_mainchara.sprite_index = spr_ynoellewu
    }
}