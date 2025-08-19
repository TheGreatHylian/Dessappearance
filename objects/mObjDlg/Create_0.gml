/// CREATE EVENT
if !variable_global_exists("run_map") global.run_map = ds_map_create();
if !variable_global_exists("menu_fn_map") global.menu_fn_map = ds_map_create();

text_lines = [
    "I'm the original    <<highlight=dw_yellow&hasshadow=true&h_shadow=dw_yellow>>Starwalker",
];

#region Help Code!
/*
————————————————————————————————————————————————————————————————————————————————————————————
 __   _______      ___  ___   ___  _      _                      ___         _             
 \ \ / /_  ( )___ |   \| _ \ |   \(_)__ _| |___  __ _ _  _ ___  / __|_  _ __| |_ ___ _ __  
  \ V / / /|/(_-< | |) |   / | |) | / _` | / _ \/ _` | || / -_) \__ \ || (_-<  _/ -_) '  \ 
   |_| /___| /__/ |___/|_|_\ |___/|_\__,_|_\___/\__, |\_,_\___| |___/\_, /__/\__\___|_|_|_|
                                                |___/                |__/                  
————————————————————————————————————————————————————————————————————————————————————————————

If you have any doubts, don't be afraid to ask for help!
I'm @yad_zero in Noelle's Discord server!

===========================
 Dialogue Inline Commands
===========================

The text from text_lines get parsed into a visual dialogue box! with many functions
that i named as "commands" or well, inline commands, so you can have more control
over your dialogue rather than just plain text!

it works this way:
text_lines = [
	"Dialogue 1!",
	"Dialogue 2!",
	"Dialogue 3!"
]

you can have as many as you want!

──────────────────────────
 FLAGS & CONTROL TOKENS
──────────────────────────

<<breakspace=true/false>>
    Goes to the next line!
	Example: "Hello!, I'm<<breakspace>>Sans."
	"* Hello, I'm"
	"* Sans.     "
	if set to false (<<breakspace=false>>) then the * is not rendered!
	"* Hello, I'm"
	"  Sans.     "
	it's set to true by default

<<autoskip>>
    When the current dialogue ends, it goes right to the next without the need of
	pressing the continue key!, works for "interrupting scenes", example:
	"Hey Susie why are you l-<<autoskip>>",
	"SHUR UP ALREADY!!!"

<<unskippable>>
    You cannot skip the text if it has this command! example:
	"<<unskippable>> According to all known laws of aviation, there is no way a bee should be able to fly. Its wings are too small to get its fat little body off the ground. The bee, of course, flies anyway because bees don't care what humans think is impossible."
	this would force you to read to the bee movie's script starting part
	and you wouldn't be able to press skip! (hence the name)
	
<<disablestartstar>>
    Removes the * at the start of the dialogue, it's more useful for menus,
	explanation later on

──────────────────────────
 TEXT EFFECTS
──────────────────────────

—————————————————[ ¡ ¡ ¡ REMEMBER ! ! ! ]————————————————————————
Every token is read until a counterpart, disablement or next line is met!
Example: "Wow! <<effect=something>>Hi, i'm a line of text with an effect!<<effect=none>> And no more."
You don't have to apply per letter commands!
Most of them are read until its disabled, or if the current line has ended
—————————————————[ ¡ ¡ ¡ ¡ ¡  ! ! ! ! ! ]————————————————————————

<<effect=...>>
    Sets an effect per-letter! 
	Supported:
    - "none"     → Disables effects
    - "bounce"   → Bounce   .   .   .   Do i need to say something else?
    - "orbit"    → Move in circles wooo
    - "fadein"   → Letters fade in like a ghost
	- "explode"   → Letters come from high in the screen... i dont know really

<<effect_speed=...>>
    Speed multiplier for effects!
	In Fade-In this is frames so for the fade to work it must be about 30 or any number you like
	just saying that if too low the effect doesn't really look like its fading in

<<effect_radius=...>>
    Scale of motion! used by Orbit, Bounce, and Explode

<<shake=...>>
    Shake types!
    - "none"
    - "letters" (each letter shakes individually!)
    - "whole"   (letters shake as a whole! (less chaotic than letters shake type))

<<intensity=...>>
    shake intensity! i know it should be called shake_intensity but yeah

<<offset=...>>
    Shake offset, its like radius in effects!

──────────────────────────
 TIMING
──────────────────────────


.........................................................................................
<<char_speed=...>>
    How fast are characters typen!
		
		 _Deprecated_
	-----Tip if you want to make a little pause before another text, add a 
	-----really high speed before a space: "Text...<<char_speed=50>> <<char_speed=2>>Now continue!"
	
<<revealstart>> || <<revealend>>
	These declare an instant reveal section! Where any characters are written instantly until its end
	If just set an reveal start without end, it will continue until the end of the line, if not
	then it will only last for the characters inside both of the tokens!
	Tip if you want to have pauses, instead of just making <<start...>><<..end>> every time, just add a single
	one and between them add timers! <<revealstart>>Are <<timer=35>>you <<timer=35>>kidding?<<revealend>>
	Btw these work with sound, it plays a single sound when starting the reveal, if theres a timer it will play another sound
	after the timer so if you want to change some stuff use sound tokens before starting and before timers!

<<timer=...>>
	Adds a timer for mid sentence pause!																			*		To anyone reading this i wanna say this feature was so f*[/#nq hard to implement, why? because of dumbass me.
	-- Time is set in frames, by default the dr/ut fangame project fps should be 30											not dealing with parsing issues before, you could run <<effect=orbit>><<effect_speed=10>><<color=something>><<shadow_color=anothersomething>>
	-- but if you're making anything else and have set the frame rate to something else,									and it would have worked, but it would all be seen as a dumb single object, so say per case reparsing (what changeSpr and add_dialogue do)
	-- then use that value, but each of your fps (frames per seconds, hence the name)										this lines would flippin die, and the game would be stuck on a forever loop. but now SANDWICH-ING IS ALLOWED!! YAY HORRAY.
	-- equals to, well, 1 second, in the 30 fps case, 30 fps = 1 second														What is "sandwich-ing"? Well thats how im naming putting the commands altogether, because i solved this shi, so i name it sandwich-ing here,
	-- if your game were at 60 fps, 1 second would 60 frames and so on														i swear im going insane, i've spent 5 hours just adding this feature so people wouldn't have to use the deprecated char speed method.
	e.g. "Heh thats funny<<timer=60>>But didn't i forget something?															but now it works!! after several hours of having <<timer=30>><<face=spr_none>> crash the game in a loop or something, it now is instead solved
								  |_ That's 2 seconds in a 30 fps game!														and now you can run that sandwich-ed command line without having any concerns!!
																															THIS IS MY TEST LINE I USED FOR THIS HOURS: "Test line!<<face=kai_dlg>> <<timer=60>> <<face=spr_none>>Crazy right?"
																															that way it worked, having the spaces in between ooo wow how novel, but there where in the rendering of the dialogue box not wanted spaces
──────────────────────────																									due to this, it would be rendered something like "Test line!  Crazy right?", theres an unwanted space there!!!
 STYLE																														So what would be the first thing that comes to mind to solve this??? "remove the spaces" ofc.
──────────────────────────																									But THEN the game instead of displaying a "Test line!Crazy right?"...
[ WARNING: Anything color related if it doesn't have an preset or argument handler      ]																	IT F'IN CRASHED!!!
[ It must be pased as a hex color! #FFFFFF, and that, you can search "Hex Color Picker" ]									And you may think, oh but if it crashes just read what the white box says the error was right?
[ on Google for a color picker that gives you its hex below it! :3                      ]									THERE WAS NO FREAKIN ERROR BOX		BECAUSE I DEAL WITH STUPID ISSUES RATHER THAN YOUR NORMAL EVERYDAY ERRORS!!!!! Im gonna cry
																															If you wonder why there was no error box it's because there was no error on how code was written, just how it was handled
<<color=#RRGGBB>>																											What happened to me was a Forever loop!! that hopefully should be fixed.
    Sets the color of the text, Now also accepts Built-In Colors! (c_white, c_yellow, etc)									But yeah its when for example, you have a function A, that function inside of it calls for function B, and inside function B
																															you call function A again, making it a loop that stays on forever, hence the name, and consuming resources really fast,
<<highlight=...>>																											and making the game crash/freeze rather than just throw an error box
    Makes a text interpolation like a gradient! for reference																So yeah that happened . . .
	its when         Starwalker says his name and its yellow with a																															
	white and yellow gradient! (dw_yellow it's just like it!)																Stupid Code.
	When highlight is anything else but none (disabled) <<color>> won't be applied																									- Yadira Rei Zero Wattson.
	
    Formats:
    - highlight=#FFFFFF,#FF0000
    - highlight=dw_yellow / dw_red / dw_navy / dw_green / dw_cyan
    - highlight=none → disables highlight

<<h_shadow=...>>
    Same format as highlight! its used if you want to use a highlighted shadow in it!
	If this is set, <<shadow_color>> won't be applied

<<hasshadow=true/false>>
    Whether each letter renders a shadow

<<shadow_color=#RRGGBB>>
    Color of the text shadow!

<<font=...>>
	changes the font mid line

<<font_size=...>>
    Adjusts size multiplier of the text (relative to base)!

<<xoff=...>>, <<yoff=...>>
    Offset on a character!
	Example: "Hello i'm <<yoff=-20>>Something!<<yoff=0>> right?"
	"          Something       "
	"Hello i'm           right?"
	works same way with xoff!

──────────────────────────
 PORTRAITS (Character Icons¿?)
──────────────────────────s

<<face=sprite_name>>
    Changes current sprite! to hide use spr_none!

<<face_w=...>>, <<face_h=...>>
    Adjusts the width or height of the portrait (relative to base)
	(Works by adding so if you want to make it smaller you need to put negative values, base width = 58)

<<face_x=...>>, <<face_y=...>>
    Offsets portrait position horizontally or vertically! same as xoff and yoff!

──────────────────────────
 IMAGES
──────────────────────────

<<image=sprite,x,y,w,h>>
    Embeds a sprite mid-text, with custom position and size!
	
──────────────────────────
 TEXT VOICE
──────────────────────────

<<voice=sound_asset>>
    Changes the current "voice" to play when a text character is displayed!
	set to none to disable
	
<<v_vol=...>>
	Volume of the voice! by default is 1, don't set it too high or you may blow off your eardrum

<<v_pitch=...>>
	Pitch of the voice, higher is more chipmunk-like, lower is deeper, default is 1

<<v_loop=true||false>>
	Not recommended to edit but defines if the audios should be looped?
	As said, not recommended because for each and every character the sound will play and will stay looped
	and if v_over is set to false then the audios will accumulate and may also blow off your eardrums
	...
	Default set to false!

<<v_over=true||false>>
	Determines wether or not the audio overrides itself, for example:
	I have "Base Audio" that goes like 1-2-3-4-5-4-2-1-1-1-0-0-0 (volume example??? idk like the waveform)
	
	(Visual example of the "Waveform"???? Yeah)
		   -1 -2 -3 -4 -5 -4 -2 -1 -1 -1 -0 -0 -0
		
					   -|-
				    -|||||||-
			     -|||||||||||-
		      -||||||||||||||||-
		---||||||||||||||||||||||||||||||---------
		      -||||||||||||||||-
			     ||||||||||||
				    ||||||||
					  |||
	
	If its set to true, audio will override itself, for example if the audio is currently at "1-2-3-" but another voice audio plays
	Example: (All layers are the same but are "separated" to give more visual clarity)
		--- Track1  1  2  3  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - ...
		--- Track1	-  -  -  1  2  3  4  5  4  -  -  -  -  -  -  -  -  - ...
		--- Track1	-  -  -  -  -  -  -  -  -  1  2  3  -  -  -  -  -  - ...
		--- Track1  -  -  -  -  -  -  -  -  -  -  -  -  1  2  3  4  5  4 ...
					.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
					H		 E		  L		   L		O
	it will stop and the new audio will start from 0, 1-2-3-...
	If set to false, audio will keep playing even if another audio is currently playing
	as an example imagine it as 2 "tracks" or more:
		--- Track1  1  2  3  4  5  4  2  1  1  0  -  -  -  -  -  -  -  - ...
		--- Track2	-  -  -  1  2  3  4  5  4  2  1  1  0  -  -  -  -  - ...
		--- Track3	-  -  -  -  -  -  -  -  -  1  2  3  4  5  4  2  1  0 ...
		--- Track4  -  -  -  -  -  -  -  -  -  -  -  -  1  2  3  4  5  4 ...
					.  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .
					H		 E		  L		   L		O
					
	This is just an example! But yeah

──────────────────────────
 CODE INJECTION
──────────────────────────

<<run=func_name>>
    Runs a script or function mid-text (e.g., to play animations, register events, whatever you want!)
	
	To add a function you have to do the following:
	[ function doSomething() {																			]
	[    code_that_does_something																		]
	[ }																									]
	[ ds_map_add(global.run_map, "doSomething", doSomething) <— This line is important! or it wont run	]
	then you can use: "<<run=doSomething>>" and it will run the code!

──────────────────────────
 MENUS
──────────────────────────

<<menu=fn1,fn2,...>>Option1_SEP_Option2_SEP_Option3
    Creates a menu with options, at max 4!
    - Each option can execute a function in the fn list!
    - `_SEP_` separates the current option!
	
	You have to do the same as <<run>>!
	
	function optA () {}
	function optB () {}
	ds_map_add(global.menu_fn_map, "optA", optA)
	ds_map_add(global.menu_fn_map, "optB", optB)
	
	now: "<<menu=optA,optB>>Option 1_SEP_Option 2"

──────────────────────────

Note: Multiple commands can be chained with &:
Example:
  <<effect=bounce&effect_radius=4&color=#FF0000>>
  
  
──────────────────────────
 Tips and/on How to use!
──────────────────────────
DO NOT put this obj inside a room, this object should be only used instantiated:
Instance needs to be created on a Dialogue UI Layer! If you didn't watch Noelle's tutorial
Heres how to do it: Go into rm_title or where you start stuff,
in the left side where theres the player layer and stuff, right click and
create new UI Layer, click on that and on the right should be an UI_Layer or something
rename that to "Dialogue" and to setup, double click the "Dialogue" UI Layer, and on the left
box thats down, search for "Properties" then in Game View, select Viewports, thats it!
And just in case in your obj_title or where game loading is handled add in the Game Start Event:
layer_depth(layer_get_id("Dialogue"), -999)

[WARNING] SFX and Control Managers are Needed for the current code of this DRDS.
		  It should also be in Noelle's Tutorial! If not it should be posted on
		  her Discord! Either way you can remove where they're needed in the code
		  and change it to not use them!
		  
Setup for controls (as of July 5th 2025):
——————————————————————————————————————————
with(mControl){
	registerControl("title", true);
	registerControl("player", false);
	registerControl("dialogue", false);
}
——————————————————————————————————————————


Instantiation (Creation of a Dialogue Box):
————————————————————————————————————————————————————————————
var _inst = instance_create_layer(x, y, "Dialogue", mObjDlg);
with(_inst) { init_dialogue() }
————————————————————————————————————————————————————————————
This is the correct way to do it!
And always remember to do init_dialogue()

Now with instantiation, you can change the variables with it to make the dialogue
box to match how you want it!
————————————————————————————————————————————————————————————
	d_onStart = function () { enableDaDialogue() }; -> function that executes when dialogue box in general 
	d_onEnd   = function () { disableDaDialogue() }; -> function that executes once the dialogue ends and it's destroyed
	--- Example on how to setup
		(before init_dialogue(), in the instantiation)
		d_onStart = function(){
			do some code here!
			
			enableDaDialogue() --- You can add this too to make sure dialogues are set correctly,
								   If you have more controls they can be set on the register function
								   in the Title Game Start Event, and you can edit the functions
								   enable/disableDaDialogue(9 in the create code to disable or enable
								   more of your controls!
		}
	--- The defaults of above use enable and disable DaDialogue, so the manager by default enables and disables controlling the player while in dialogue
	
	--- Presets for the box!
	--- If you don't want to change everything manually
	--- You can just use these presets that i've carefully made
	--- to match as closely as possible to actual Deltarune!
	------ If one of these are set to -1 they don't override custom code of the box section below!
	dlg_box_preset = -1; -- Controls Box Preset, 0: Light World Box, 1: Dark World Box
	dlg_pos_preset = -1; -- Controls Position Preset! 0: Text Box is on the Top part, 1: Text Box is on the Bottom part
	
	
	beforeIniParse = function () {} -> function that executes right before parsing initial text
	--- This works for parsing variable changes after the presets (if using)
	--- Example:
		beforeIniParse = function () {
			dialogue_sprite = spr_none  --- This would set the Dialogue Box to an invisible sprite
											after using one of the presets for example
		}
	--- Either way you can use it for anything you want executed before parsing the text

[ Start of Box Section ] --- Ignored if using a box preset and not using "beforeIniParse"!

	dialogue_sprite_fps = 3;			--- Not recommended to change
											Only if using custom dialogue box sprites
											Sets the DLG Box Sprite Framerate

	box_x        = 10;					--- Box starting X
	box_y        = 0;					--- Box starting y
	box_width    = 300;					--- Box width
	box_height   = 86;					--- Box height
	text_x       = box_x + 13;			--- X place where text starts writing
	text_y       = box_y + 17;			--- Y place where text starts writing
	box_wrap_spr = -90;					--- If character sprite is not spr_none, size at which text is wrapped around
	box_wrap_none = -32;				--- If character sprite is spr_none, size at which text is wrapped around
	text_x_spr_off = 19;				--- X padding if a character sprite is active
	text_x_no_off = 19;					--- X padding if theres no character sprite

	char_sprite       = spr_none;		--- Character Sprite
	char_sprite_fps   = 12;				--- Framerate of the Character Sprite if its animated!
	char_anim_frame   = 0;				--- I dont recommend changing but at which frame your char sprite animation should start at
	dialogue_sprite   = dlg_darkworld;	--- Dialogue Box BG Sprite
	box_visible       = true;			--- If the dialogue box is visible (Doesn't matter if dialogue_sprite has a sprite or not)
	char_visible      = true;			--- If the char sprite should be visible (Doesn't matter if char_sprite has a sprite or not)
	default_sound     = vc_text;		--- Starting "Voice" for text, later on it changes if you use the sound command mid dialogue
	default_font = fnt_dialogue;		--- Starting Font for text, can change with font command mid dialogue

	--- These base char stuff are default for the character sprite box
	--- They determine the base position and scale of the character sprite
	--- Many stuff like text use these as an offset so if you change these, that will be affected
	--- When using 
	base_char_w = 58;					--- Base Width of Character Sprites
	base_char_h = 58;					--- Base Height of Character Sprites
	base_char_xoff = 16;				--- Base X Offset of Char Sprite
	base_char_yoff = 0;					--- Base Y Offset of Char Sprite

	--- Same as above but for giving an initial resize without padding
	boff_char_w = 0;
	boff_char_h = 0;
	boff_char_x = 0;
	boff_char_y = 0;
	
	menu_font = fnt_dialogue;			--- Font which menu uses to draw text
	menu_wrap_width = 80;				--- Size at which text characters in the menu wrap around

	spr_menu_heart = spr_heart_cursor;	--- Cursor sprite of the menu
	heart_xoff     = -16;				--- Offset X of the cursor
	heart_yoff     = 0;					--- Offset Y of the cursor

 [ End of Box Section ]

 [ I dont recommend changing these ]
 [ ——— They handle the "C" skip ——— ]
	speed_multiplier = 1;
	fast_batch       = 20;
 [ ——————————————————————————————— ]
————————————————————————————————————————————————————————————
You can change all of these variables before using init_dialogue!
————————————————————————————————————————————————————————————
var _inst = instance_create_layer(x, y, "Dialogue", mObjDlg);
with(_inst) { 
box_x = something;
text_x = box_x + something;
init_dialogue() 
}
————————————————————————————————————————————————————————————
But if you dont want to have custom sizes and x and y values just use  the presets!
————————————————————————————————————————————————————————————
var _inst = instance_create_layer(x, y, "Dialogue", mObjDlg);
with(_inst) { 
dlg_box_preset = 0; // Light world Box!
dlg_pos_preset = 0; // Box at the Top!
// Now we initialize the dialogue in here!
text_lines = [
	"Hey! this is a dialogue!",
	"Isn't it cool?"
]
init_dialogue() 
}
————————————————————————————————————————————————————————————
Lines also support a 3 array rather than just a text line, that goes like [onstart, text, onend] ("STE" Method)
which executes a function onstart, then the dialogue text, and then a function on end!
both onstart and onend can be set to just "", and it will work fine!
to use functions on the onStart or onEnd of a line, you have to set them like in the <<run>> token,
same way, same map
I recommend using this to change character sprite, i made a built-in function to do for you!
just use changeSpr(sprite_name), example:
text_lines = [
	["changeSpr(spr_happy)", "Hey welcome to the Dialogue!", ""],
	["changeSpr(spr_sad)", "But now im sad...", ""],
	["changeSpr(spr_silly)", "I dont even know why!!!", ""]
]

this [onstart, text, onend] work fine with also only strings:

text_lines = [
	["", "Yeah!", ""],
	"Isn't that crazy?"
]

Also when changing sprites, you can use a "dump" to store them!
because if you try to apply an image asset thats not used anywhere else, it wont work,
for some reason if an asset is not declared anywhere (e.g. anAsset = spr_asset) it won't register for the game
so you can have as i have:
dump_1 = vc_character;
dump_2 = sprite_dialogue_happy;
and so on!

————————————————————————————————————————————————————————————
	BUILT-IN FUNCTIONS BY YAD! :3
————————————————————————————————————————————————————————————

	- changeSpr(sprite_name)				--- changes the sprite to the one specified
												in the argument
												
	- cTransform(method, property, value)	--- changes the character sprite offsets.
											--- Methods: "set", "add"
														"set": sets the offset value
														"add": adds to the current offset value
											--- Properties: "x", "y", "w", "h"
														"x" | "y": X and Y position offset
														"w" | "h": Width and Height offset
											--- Value: Any number, defaults to 0
											
	- setSprite(spr, x, y, w, h)			--- Combines methods above, this is recommended to use
												when changing both sprite size and current sprite
												because if methods above are used separately:
													onstart: "cTransform(set, w, 10), changeSpr(void)" or
													text: "<<run=cTransform(set, w, 10), changeSpr(void)"
												it will look choppy or there'll be a frame where either
												the sprite is invisible or doesn't have the correct dimensions
												so it's recommended you use this method instead.
												If you're just changing a single character's sprite then just use
												changeSpr (Assumming all of their sprites use the same sprite size)
												
	- add_dialogue(text || array)			--- Adds new dialogue, needs to be nested in a function
													function hi
														add_dialogue(text or array)
														(can add both a text "hi new dialogue"
														or an array of new lines:
														var lines = [
															"hi",
															"more lines, yes!"
														] just like text_lines.)
													}
												Not recommended to use "d_onEnd", since that function is executed right before
												the dialogue box is destroyed so it may cause issues, i guess you can use it
												in the STE method onend but i'm not sure if that would cause issues or not if
												its the last line of dialogue.

————————————————————————————————————————————————————————————

Now how to use Menus!!!
And how to have Option Chosing affect your history

Ok! when using menus we use the <<menu>> token,
You can have functions set to options, so if you want to add dialogue after an option or affect something,
heres how!
————————————————————————————————————————————————————————————
var _inst = instance_create_layer(x, y, "Dialogue", mObjDlg);
with(_inst) {
// using preset, i dont wanna put it but yeah
--- Also, when using menus! i recommend putting at first <<disablestartstar>> then a <<breakspace=false>>
	that way it looks centered!, if not you can just use it however and experiment with it!
text_lines = [
	"<<disablestartstar>><<breakspace=false>><<menu=optA,optB>>Option 1_SEP_Option 2"
]
--- Now that thats set! just make the functions as said on the menu token
	Here i'll explain how to add more dialogue and affect events
function optA(){
	// Adding new lines!
	var newLines = [
		"Option A!, Thats Cool!",
		"Wanna talk bout something?"
	]
	// I've made another built-in variable for this, so just use it here!
	add_dialogue(newLines);
	// And that should add new Lines after pressing option A!
	   Now if you want to add here more code you can! you can set a global variable to record
	   an event or anything, so that it affects your game later, but yeah!
}
function optB(){
 // More code for Option B :3
}
ds_map_add... ---im lazy to put it but yeah, its on the <<menu>> token help thing
init_dialogue()
}
————————————————————————————————————————————————————————————

You can trigger events using whatever you like, making a key press, or a collision with a trigger event,
just instantiate it like shown here there!

That's all for now i think, Thanks for using this! If you can give credits then i'll gladly accept it!


										Made by Yad_Zero
*/
#endregion


