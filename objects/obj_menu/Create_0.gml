//submenu box defaults
box = spr_simplebox
frame = -1

x_off = center.topleft_x
y_off = center.topleft_y

box_top_y = 26
box_bot_y = 84

box_stats_top = box_top_y
box_stats_bot = 161
box_stats_mini_y = box_stats_top

box_left_x = 16
box_right_x = 94

box_left_w = 71
box_right_w = 173

box_stats_mini_h = 55
box_select_h = 74

box_item_h = 181
box_stats_h = 209
box_cell_h = 135

box_right_h = box_item_h //changes based off of what was selected

money_off = 1

//text
name = global.name
lv = 1
hp = 20
hp_max = 20
money = 7
comment = "Since\nChapter 1"
at = 5
weapon_at = 2
df = 4
armor_df = 3
xp = 0
next_lv = 13
wp = global.stats.mainchara.wp
ar = global.stats.mainchara.ar

//select
selected = 0
selected_item = 0
submenu = "select"

soul = spr_soul_menu

soul_x_left = box_left_x + x_off + 16
soul_y_left = box_bot_y + y_off + 18 + (selected * 18)

soul_x_right = box_right_x + x_off + 12
soul_y_right = box_bot_y + y_off + 18 + (selected * 18)

soul_x = soul_x_left
soul_y = soul_y_left

//close
can_close = true
close = false

//has vars
has_item = false
item_color = c_gray
has_cell = global.has_cell
cell_color = c_gray

if array_length(global.inventory) > 0{
    item_color = c_white
    has_item = true
}

if array_length(global.contacts) > 0{
    cell_color = c_white
}