function scr_party(party_member_1, party_member_2, disband){

	if disband = false{
	
		global.party_exists = true
		
		if !instance_exists(party_member_1){
			instance_create_layer(x, y, "Player", party_member_1)
		}
		if !instance_exists(party_member_2){
			instance_create_layer(x, y, "Player", party_member_2)
		}
		
		global.party_member_1 = party_member_1
		global.party_member_2 = party_member_2
		global.party_member_1_follow_distance = 20
		global.party_member_2_follow_distance = 40
		global.party_member_1.inparty = true
		global.party_member_2.inparty = true
	
	} else{
	
		global.party_exists = false
	
	}

}