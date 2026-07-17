function string_clean(str, vars = [], hash = true){
    
    num_chars = string_length(str)
    cmd_iden = "&"
    negator = "-"
    glbl_var_iden = "g"
    locl_var_iden = "l"
    locl_var = vars
    locl_var_index = 0
    
    for(var c = 0; c < num_chars; c++){
        
        if string_char_at(str, c+1) = cmd_iden and string_char_at(str, c) != negator{
            
            var cmd = ""
                
            //clean the string of cmds
            for(var i = c; i < num_chars; i++){
                cmd += string_char_at(str, i + 1)
                if string_char_at(cmd, string_length(cmd)) = cmd_iden and i > c{
                    var dia_clean_after = string_copy(str, i+2, string_length(str)-i+1)
                    str = string_copy(str, 1, c)
                    str += dia_clean_after
                    break
                }
            }
            
            //separate each cmd for easy access
            cmd = string_copy(cmd, 2, string_length(cmd)-2)
            var indie = string_split(cmd, ",")
            
            //actual cmd code
            for(var i = 0; i < array_length(indie); i++){
                
                //global vars
                if string_starts_with(indie[i], glbl_var_iden){
                    
                    indie[i] = string_copy(indie[i], 3, string_length(indie[i]))
                    glbl_var = string(variable_global_get(indie[i]))
                    
                    str = string_insert(glbl_var, str, c+1)
                    
                } else
                
                //local vars
                if string_starts_with(indie[i], locl_var_iden){
                    
                    indie[i] = string_copy(indie[i], 1, string_length(indie[i]))
                    
                    array_resize(locl_var, array_length(locl_var)+1)
                    str = string_insert(locl_var[locl_var_index], str, c+1)
                    locl_var_index++
                    
                }
                
            }
            
        }
        
    }
    
    if hash{
        str = string_hash_to_newline(str)
    }
        
    return str
    
}