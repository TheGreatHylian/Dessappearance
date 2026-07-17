function get_dia(path_string){
    
    text = struct_get(global.langtxt.dia.room, string_delete(string(room), 0, 9)) 
    
    path_string = string_split(path_string, ".")
    for(var i = 0; i < array_length(path_string); i++){
        var names = variable_struct_get_names(text)
        if struct_exists(text, path_string[i]){
            text = struct_get(text, path_string[i])
        } else{
            text = global.langtxt.sys.fallback
            break
        }
    }
    
    return text
    
}