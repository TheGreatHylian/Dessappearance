if instance_exists(obj_mainchara) and global.party_exists = true and instance_exists(global.party_member_1) and instance_exists(global.party_member_2){
	
	if(global.party_member_1.y < global.party_member_2.y and global.party_member_2.y < obj_mainchara.y){
		global.party_member_1.depth = obj_mainchara.depth +2
		global.party_member_2.depth = obj_mainchara.depth +1
	}
	if(global.party_member_2.y < global.party_member_1.y and global.party_member_1.y < obj_mainchara.y){
		global.party_member_1.depth = obj_mainchara.depth +1
		global.party_member_2.depth = obj_mainchara.depth +2
	}
	if(global.party_member_2.y < obj_mainchara.y and obj_mainchara.y < global.party_member_1.y){
		global.party_member_2.depth = obj_mainchara.depth +1
		global.party_member_1.depth = obj_mainchara.depth -1
	}
	if(global.party_member_1.y < obj_mainchara.y and obj_mainchara.y < global.party_member_2.y){
		global.party_member_1.depth = obj_mainchara.depth +1;
		global.party_member_2.depth = obj_mainchara.depth -1;
	}
	if(obj_mainchara.y < global.party_member_2.y and global.party_member_2.y < global.party_member_1.y){
		global.party_member_1.depth = obj_mainchara.depth -2;
		global.party_member_2.depth = obj_mainchara.depth -1;
	}
	if(obj_mainchara.y < global.party_member_1.y and global.party_member_1.y < global.party_member_2.y){
		global.party_member_1.depth = obj_mainchara.depth -1;
		global.party_member_2.depth = obj_mainchara.depth -2;
	}
	
}