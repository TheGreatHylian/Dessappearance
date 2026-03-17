function scr_lists_id_convert(){
    
    invie = global.inventory
    inv = global.inv
    
    array_resize(invie, array_length(inv))
    
    for(var i = 0; i < array_length(inv); i++){
        
        item_id = inv[i]
        
        if struct_exists(global.item.food, item_id){
            invie[i] = struct_get(global.item.food, item_id)
        } else if struct_exists(global.item.weapon, item_id){
            invie[i] = struct_get(global.item.weapon, item_id)
        } else if struct_exists(global.item.armor, item_id){
            invie[i] = struct_get(global.item.armor, item_id)
        } else if struct_exists(global.item.key, item_id){
            invie[i] = struct_get(global.item.key, item_id)
        }
        
    }
    
    contacts = global.contacts
    conts = global.conts
    
    array_resize(contacts, array_length(conts))
    
    for(var i = 0; i < array_length(conts); i++){
        
        caller_id = conts[i]
        
        contacts[i] = struct_get(global.cell, caller_id)
        
    }
    
}