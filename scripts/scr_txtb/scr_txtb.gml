function scr_txtb(box, pos, lines){

var inst = instance_create_layer(x, y, "Dialogue", mObjDlg)
with(inst){
	dlg_box_preset = box
	dlg_pos_preset = pos
	text_lines = lines
	init_dialogue()
}

}