function scr_equipable_id_convert(equipable){
    
    item = global.item.weapon.hair_brush
    
    if struct_exists(global.item.weapon, equipable){
        item = struct_get(global.item.weapon, equipable)
    } else if struct_exists(global.item.armor, equipable){
        item = struct_get(global.item.armor, equipable)
    }
    
    return item
    
}
