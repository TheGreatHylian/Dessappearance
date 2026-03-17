function scr_json_to_var(json = global.json){
    
    if file_exists(json){
        file = file_text_open_read(json)
        text = ""
        while !file_text_eof(file){
            text += file_text_readln(file)
        }
        file_text_close(file)
        save = json_parse(text)
        
        return save
    } else{
        show_error("Error! Specified json \"" + json + "\" does not exist!", true)
    }
    
}