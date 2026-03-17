function scr_item_add(item){
    
    inv = global.inventory
    
    if array_length(inv) >= 8{
        exit
    }
    
    index = array_length(inv)
    array_resize(inv, index)
    array_set(inv, index, item)
    
    scr_update_lists_test()
    
}