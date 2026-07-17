if timer = 0{
    dia_int = dia
}
if timer != -1{
    timer--
}

if get_dia(string_concat(dia, interacted)) != get_txt("sys.fallback"){
    dia_int = string_concat(dia, interacted)
}

txt = get_dia(dia_int)

if obj_mainchara.y > center.y{
    txtb_loc = "top"
} else{
    txtb_loc = "bottom"
}

if place_meeting(x, y, obj_interactlaserparent) and !instance_exists(obj_menu){
    if dia != get_txt("sys.default_"){
        scr_txtb(txt, txtb_loc)
    } else{
        scr_txtb(get_txt("sys.default_"), txtb_loc)
    }
    
    interacted++
}