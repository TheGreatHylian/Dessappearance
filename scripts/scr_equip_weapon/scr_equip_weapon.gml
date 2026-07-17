function scr_equip_weapon(index, target = global.stats.mainchara, pos = "bottom"){
    
    inv = global.inventory
    wp_old = target.wp
    wp_new = inv[index]
    
    inv[index] = wp_old
    target.wp = wp_new
    
    scr_update_lists()
    
    scr_txtb(wp_new.use, pos)
    
}