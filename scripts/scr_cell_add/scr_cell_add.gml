function scr_cell_add(contact){
    
    cont = global.contacts
    
    index = array_length(cont)
    array_resize(cont, index)
    array_set(cont, index, contact)
    
    scr_update_lists()
    
}