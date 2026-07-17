function scr_txtb_trans(lines = langtxt.dia.test.default_, pos = "bottom", width = 289, height = 76, type = "light", y_off, localvars = [], restore = true, keep_move = false){
    
    var box = instance_create_depth(0, 0, -9999, obj_txtb,
    {
        dia : lines,
        txtb_loc: pos,
        restore_move: restore,
        keep: keep_move,
        txt_type: type,
        txtb_w: width,
        txtb_h: height,
        txtb_ypos: y_off,
        txtb_spr: spr_trans_box,
        locl_var : localvars
    })
    
}