function disableDaDialogue() {
    mControl.disableControl("dialogue");
	mControl.enableControl("player");
}
function enableDaDialogue() {
    mControl.disableControl("player");
	mControl.enableControl("dialogue");
}

ds_map_add(global.run_map, "changeSpr", changeSpr)
ds_map_add(global.run_map, "cTransform", cTransform)
ds_map_add(global.run_map, "setSprite", setSprite)

function changeSpr(spr) {
    var _spr = is_string(spr) ? asset_get_index(spr) : spr;
    char_sprite = sprite_exists(_spr) ? _spr : spr_none;

    var old_index = text_char_index;

    var revealed_chars = 0;
    for (var i = 0; i < old_index; i++) {
        if (parsed_text[i].type == "char") {
            revealed_chars++;
        }
    }

    if (text_index >= array_length(text_lines)) return;
    var line = text_lines[text_index];
    parsed_text = parse_text_line(line);

    text_char_index = old_index;

    waiting_on_timer = false;
    timer_wait = 0;

    displayed_text = "";
    letter_colors = [];
    var char_so_far = 0;
    for (var i = 0; i < text_char_index; i++) {
        var e = parsed_text[i];
        if (e.type == "char") {
            if (is_struct(e) && variable_instance_exists(e, "char")) {
                displayed_text += e.char;
                array_push(letter_colors, e.color);
                char_so_far++;
            }
        }
    }
}

