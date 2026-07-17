function scr_txtb_dw(lines = langtxt.dia.test.default_, pos = "bottom", localvars = [], restore = true, keep_move = false){
    
    var box = instance_create_depth(0, 0, -9999, obj_txtb,
    {
        dia : lines,
        txtb_loc: pos,
        restore_move: restore,
        keep: keep_move,
        txt_type: "dark",
        txtb_spr: spr_dw_box,
        txtb_w: 296,
        txtb_h: 83,
        txtb_fps: 3,
        txtb_ypos: 36,
        txt_start_x: 110,
        txt_start_y: 51,
        locl_var : localvars
    })
    
}