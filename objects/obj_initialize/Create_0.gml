global.json = "dess.save"
global.slot = 1
global.new_game = true

global.start_room = rm_paps
global.start_x = 730
global.start_y = 530
global.facing = "down"

global.name = ""

global.party = []
global.party_exists = false
global.entered_new_room = false

global.has_cell = true

global.lang = "en"
global.fontdefault = fnt_main
global.fontsans = fnt_main_sans
if global.lang = "jp"{
	global.fontdefault = fnt_main_jp
}

//time vars
global.newtime = 0
global.savetime = 0
global.menutime = 0
global.countmenutime = true

//control defaults
global.selectbutton = ord("Z")
global.cancelbutton = ord("X")
global.sprintbutton = ord("X")
global.menubutton = ord("C")
global.upbutton = ord("W")
global.downbutton = ord("S")
global.leftbutton = ord("A")
global.rightbutton = ord("D")

//control defaults
selectkey = "Z"
cancelkey = "X"
sprintkey = "X"
menukey = "C"
upkey = "W"
downkey = "S"
leftkey = "A"
rightkey = "D"

//update controls
scr_updatecontrols()