/// @func cTransform(method, property, value = 0)
/// @arg methodC   String: "set" or "add"
/// @arg property String: one of "x", "y", "w", "h"
/// @arg value    Real (optional): amount to set or add (defaults to 0)
function cTransform(methodC, property, value = 0) {
    if (!is_real(value)) value = 0;

    var propName = "";
    switch (string_lower(property)) {
        case "x": propName = "boff_char_x"; break;
        case "y": propName = "boff_char_y"; break;
        case "w": propName = "boff_char_w"; break;
        case "h": propName = "boff_char_h"; break;
        default:
            return;
    }

    var current = variable_instance_get(id, propName);

    switch (string_lower(methodC)) {
        case "set":
            variable_instance_set(id, propName, value);
            break;

        case "add":
            variable_instance_set(id, propName, current + value);
            break;

        default:
            break;
    }
}

/// @func setSprite(sprite_arg, x_arg, y_arg, w_arg, h_arg)
/// @arg sprite_arg String or resource ID of the sprite to use
/// @arg x_arg      String or Real: new x position (defaults to 0)
/// @arg y_arg      String or Real: new y position (defaults to 0)
/// @arg w_arg      String or Real: new width     (defaults to 0)
/// @arg h_arg      String or Real: new height    (defaults to 0)
function setSprite(sprite_arg, x_arg, y_arg, w_arg, h_arg) {
    var inputs   = [ x_arg,  y_arg,  w_arg,  h_arg ];
    var properties = [ "x",    "y",    "w",    "h"    ];

    for (var i = 0; i < 4; i++) {
        var raw = inputs[i];
        var val = 0;

        if (is_real(raw)) {
            val = raw;
        }
        else if (is_string(raw) && is_number_literal(raw)) {
            val = real(string_trim(raw));
        }

        cTransform("set", properties[i], val);
    }
	
    changeSpr(sprite_arg);
}

