interactAct = function(){
	
	var inst = instance_create_layer(x, y, "Dialogue", mObjDlg)
	with(inst){
		dlg_box_preset = 1
		dlg_pos_preset = 1
		text_lines = [
			"Hi!!!",
			"This is line <<effect=bounce&effect_speed=0.25>>twoooooo<<effect=none>>!",
			"grug",
			"<<sound=snd_txtsus>><<face_w=-10>><<face_h=-5>><<face=spr_susfacehappy>>Like, uh, hey, maybe things took a <<highlight=dw_red>><<h_shadow=dw_red>>weird route<<highlight=none>><<h_shadow=none>> right now...",
			"<<face=none>><<image=spr_asgoresmirk, 120, 20, 200, 50>>"
		]
		init_dialogue()
	}	
}