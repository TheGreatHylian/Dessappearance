function scr_equip_armor(index, target = global.stats.mainchara, pos = "bottom"){
    
    inv = global.inventory
    ar_old = target.ar
    ar_new = inv[index]
    
    inv[index] = ar_old
    target.ar = ar_new
    
    scr_update_lists()
    
    scr_txtb(ar_new.use, pos)
    
}