/// @func add_dialogue(daLines)
/// @desc  Add dialogue and reparse so that it works!
/// @arg   daLines  A string or an array of strings
function add_dialogue(daLines) {
    var lines_to_add = is_array(daLines) ? daLines : [ daLines ];
    
    var old_length = array_length(text_lines);
    
    for (var i = 0; i < array_length(lines_to_add); i++) {
        array_push(text_lines, lines_to_add[i]);
    }
    
    if (text_index < old_length) {
        return; // This shi being important otherwise dialogue gets killed everytime you add dialogue
    }
    
    text_index       = old_length;
    parsed_text      = parse_text_line(text_lines[text_index]);
    text_char_index  = 0;
    text_timer       = 0;
    text_done        = false;
    reveal_frames    = [];
    letter_colors    = [];
    skip_all         = false;
    auto_advance     = false;
    unskippable      = false;
    input_advance    = false;
    menu_active      = false;
    line_start_frame = frame_counter;
}

d_onStart = function () { enableDaDialogue() };
d_onEnd   = function () { disableDaDialogue() };

beforeIniParse = function () {}

text_index        = 0;
text_char_index = 0;
timer_wait = -1;
waiting_on_timer = false;
text_timer        = 0;
text_done         = false;

dialogue_anim_timer = 0;
dialogue_anim_frame = 0;
dialogue_sprite_fps = 3;

dlg_box_preset = -1;
dlg_pos_preset = -1;

box_x        = 10;
box_y        = 0;
box_width    = 300;
box_height   = 86;
text_x       = box_x + 13;
text_y       = box_y + 17;
box_wrap_spr = -90;
box_wrap_none = -32;
text_x_spr_off = 19;
text_x_no_off = 19;

