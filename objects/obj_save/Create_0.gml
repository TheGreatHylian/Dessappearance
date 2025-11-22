room_to_save = global.rm1

//rm0 = test
//rm1 = paps
//rm2 = waterfall

if global.party_exists = true{
	scr_party(global.party_member_1, global.party_member_2, false)
}

//txtbox
box = 0
pos = 1
lines = []

wait = false

timer = 1

newseconds = floor(global.newtime / 1000)
newmins = floor((newseconds + 1) / 60)
newhours = floor((newmins + 1) / 60)

oldseconds = floor(global.oldtime / 1000)
oldmins = floor(oldseconds / 60)
oldhours = floor(oldmins / 60)

totseconds = newseconds + oldseconds
totmins = newmins + oldmins
tothours = newhours + oldhours

while totmins >= 60 and tothours < 999{
	totmins -= 60
}
		
if totmins < 10{
	global.time = string(tothours) + ":0" + string(totmins)
} else{
	global.time = string(tothours) + ":" + string(totmins)
}
		
if tothours >= 999 and totmins >= 59{
	global.time = "999:59"
}