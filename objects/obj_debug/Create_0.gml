/* 
 * ~noelle's gamemaker debug system v2.1.0 (ngmdbs2.1)~
 * major version - significant new feature(s)/change(s)
 * minor version - small things
 * patch - patches/bugfixes
 * 
 * //changelog v2.1//
 * - spawning now uses depth instead of layer to ensure the ui displays ontop of everything
 * - anything called "mainchara" is now "mainchara" to align with my videos as of pt14
 * - added toggle for gamemaker's debug overlay (f10)
 * - added var for changing the selected color. red by default
 * 
 * //description//
 * 
 * use gamemaker's code editor 2 to read comments more easily (if you wanna and arent on lts)
 * 
 * a debug mode intended for use with my undertale/deltarune fangame tutorial series (but should work with most things!)
 * find it at https://youtube.com/@fluffynoelle
 * feel free to use or modify in other projects with credit ofc!
 * 
 * some keybind choices were made with having a numpad in mind (vk_multiply, vk_divide, vk_plus),
 * so if your keyboad doesnt have those keys feel free to adust as needed
 * 
 * ~~~~~
 * 
 * how to use!
 * 
 * make sure this obj is in your starting room with visible and persistent both checked to true
 * and named obj_debug (unless you wanna change what its referred to as in the draw event)
 * same as above for the center obj if you're using that and dont have it already
 * make sure to change variable names below where indicated
 * add code to disable your mouse controls using the debug switch if applicable
 * other than that it should work out of the box :]
 * 
 * -room nav-
 * *page up* key moves room index up 1
 * *page down* key does down 1
 * 
 * -unstuck-
 * sometimes you might get stuck so pressing the *home* key will put you in the center of the screen (think *home*stuck)
 * if you are still stuck after that you can press the *end* key and it will place you to the first position that isnt a collider below the mainchara
 * you can also use the next function to become unstuck
 * 
 * -obj mover/deleter-
 * you can hold the *left mouse button* while hovering the cursor over an obj to move it (this doesnt work on tile or asset layers)
 * press *delete* after selecting (clicking or pressing *alt* on) an obj to delete it
 * press *alt* to lock/unlock all control to/from the selected (hovered over) obj
 * 
 * -obj spawner-
 * pressing the *add* key on the numpad will bring up/put away the spawning menu
 * the obj list is in alphabetical order
 * navigate up an down the list by pressing the *divide* key to go up and *multiply* key to go down (both on numpad)
 * a preview of the selected obj's spr will show next to the text (even if that sprite normally doesnt show)
 * press your select button (default *z* or *enter*) to spawn the obj at the center of your screen
 * 
 * -obj highlighter-
 * press *left control* to draw a red box around the obj closest to the mouse (the one that clicking will move/delete)
 * or that has been locked in with *alt*. it will also highlight the most recent obj that has been spawned
 * it will display in the top left of the screen the name of the obj of the selected obj and the spr name in parentheses
 * and if an obj has been spawned in, it will dispay the name of the obj and spr of the most recent one spawned below that
 * 
 * -debug switch-
 * if you want you can change the global.use_debug_switch to true so that you can toggle all debug functions with *right control*
 * may be useful if your game already has mouse actions you dont want the debug mode to interfere with
 * while this can be used to turn off the debug functions, it's up to you to implement turning off your other mouse functions using global.use_debug_switch
 * 
 * -ignore list-
 * if you want to ignore certain objs, you can add or remove them from the ignore array in the variables
 * the center, debug, and collider objs are all ignored by default
 * these objs can still be spawned in, you just cant move or delete them which might be convenient in some cases
 * 
 * -gamemaker's debug overlay-
 * press *f10* to turn on/off the built-in debug overlay
 * is useful for seeing sounds, performance, checking variables and console output, and some other things
 * read more here: https://manual.gamemaker.io/monthly/en/GameMaker_Language/GML_Reference/Debugging/The_Debug_Overlay.htm
 * 
 */

//variables you shouldnt change
obj = noone //selected obj
obj_nearest = noone //nearest obj
lock = false //lock selection
show_obj_bounds = false //show boxes around the nearest obj and most recently spawned obj
spawn = false //spawn menu is open
obj_spawn = noone //the obj to spawn (idex)
obj_spawn_real = noone //the obj to spawn (actual obj reference)
selected = 0 //which item is selected in spawn menu
total = 1000 //total number of objs in project (will automaticially subtract what isnt actually in the project, so its ideal to keep it much higher than the actual number to not need to worry about changing it when you add new items)
selectable = [] //array that tracks all selectable objs
smallest = noone //the variable that keeps track of the obj with the smallest dist to the mouse

//the for loop that removes what indices arent used from total
for(var i = 0; i < total; i++){
    if object_get_name(i+1) = "<undefined>"{
        total = i
    }
}

//variables you can change (but dont gotta!)
image_speed = 0.1 //sprite preview image speed (1 = 30fps)
spr_alpha = 0.75 //the transparancy to draw the sprite preview with (1 = 100%)
spr_color = c_white //the color to draw the sprite preview in (white = normal); hex codes accepted
debug_warning = false //when true will print a debug message in the output if this obj exists in your game, even if all other functions are off: useful if you don't trust yourself to remove the obj for the final game release
debug_warning_popup = false //will show a popup when your game ends displaying the message rather than in the output
warning_message = "Warning! Your obj_debug remains in your game for anyone to use! Please stop it from spawning to prevent unauthorized access to debug mode!" //the warning message
depth = -999999 //the depth of the debug obj
db_col = c_red //the color of selected stuff using this debug system. can be whatever, but to me red is the color of debug

//---important---//

//---must change if your project differs from how i do my tutorials!---//
mainchara_obj = obj_mainchara //mainchara obj
mainchara_layer = "mainchara" //the name of the layer you use for your mainchara character
collider_obj = obj_collider //name of the collision obj you use (if any)
selectbuttonpressed = false //this checks if the select button has been pressed
selectbutton = ord("Z") //the select button
global.use_debug_switch = true //use the debug switch or not
activated = true //keeps track of if system should actually do anything or not (default true: change to false if you dont wanna start in debug mode)
ignore = [center, obj_debug, collider_obj] //objects that can't be affected by the debug system