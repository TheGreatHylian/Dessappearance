function scr_update_lists(load = false){
    
    if load = true and global.new_game = false{
        save = scr_json_to_var()
        global.inv = save[global.slot].mainchara.inv
        global.conts = save[global.slot].mainchara.conts
        scr_lists_id_convert()
        exit
    }
    
    global.inv = []
    
    for(var i = 0; i < array_length(global.inventory); i++){ 
        array_resize(global.inv, array_length(global.inv))
        array_set(global.inv, i, global.inventory[i].id)
    }
    
    global.conts = []
    
    for(var i = 0; i < array_length(global.contacts); i++){ 
        array_resize(global.conts, array_length(global.conts))
        array_set(global.conts, i, global.contacts[i].id)
    }
    
}