char_sprite       = spr_none;
char_sprite_fps   = 12;
char_anim_timer   = 0;
char_anim_frame   = 0;
dialogue_sprite   = dlg_darkworld;
box_visible       = true;
char_visible      = true;
if global.lang != "jp"{
	default_font = fnt_main;
} else{
	default_font = fnt_main_jp
}

voice_enabled = true;
default_sound     = snd_txt;
sound_vol = 1;
sound_pitch = 1;
sound_loop = false;
sound_interrupt = false;

base_char_w = 58;
base_char_h = 58;
base_char_xoff = 16;
base_char_yoff = 0;

boff_char_w = 0;
boff_char_h = 0;
boff_char_x = 0;
boff_char_y = 0;

input_advance    = false;
input_skip       = false;
speed_multiplier = 1;
fast_batch       = 20;

frame_counter            = 0;
line_start_frame         = 0;
last_whole_shake_frame   = -1;
whole_shake_x            = 0;
whole_shake_y            = 0;
current_whole_shake_enabled   = false;
current_whole_shake_offset    = 0;
current_whole_shake_intensity = 0;
reveal_frames            = [];

letter_colors  = [];
parsed_text    = [];
displayed_text = "";
skip_all       = false;
auto_advance   = false;
unskippable    = false;
w_padding      = (char_sprite != spr_none && char_visible) ? box_wrap_spr : box_wrap_none;
wrap_w         = box_width + w_padding;

if global.lang != "jp"{
	menu_font = fnt_main;
} else{
	menu_font = fnt_main_jp
}
menu_active    = false;
menu_options   = [];
menu_fns       = [];
menu_selection = 0;
menu_choice    = noone;
menu_wrap_width = 80;

spr_menu_heart = spr_heart_cursor;
heart_xoff     = 1;
heart_yoff     = 2;

function hex_to_color(hex_str) {
    if (string_char_at(hex_str,1) == "#") hex_str = string_delete(hex_str,1,1);
    if (string_length(hex_str) != 6) return c_white;
    var r = real("0x" + string_copy(hex_str,1,2)),
        g = real("0x" + string_copy(hex_str,3,2)),
        b = real("0x" + string_copy(hex_str,5,2));
    return make_color_rgb(r, g, b);
}

function checkIfColor(raw) {
    var s = string_lower(string_trim(raw));
    
    switch (s) {
        case "c_black":   return c_black;
        case "c_white":   return c_white;
        case "c_red":     return c_red;
        case "c_green":   return c_green;
        case "c_blue":    return c_blue;
        case "c_lime":    return c_lime;
        case "c_yellow":  return c_yellow;
        case "c_aqua":    return c_aqua;
        case "c_fuchsia": return c_fuchsia;
        case "c_maroon":  return c_maroon;
        case "c_gray":    return c_gray;
		// extra?
        case "c_dkgray":   return c_dkgray;
        case "c_ltgray":    return c_ltgray;
        case "c_navy":    return c_navy;
        case "c_olive":  return c_olive;
        case "c_orange":    return c_orange;
        case "c_purple": return c_purple;
        case "c_silver":  return c_silver;
        case "c_teal":    return c_teal; 		 	 
    }
    
    if ( string_starts_with(s, "#") ) {
        s = string_delete(s, 1, 1);
    }
	
    if ( string_length(s) == 6 ) {
        return hex_to_color(s);
    }
    
    return c_white;
}

/// @func is_number_literal(str)
/// @arg str   // any string
/// @return     // true if str is like "123", "0.5", "42.75", etc.; false otherwise
function is_number_literal(str) {
    var s = string_trim(str);
    
    if ( string_length(s) == 0 ) return false;
    
    if ( string_count(s, ".") > 1 ) return false;
    
    var no_dot = string_replace(s, ".", "");
    return ( no_dot == string_digits(no_dot) );
}

/// @func parse_bool_literal(str)
/// @arg str   // "true" or "false" (case-insensitive)
/// @return    // true or false, defaulting to false if invalid
function parse_bool_literal(str) {
    var s = string_lower(string_trim(str));
    return (s == "true");
}

function measure_str(s, font_asset, font_size) {
    draw_set_font(font_asset);
    return string_width(s) * (font_size / 8);
}

/// @func split_functions(str)
/// @arg str String containing one or more func(...) calls, separated by commas
/// @return Array of trimmed strings, each either "func" or "func(arg1,arg2)"
function split_functions(str) {
    var parts = []; 
    var buf   = ""; 
    var our_depth = 0;

    // walk every character in str
    for (var i = 1; i <= string_length(str); i++) {
        var c = string_char_at(str, i);

        // track paren depth
        if (c == "(") our_depth++;
        else if (c == ")") our_depth--;

        // if we see a comma at depth 0, that’s a separator
        if (c == "," && our_depth == 0) {
            array_push(parts, string_trim(buf));
            buf = "";
        } else {
            buf += c;
        }
    }
    // last chunk
    if (string_length(string_trim(buf)) > 0) {
        array_push(parts, string_trim(buf));
    }

    return parts;
}

