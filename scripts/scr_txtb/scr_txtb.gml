function scr_txtb(lines = langtxt.dia.test.default_, pos = "bottom", localvars = [], restore = true, keep_move = false){
    
    var box = instance_create_depth(0, 0, -9999, obj_txtb,
    {
        dia : lines,
        txtb_loc: pos,
        restore_move: restore,
        keep: keep_move,
        txt_type: "light",
        locl_var : localvars
    })
    
}