function col_checker(val){
    
    val = string_lower(val)
    
    switch val{
        case "w": //white
            col = c_white
            break
        case "r": //red
            col = c_red
            break
        case "o": //orange
            col = c_orange
            break
        case "y": //yellow
            col = c_yellow
            break
        case "g": //green
            col = c_green
            break
        case "b": //blue
            col = c_blue
            break
        case "p": //purple
            col = c_purple
            break
        case "c": //cyan (aqua)
            col = c_aqua
            break
        case "l": //lime
            col = c_lime
            break
        case "bk": //black
            col = c_black
            break
        case "gy": //gray
            col = c_gray
            break
        case "lg": //light gray
            col = c_ltgray
            break
        case "dg": //dark gray
            col = c_dkgray
            break
        case "m": //maroon
            col = c_maroon
            break
        case "n": //navy
            col = c_navy
            break
        case "oe": //olive
            col = c_olive
            break
        case "s": //silver
            col = c_silver
            break
        case "t": //teal
            col = c_teal
            break
        case "f": //fuchsia
            col = c_fuchsia
            break
        case "pk": //pink
            col = c_pink
            break
        case "ae": //aquamarune
            col = c_aquamarune
            break
        case "lpk": //light pink
            col = c_ltpink
            break
        case "catty": //catty
            col = c_catty
            break
        case "db": //dark blue
            col = c_dkblue
            break
        case "yo": //yellow-orange
            col = c_yellow_orange
            break
        case "lf": //light fuchsia
            col = c_ltfuchsia
            break
        case "dp": //dark purple
            col = c_dkpurple
            break
        case "pe": //periwinkle
            col = c_periwinkle
            break
        case "lr": //light red
            col = c_ltred
            break
        case "lb": //light blue
            col = c_ltblue
            break
        case "ly": //light yellow
            col = c_ltyellow
            break
        case "lgr": //light green
            col = c_ltgreen
            break
        case "aq": //aqua color
            col = c_aqcolor
            break
        case "mg": //menu gray
            col = c_menu_gray
            break
        case "lfd": //light fuchsia dmg
            col = c_ltfuchsia_dmg
            break
        case "lyd": //light yellow dmg
            col = c_ltyellow_dmg
            break
        case "papyrus": //papyrus color
            col = c_papyrus
            break
        default:
            col = c_white
    }
    
    return col
    
}