parse_text_line = function(raw_line) {
    var out = [];

    //if (is_array(raw_line) && array_length(raw_line) == 3) {
    //    if (raw_line[0] != "") array_push(out, { type: "run", fn: raw_line[0] });
    //    var mid = parse_text_line(raw_line[1]);
    //    for (var m = 0; m < array_length(mid); m++) array_push(out, mid[m]);
    //    if (raw_line[2] != "") array_push(out, { type: "run", fn: raw_line[2] });
    //    return out;
    //}

if (is_array(raw_line) && array_length(raw_line) == 3) {
    var leftCalls = split_functions(raw_line[0]);
    for (var i = 0; i < array_length(leftCalls); i++) {
        if (leftCalls[i] != "") {
            array_push(out, { type: "run", fn: leftCalls[i] });
        }
    }

    var mid = parse_text_line(raw_line[1]);
    for (var m = 0; m < array_length(mid); m++) {
        array_push(out, mid[m]);
    }

    var rightCalls = split_functions(raw_line[2]);
    for (var j = 0; j < array_length(rightCalls); j++) {
        if (rightCalls[j] != "") {
            array_push(out, { type: "run", fn: rightCalls[j] });
        }
    }

    return out;
}

    var font_asset = default_font;
	if global.lang != "jp"{
		var base_size  = 8;
	} else{
		var base_size  = 2;
	}
    var color      = c_white;
	var hasshadow = false;
	// check once before to see if light world or uhh dark world
	switch(dialogue_sprite) {
		case dlg_normal:
				hasshadow = false;
			break;
		case dlg_darkworld:
				hasshadow = true;
			break
	}
	var shadow_color      = hex_to_color("#141478");
    var effect     = "none", effect_sp = 1, effect_rad = 4;
    var shake_t    = "none", shake_i = 0, shake_o = 0;
    var char_sp    = 1;
    var xoff = 0, yoff = 0;
    var font_size = base_size;
	if global.lang != "jp"{
		var bullet_w   = measure_str("* ", font_asset, base_size);
		star = "* "
	} else{
		var bullet_w   = measure_str("* ", font_asset, base_size);
		star = "＊ "
	}
	
	// ok im genuinely loosing it what the hell i've spent about 1 hour tinking of where to put this
	var curSnd = default_sound;
	var curVol = sound_vol;
	var curPitch = sound_pitch;
	var curLoop = sound_loop; // ????? This shouldn't be editable but uhh okay?
	var curOver = sound_interrupt;
	// OK WHAT THE HELL I DIDN'T EVEN USE IT FUCK
	// im loosing ittt
	
	var fastReveal = false;

    var disable_start_star = false;
	
	var daHighlight = {
		h1: color,
		h2: color,
		enabled: false
	};
	var daHShadow = {
		s1: shadow_color,
		s2: shadow_color,
		enabled: false
	};

    var tokens = [], i = 1;
    while (i <= string_length(raw_line)) {
while (i <= string_length(raw_line)) {
    if (string_copy(raw_line, i, 2) == "<<") {
        while (string_copy(raw_line, i, 2) == "<<") {
            var rem = string_copy(raw_line, i, string_length(raw_line) - i + 1);
            var e   = string_pos(">>", rem);
            if (e <= 0) break;

            var cmd_str = string_copy(rem, 3, e - 3);
            var lower   = string_lower(cmd_str);

            if (string_starts_with(lower, "breakspace")) {
                var parts = string_split(cmd_str, "=");
                var show_star = true;
                if (array_length(parts) == 2)
                    show_star = (string_lower(string_trim(parts[1])) == "true");
                array_push(tokens, { type: "breakspace", show_star: show_star });
            } else if (lower == "autoskip") {
                array_push(tokens, { type: "flag", flag: "autoskip" });
            } else if (lower == "unskippable") {
                array_push(tokens, { type: "flag", flag: "unskippable" });
            } else if (lower == "disablestartstar") {
                array_push(tokens, { type: "flag", flag: "disablestartstar" });
            } else {
                array_push(tokens, { type: "cmd", cmd: cmd_str });
            }

            i += e + 1;

            if (string_copy(raw_line, i, 2) == "<<") {
                array_push(tokens, { type: "noop" });
            }
        }
    } else {
        array_push(tokens, { type: "text", raw: string_char_at(raw_line, i) });
        i++;
    }
}
    }
	
    var paragraphs = [];
    var curPara = [];
    for (var t = 0; t < array_length(tokens); t++) {
        var tk = tokens[t];
        if (tk.type == "breakspace") {
            if (array_length(curPara) > 0) array_push(paragraphs, curPara);
            curPara = [ tk ];
        } else {
            array_push(curPara, tk);
        }
    }
    if (array_length(curPara) > 0) array_push(paragraphs, curPara);

    for (var p_i = 0; p_i < array_length(paragraphs); p_i++) {
        var para = paragraphs[p_i];
        if (p_i > 0) array_push(out, { type: "break", font_size: font_size });

        var startIndex = 0;
        if (para[0].type == "breakspace") {
            var show = para[0].show_star;
            if (show) {
                array_push(out, { type: "char", char: "* ", fucksound: true, insta: fastReveal, color: color, hasshad: hasshadow, shad_color: shadow_color, hlight: {h1: daHighlight.h1,h2: daHighlight.h2,enabled: daHighlight.enabled}, hshadow: {s1: daHShadow.s1,s2: daHShadow.s2,enabled: daHShadow.enabled}, font: default_font, font_size: base_size, char_speed: 1, xoff: 0, yoff: 0, shake_type: "none", shake_intensity: 0, shake_offset: 0, effect: "none", effect_speed: 1, effect_radius: 1 });
            } else {
                array_push(out, { type: "indent", width: bullet_w });
            }
            startIndex = 1;
        } else {
            for (var f = 0; f < array_length(tokens); f++) {
                if (tokens[f].type == "flag" && tokens[f].flag == "disablestartstar") disable_start_star = true;
            }
            if (!disable_start_star) {
                array_push(out, { type: "char", char: star, fucksound: true, insta: fastReveal, color: color, hasshad: hasshadow, shad_color: shadow_color, hlight: {h1: daHighlight.h1,h2: daHighlight.h2,enabled: daHighlight.enabled}, hshadow: {s1: daHShadow.s1,s2: daHShadow.s2,enabled: daHShadow.enabled}, font: default_font, font_size: base_size, char_speed: 1, xoff: 0, yoff: 0, shake_type: "none", shake_intensity: 0, shake_offset: 0, effect: "none", effect_speed: 1, effect_radius: 1 });
            } else {
                array_push(out, { type: "indent", width: bullet_w });
            }
        }

        var cur_line_w=bullet_w, word_buf=[], word_w=0;

        for(var j=0;j<array_length(para);j++){
w_padding    = (char_sprite != spr_none && char_visible) ? box_wrap_spr : box_wrap_none;
wrap_w     = box_width + w_padding;
            var tk=para[j];
		    if (tk.type == "noop") {
				array_push(out, {type:"noop"})
		        continue;
		    }
            if(tk.type=="flag"){
                if(tk.flag=="autoskip")    array_push(out,{type:"autoskip"});
                if(tk.flag=="unskippable") array_push(out,{type:"unskippable"});
                continue;
            }
            if(tk.type=="cmd"){
                if(array_length(word_buf)>0){
                    if(cur_line_w+word_w>wrap_w){
                        array_push(out,{type:"break",font_size:font_size});
                        array_push(out,{type:"indent",width:bullet_w});
                        cur_line_w=bullet_w;
                    }
                    for(var wb=0;wb<array_length(word_buf);wb++){
                        var ch=word_buf[wb];
                        array_push(out,{type:"char",char:ch.raw,color:color, insta: fastReveal, hasshad: hasshadow, shad_color: shadow_color, hlight: {h1: daHighlight.h1,h2: daHighlight.h2,enabled: daHighlight.enabled}, hshadow: {s1: daHShadow.s1,s2: daHShadow.s2,enabled: daHShadow.enabled}, font:font_asset,font_size:font_size,char_speed:char_sp,xoff:xoff,yoff:yoff,shake_type:shake_t,shake_intensity:shake_i,shake_offset:shake_o,effect:effect,effect_speed:effect_sp,effect_radius:effect_rad});
                        cur_line_w += measure_str(ch.raw,font_asset,font_size);
                    }
                    word_buf=[]; word_w=0;
                }
                var parts=string_split(tk.cmd,"&"), is_image=false, img_args=[];
                for(var p=0;p<array_length(parts);p++){
w_padding    = (char_sprite != spr_none && char_visible) ? box_wrap_spr : box_wrap_none;
wrap_w     = box_width + w_padding;
                    var pr=string_trim(parts[p]);
					if (string_starts_with(pr, "run=")) {
					    var callString = string_delete(pr, 1, 4);

					    var calls = split_functions(callString);
					    for (var i = 0; i < array_length(calls); i++) {
					        if (calls[i] != "") {
					            array_push(out, {
					                type: "run",
					                fn:   calls[i]
					            });
					        }
					    }
					}
					else if (string_starts_with(pr, "timer=")) {
					    var delay_amount = real(string_delete(pr, 1, 6)); // Remove "timer=" and parse the number
					    array_push(out, {type: "timer", duration: delay_amount});
					    continue;
					}
                    else if(string_starts_with(pr,"image=")){
                        is_image=true;
                        img_args=string_split(string_delete(pr,1,6),",");
                    }
					// What the actual fuck???
                    else if(string_starts_with(pr,"effect="))       effect    = string_delete(pr,1,7);
                    else if(string_starts_with(pr,"effect_speed=")) effect_sp = real(string_delete(pr,1,13));
                    else if(string_starts_with(pr,"effect_radius="))effect_rad= real(string_delete(pr,1,14));
                    else if(string_starts_with(pr,"color="))        color     = checkIfColor(string_delete(pr,1,6));
					else if(string_starts_with(pr,"revealstart")) fastReveal = true;
					else if(string_starts_with(pr,"revealend")) fastReveal = false;
					else if (string_starts_with(pr, "highlight=")) {
					    var args = string_delete(pr, 1, 10); // Remove "highlight="

					    if (args == "none") {
					        daHighlight.enabled = false;
					    } else {
					        if (string_pos(",", args) > 0) {
					            var cols = string_split(args, ",");
					            if (array_length(cols) == 2) {
					                daHighlight.h1 = hex_to_color(cols[0]);
					                daHighlight.h2 = hex_to_color(cols[1]);
					                daHighlight.enabled = true;
					            }
					        } else {
					            switch (string_lower(args)) {
					                case "dw_yellow":
					                    daHighlight.h1 = hex_to_color("#FFFFFF");
					                    daHighlight.h2 = hex_to_color("#FFFF00");
					                    daHighlight.enabled = true;
					                break;

					                case "dw_red":
					                    daHighlight.h1 = hex_to_color("#FFFFFF");
					                    daHighlight.h2 = hex_to_color("#FF0000");
					                    daHighlight.enabled = true;
					                break;

					                case "dw_navy":
					                    daHighlight.h1 = hex_to_color("#FFFFFF");
					                    daHighlight.h2 = hex_to_color("#000080");
					                    daHighlight.enabled = true;
					                break;
					                case "dw_green":
					                    daHighlight.h1 = hex_to_color("#FFFFFF");
					                    daHighlight.h2 = hex_to_color("#00FF00");
					                    daHighlight.enabled = true;
					                break
					                case "dw_cyan":
					                    daHighlight.h1 = hex_to_color("#FFFFFF");
					                    daHighlight.h2 = hex_to_color("#11b0ff");
					                    daHighlight.enabled = true;
					                break;

					                default:
					                    daHighlight.enabled = false;
					                break;
					            }
					        }
					    }
					}
					else if (string_starts_with(pr, "h_shadow=")) {
					    var args = string_delete(pr, 1, 9); // Remove "h_shadow="

					    if (args == "none") {
					        daHShadow.enabled = false;
					    } else {
					        if (string_pos(",", args) > 0) {
					            var cols = string_split(args, ",");
					            if (array_length(cols) == 2) {
					                daHShadow.s1 = hex_to_color(cols[0]);
					                daHShadow.s2 = hex_to_color(cols[1]);
					                daHShadow.enabled = true;
					            }
					        } else {
					            switch (string_lower(args)) {
					                case "dw_yellow":
					                    daHShadow.s1 = hex_to_color("#4C4C00");
					                    daHShadow.s2 = hex_to_color("#4C4C00");
					                    daHShadow.enabled = true;
					                break;

					                case "dw_red":
					                    daHShadow.s1 = hex_to_color("#800000");
					                    daHShadow.s2 = hex_to_color("#800000");
					                    daHShadow.enabled = true;
					                break;

					                case "dw_navy":
					                    daHShadow.s1 = hex_to_color("#000048");
					                    daHShadow.s2 = hex_to_color("#000048");
					                    daHShadow.enabled = true;
					                break;

					                case "dw_green":
					                    daHShadow.s1 = hex_to_color("#008000");
					                    daHShadow.s2 = hex_to_color("#008000");
					                    daHShadow.enabled = true;
					                break;

					                case "dw_cyan":
					                    daHShadow.s1 = hex_to_color("#00375b");
					                    daHShadow.s2 = hex_to_color("#00375b");
					                    daHShadow.enabled = true;
					                break;

					                default:
					                    daHShadow.enabled = false;
					                break;
					            }
					        }
					    }
					}
					else if(string_starts_with(pr,"hasshadow="))        hasshadow     = (string_delete(pr,1,10));
					else if(string_starts_with(pr,"shadow_color="))        shadow_color     = checkIfColor(string_delete(pr,1,13));
					else if (string_starts_with(pr, "font=")) {
					    var new_font = asset_get_index(string_delete(pr, 1, 5));
					    if (new_font != -1) font_asset = new_font;
					}
                    else if(string_starts_with(pr,"font_size="))    font_size = real(string_delete(pr,1,10));
                    else if(string_starts_with(pr,"char_speed="))   char_sp   = real(string_delete(pr,1,11));
                    else if(string_starts_with(pr,"xoff="))         xoff      = real(string_delete(pr,1,5));
                    else if(string_starts_with(pr,"yoff="))         yoff      = real(string_delete(pr,1,5));
                    else if(string_starts_with(pr,"shake="))        shake_t   = string_delete(pr,1,6);
                    else if(string_starts_with(pr,"intensity="))    shake_i   = real(string_delete(pr,1,10));
                    else if(string_starts_with(pr,"offset="))       shake_o   = real(string_delete(pr,1,7));
                    else if(string_starts_with(pr,"face=")){
                        var nm=string_delete(pr,1,5), sp=asset_get_index(nm);
                        if(sp==-1) sp=spr_none;
                        array_push(out,{type:"face",sprite:sp});
                    }
					else if(string_starts_with(pr,"face_w=")) {
					    face_w_add = real(string_delete(pr, 1, 7));
					    array_push(out, { type: "face_dim", dim: "w", add: face_w_add });
					}
					else if(string_starts_with(pr,"face_h=")) {
					    face_h_add = real(string_delete(pr, 1, 7));
					    array_push(out, { type: "face_dim", dim: "h", add: face_h_add });
					}
					else if(string_starts_with(pr,"face_x=")) {
					    face_x_add = real(string_delete(pr, 1, 7));
					    array_push(out, { type: "face_dim", dim: "x", add: face_x_add });
					}
					else if(string_starts_with(pr,"face_y=")) {
					    face_y_add = real(string_delete(pr, 1, 7));
					    array_push(out, { type: "face_dim", dim: "y", add: face_y_add });
					}
					else if (string_starts_with(pr, "voice=")) {
					    var raw = string_delete(pr, 1, 6);
						var amIFucking = voice_enabled
					    if (string_lower(raw) == "none") {
					        amIFucking = false;
					    } else {
					        var snd = asset_get_index(raw);
					        if (snd != -1) {
					            array_push(out, { type: "voice", sound: snd });
					            amIFucking = true;
					        } else {
								array_push(out, { type: "voice", sound: default_sound });
					            amIFucking = true;
					        }
					    }
						array_push(out, {
						    type:  "s_enabled",
						    val: amIFucking
						})
					}
					else if ( string_starts_with(pr, "v_vol=") ) {
					    var raw = string_delete(pr, 1, 6);
    
					    var vol = is_number_literal(raw) 
					              ? real(raw) 
					              : 1;
    
					    array_push(out, {
					        type:  "s_volume",
					        val: vol
						})
					}
					else if ( string_starts_with(pr, "v_pitch=") ) {
					    var raw = string_delete(pr, 1, 8);
    
					    var pish = is_number_literal(raw) 
					              ? real(raw) 
					              : 1;
    
					    array_push(out, {
					        type:  "s_pitch",
					        val: pish
						})
					}
					else if ( string_starts_with(pr, "v_loop=") ) {
					    var raw = string_delete(pr, 1, 7);
    
					    var lop = parse_bool_literal(raw) ? bool(raw) : false;
    
					    array_push(out, {
					        type:  "s_loop",
					        val: lop
						})
					}
					else if ( string_starts_with(pr, "v_over=") ) {
					    var raw = string_delete(pr, 1, 7);
    
					    var ovr = parse_bool_literal(raw) ? bool(raw) : false;
    
					    array_push(out, {
					        type:  "s_interruptr",
					        val: ovr
						})
					}
                }
                // Yummy banana work, yays!
                if(is_image && array_length(img_args)==5){
                    var spr=asset_get_index(string_trim(img_args[0])),
                        ix=real(img_args[1]), iy=real(img_args[2]),
                        iw=real(img_args[3]), ih=real(img_args[4]);
                    if(cur_line_w+iw>wrap_w){
                        array_push(out,{type:"break",font_size:font_size});
                        array_push(out,{type:"indent",width:bullet_w-floor(iw/4)});
                        cur_line_w=bullet_w-floor(iw/4);
                    }
                    array_push(out,{type:"image",sprite:spr,x:ix,y:iy,w:iw,h:ih,effect:effect,effect_speed:effect_sp,effect_radius:effect_rad,shake_type:shake_t,shake_intensity:shake_i,shake_offset:shake_o});
                    cur_line_w+=iw+2;
                }
                continue;
            }
            if(tk.type=="text"){
                if(tk.raw==" "){
                    if(array_length(word_buf)>0){
                        if(cur_line_w+word_w>wrap_w){
                            array_push(out,{type:"break",font_size:font_size});
                            array_push(out,{type:"indent",width:bullet_w});
                            cur_line_w=bullet_w;
                        }
                        for(var wb=0;wb<array_length(word_buf);wb++){
                            var ch=word_buf[wb];
                            array_push(out,{type:"char",char:ch.raw,color:color, insta: fastReveal, hasshad: hasshadow, shad_color:shadow_color, hlight: {h1: daHighlight.h1,h2: daHighlight.h2,enabled: daHighlight.enabled}, hshadow: {s1: daHShadow.s1,s2: daHShadow.s2,enabled: daHShadow.enabled}, font:font_asset,font_size:font_size,char_speed:char_sp,xoff:xoff,yoff:yoff,shake_type:shake_t,shake_intensity:shake_i,shake_offset:shake_o,effect:effect,effect_speed:effect_sp,effect_radius:effect_rad});
                            cur_line_w+=measure_str(ch.raw,font_asset,font_size);
                        }
                        word_buf=[]; word_w=0;
                    }
                    var sw=measure_str(" ",font_asset,font_size);
                    array_push(out,{type:"char",char:" ",color:color, insta: fastReveal, hasshad: hasshadow, shad_color: shadow_color, hlight: {h1: daHighlight.h1,h2: daHighlight.h2,enabled: daHighlight.enabled}, hshadow: {s1: daHShadow.s1,s2: daHShadow.s2,enabled: daHShadow.enabled}, font:font_asset,font_size:font_size,char_speed:char_sp,xoff:xoff,yoff:yoff,shake_type:shake_t,shake_intensity:shake_i,shake_offset:shake_o,effect:effect,effect_speed:effect_sp,effect_radius:effect_rad});
                    cur_line_w+=sw;
                } else {
                    array_push(word_buf,tk);
                    word_w+=measure_str(tk.raw,font_asset,font_size);
                }
            }
        }
		
		// uhr yeah?
        if(array_length(word_buf)>0){
            if(cur_line_w+word_w>wrap_w){
                array_push(out,{type:"break",font_size:font_size});
                array_push(out,{type:"indent",width:bullet_w});
                cur_line_w=bullet_w;
            }
            for(var wb=0;wb<array_length(word_buf);wb++){
                var ch=word_buf[wb];
                array_push(out,{type:"char",char:ch.raw, color:color, insta: fastReveal, hasshad: hasshadow, shad_color: shadow_color, hlight: {h1: daHighlight.h1,h2: daHighlight.h2,enabled: daHighlight.enabled}, hshadow: {s1: daHShadow.s1,s2: daHShadow.s2,enabled: daHShadow.enabled}, font:font_asset,font_size:font_size,char_speed:char_sp,xoff:xoff,yoff:yoff,shake_type:shake_t,shake_intensity:shake_i,shake_offset:shake_o,effect:effect,effect_speed:effect_sp,effect_radius:effect_rad});
                cur_line_w+=measure_str(ch.raw,font_asset,font_size);
            }
        }
    }
/*
According to all known laws of aviation, there is no way a bee should be able to fly.
Its wings are too small to get its fat little body off the ground.
The bee, of course, flies anyway because bees don't care what humans think is impossible.
This is menu code btw
*/
var menu_pos = string_pos("<<menu", raw_line);
if (menu_pos > 0) {
    var rem  = string_copy(raw_line, menu_pos, string_length(raw_line) - menu_pos + 1);
    var end2 = string_pos(">>", rem);
    if (end2 <= 0) return [];
    
    var cmd_str = string_copy(rem, 3, end2 - 3);
    var fn_list = [];
    
    if (string_lower(string_copy(cmd_str,1,5)) == "menu=") {
        var raw_fns = string_copy(cmd_str,6,string_length(cmd_str)-5);
        fn_list = string_split(raw_fns, ",");
        for (var i = 0; i < array_length(fn_list); i++)
            fn_list[i] = string_trim(fn_list[i]);
    }
    
    var prefix   = string_copy(raw_line, 1, menu_pos - 1);
    var opts_raw = string_copy(raw_line, menu_pos + end2 + 1, string_length(raw_line) - (menu_pos + end2));
    var out_arr  = [];
    
    if (string_length(string_trim(prefix)) > 0) {
        var pre = parse_text_line(prefix);
        for (var j = 0; j < array_length(pre); j++)
            array_push(out_arr, pre[j]);
    }
    
    var options = string_split(opts_raw, "_SEP_");
    for (var j = 0; j < array_length(options); j++)
        options[j] = string_trim(options[j]);
    
    array_push(out_arr, {
        type:    "menu",
        options: options,
        fns:     fn_list
    });
    return out_arr;
}

	return out;
};

