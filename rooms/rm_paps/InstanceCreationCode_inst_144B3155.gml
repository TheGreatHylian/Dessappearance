interactAct = function(){
	
	var inst = instance_create_layer(x, y, "Dialogue", mObjDlg)
	with(inst){
		dlg_box_preset = 0
		dlg_pos_preset = 1
		text_lines = [
			"There's some king of \"Deltarune Meme Complilation\" playing on the computer.",
			"You decide to watch it.",
			"<<face_w=-10&face_h=-5&face_x=-4&face=spr_susfacehappy&voice=snd_txtsus>>Like, uh, hey, maybe things took a <<color=ff0000>>weird route<<color=ffffff>> right now...",
			"<<disablestartstar>><<face=none&voice=snd_boom>><<image=spr_asgoresmirk, 115, 20, 200, 60>>.",
		]
		init_dialogue()
	}
}