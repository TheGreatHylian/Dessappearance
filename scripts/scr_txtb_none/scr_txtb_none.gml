function scr_txtb_none(lines = langtxt.dia.test.default_, x_off = 0, y_off = 0, type = "light", big_linespace = false, is_shop = false, localvars = [], control = true, restore = true, keep_move = false){
    
    var box = instance_create_depth(0, 0, -9999, obj_txtb,
    {
        dia : lines,
        restore_move: restore,
        keep: keep_move,
        txt_type: type,
        txt_start_x: x_off,
        txt_start_y: y_off,
        txtb_spr: spr_none,
        big_linebreak: big_linespace,
        shop : is_shop,
        locl_var : localvars,
        can_control : control
    })
    
}