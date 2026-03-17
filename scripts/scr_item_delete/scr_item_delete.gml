function scr_item_delete(index = array_length(global.inventory) - 1){
    
    array_delete(global.inventory, index, 1)
    
    scr_update_lists()
    
}