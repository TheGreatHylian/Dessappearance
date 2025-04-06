if(place_meeting(x, y, obj_player)){

	ini_open("dessappearance.ini")
	ini_write_string("Save1", "room", room_to_save)
	ini_write_real("Save1", "x", obj_player.x)
	ini_write_real("Save1", "y", obj_player.y)
	ini_write_real("Save1", "facing", obj_player.facing_direction)
	
	if global.party_exists = true{
		
		ini_write_string("Save1", "Party Exists", global.party_exists)
	
		if global.party_member_1 = obj_partyplaceholder1{
			ini_write_real("Save1", "Party1", global.pn1)
		}
	
		if global.party_member_1 = obj_susie{
			ini_write_real("Save1", "Party1", global.p0)
		}
		if global.party_member_1 = obj_kris{
			ini_write_real("Save1", "Party1", global.p1)
		}
		if global.party_member_1 = obj_ralsei{
			ini_write_real("Save1", "Party1", global.p2)
		}
		
		
		if global.party_member_2 = obj_partyplaceholder1{
			ini_write_real("Save1", "Party2", global.pn1)
		}
		
		
		if global.party_member_2 = obj_susie{
			ini_write_real("Save1", "Party2", global.p0)
		}
		if global.party_member_2 = obj_kris{
			ini_write_real("Save1", "Party2", global.p1)
		}
		if global.party_member_2 = obj_ralsei{
			ini_write_real("Save1", "Party2", global.p2)
		}
	
	}
	ini_close()

}