function init_dialogue() {
switch (dlg_pos_preset) {
	case 0: // Up
		switch(dialogue_sprite) {
			case dlg_normal:
				box_y = 2;
				break;
			case dlg_darkworld:
				box_y = 0;
				break;
			default:
				box_y = 2;
				break;
		}
		break;
	case 1: // Down
		switch(dialogue_sprite) {
			case dlg_normal:
				box_y = (240-box_height);
				break;
			case dlg_darkworld:
				box_y = (240-box_height)+4;
				break;
			default:
				box_y = (240-box_height);
				break;
		}
		break;
}
switch (dlg_box_preset) {
	case 0: // Light world
		//def x and y
		box_x        = ((320-296)/2)+1;
		box_width    = 296;
		box_height   = 81;
		//text_x       = box_x + 0;
		text_x_spr_off = 16;
		text_x_no_off = 15;
		text_y       = box_y + 15;
		box_wrap_spr = -88;
		box_wrap_none = -32;

		dialogue_sprite   = dlg_normal;
		box_visible       = true;
		char_visible      = true;

		base_char_w = 58;
		base_char_h = 58;
		base_char_xoff = 16;
		base_char_yoff = 0;
	break;
	case 1: // Dark world
		//def x and y
		box_x        = 10;
		box_width    = 300;
		box_height   = 86;
		//text_x       = box_x + 13;
		
		text_y       = box_y + 17;
		box_wrap_spr = -90;
		box_wrap_none = -32;
		text_x_spr_off = 19;
		text_x_no_off = 15;

		dialogue_sprite   = dlg_darkworld;
		box_visible       = true;
		char_visible      = true;

		base_char_w = 58;
		base_char_h = 58;
		base_char_xoff = 16;
		base_char_yoff = 0;
	break;
}

    if (is_callable(beforeIniParse)) {
        beforeIniParse();
    }
	w_padding    = (char_sprite != spr_none && char_visible) ? box_wrap_spr : box_wrap_none;
	wrap_w     = box_width + w_padding;
    parsed_text = parse_text_line(text_lines[text_index]);
    if (is_callable(d_onStart)) {
        d_onStart();
    }
}