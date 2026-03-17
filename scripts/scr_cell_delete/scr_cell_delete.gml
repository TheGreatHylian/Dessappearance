function scr_cell_delete(index = array_length(global.contacts) - 1){
    
    array_delete(global.contacts, index, 1)
    
    scr_update_lists()
    
}