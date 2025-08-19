interacted = 0
old = false

//lines

//english
if global.lang = "en"{

txt1 = [
	"<<voice=snd_txtger>>I'm old!",
	"But...",
	"Are you?",
	"<<disablestartstar>><<breakspace=false>><<menu=gersonyes1,gersonno1>>Yes_SEP_No"
]

choi1 = [
	"Really?",
	"You don't look it."
]

choi2 = [
	"A spring chicken, eh?"
]

txtyes = [
	"<<voice=snd_txtger>>You're old!"
]

txtno = [
	"<<voice=snd_txtger>>You're young!"
]

}

//french
if global.lang = "fr"{

txt1 = [
	"<<voice=snd_txtger>>Je suis vieux!",
	"Mais...",
	"Es-tu?",
	"<<disablestartstar>><<breakspace=false>><<menu=gersonyes1,gersonno1>>Oui_SEP_Non"
]

choi1 = [
	"Vraiment?",
	"T'as pas l'air d'une personne jeune."
]

choi2 = [
	"Ah, jeune?"
]

txtyes = [
	"<<voice=snd_txtger>>T'es vieux!"
]

txtno = [
	"<<voice=snd_txtger>>T'es jeune!"
]

}

//french
if global.lang = "jp"{

txt1 = [
	"<<voice=snd_txtger>>もう年だ!!!!!!",
	"Mais...",
	"Es-tu?",
	"<<disablestartstar>><<breakspace=false>><<menu=gersonyes1,gersonno1>>Oui_SEP_Non"
]

choi1 = [
	"Vraiment?",
	"T'as pas l'air d'une personne jeune."
]

choi2 = [
	"Ah, jeune?"
]

txtyes = [
	"<<voice=snd_txtger>>T'es vieux!"
]

txtno = [
	"<<voice=snd_txtger>>T'es jeune!"
]

}

interactAct = function(){
	
	//yes func
	function gersonyes1(){
		add_dialogue(obj_interact.choi1)
		obj_interact.old = true
	}
	ds_map_add(global.menu_fn_map, "gersonyes1", gersonyes1)
	
	//no func
	function gersonno1(){
		add_dialogue(obj_interact.choi2)
	}
	ds_map_add(global.menu_fn_map, "gersonno1", gersonno1)
	
	var inst = instance_create_layer(x, y, "Dialogue", mObjDlg)
	with(inst){
		dlg_box_preset = 0
		dlg_pos_preset = 1
		//first talk dlg
		if obj_interact.interacted = 0{
			text_lines = obj_interact.txt1
		} else{
			//said yes
			if obj_interact.old = true{
				text_lines = obj_interact.txtyes
			} else{
				//said no
				text_lines = obj_interact.txtno
			}
		}
		init_dialogue()
	}
	
	//interacted counter
	obj_interact.interacted++
	
}