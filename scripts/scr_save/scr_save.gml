function scr_save(slot = global.slot, snd = false){
    
    //time management
    
    if file_exists(global.json) and global.new_game = false{
        global.oldtime = global.slots[slot].game.time
    } else {
        global.oldtime = 0
    }
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
    
    time_to_save = global.oldtime + global.newtime
    global.savetime = current_time
    
    //party
    
    party = []
    party_size = array_length(global.party)
    array_resize(party, party_size)
    for(var i = 0; i < party_size; i++){
        array_set(party, i, object_get_name(global.party[i]))
    }
    
    //save
    
    save = {
        
        mainchara : {
            
            name : global.name,
            mainchara_x : obj_mainchara.x,
            mainchara_y : obj_mainchara.y,
            facing : obj_mainchara.facing_direction,
            
            inv : global.inv,
            
            conts : global.conts,
            cell : global.has_cell,
            
            at : global.stats.mainchara.at,
            df : global.stats.mainchara.df,
            mg : global.stats.mainchara.mg,
            wp : global.stats.mainchara.wp.id,
            ar : global.stats.mainchara.ar.id,
            money : global.stats.mainchara.money,
            hp : global.stats.mainchara.hp,
            hp_max : global.stats.mainchara.hp_max,
            lv : global.stats.mainchara.lv,
            xp : global.stats.mainchara.xp
            
        },
            
        game : {
            slot,
            rm : room_get_name(room),
            time : time_to_save
        },
        
        party : {
            
            exists : global.party_exists,
            party_arr : party
            
        }
        
    }
    
    global.slots[0] = global.num_slots
    global.slots[slot] = save
    slots_dummy = global.slots
    
    global.slots = json_stringify(global.slots, true)
    
    file = file_text_open_write(global.json)
    
    file_text_write_string(file, global.slots)
    file_text_close(file)
    
    global.slots = slots_dummy
    
    global.new_game = false
    
    if snd = true{
        scr_snd(snd_save)
    }
    
}