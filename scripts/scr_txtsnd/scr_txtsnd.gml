function scr_txtsnd(txtsnd = snd_txt, pitchmod = 1){
    
    snd = txtsnd
    pitch = 1
    
    //random sound code
    switch txtsnd{ //vales and most of the random selction process taken from undertale and deltarune's code
    	
        case snd_txtger: //gerson--------------------
            pitch = choose(1, 1, 1 - random(0.2))
            snd_stop(snd)
            break
        case snd_tv_voice_short: //tenna--------------------
            pitch = 0.86 + random(0.35)
            
            //random blip
            var blip1 = "snd_tv_voice_short"
            var rand1 = irandom_range(1, 9)
            snd = asset_get_index(blip1)
            
            if rand1 > 1{
                blip1 += $"_{rand1}"
                snd = asset_get_index(blip1)
            }
            
            //stop snd for all possible blips
            snd_stop(snd_tv_voice_short)
            snd_stop(snd_tv_voice_short_2)
            snd_stop(snd_tv_voice_short_3)
            snd_stop(snd_tv_voice_short_4)
            snd_stop(snd_tv_voice_short_5)
            snd_stop(snd_tv_voice_short_6)
            snd_stop(snd_tv_voice_short_7)
            snd_stop(snd_tv_voice_short_8)
            snd_stop(snd_tv_voice_short_9)
            break
        case snd_wngdng1: //gaster--------------------
            var blip2 = "snd_wngdng"
            var rand2 = irandom_range(1, 7)
            blip2 += $"{rand2}"
            snd = asset_get_index(blip2)
            
            //stop snd for all possible blips
            snd_stop(snd_wngdng1)
            snd_stop(snd_wngdng2)
            snd_stop(snd_wngdng3)
            snd_stop(snd_wngdng4)
            snd_stop(snd_wngdng5)
            snd_stop(snd_wngdng6)
            snd_stop(snd_wngdng7)
            break
        case snd_mtt1: //mettaton--------------------
            var blip3 = "snd_mtt"
            var rand3 = irandom_range(1, 9)
            blip3 += $"{rand3}"
            snd = asset_get_index(blip3)
            
            //stop snd for all possible blips
            snd_stop(snd_mtt1)
            snd_stop(snd_mtt2)
            snd_stop(snd_mtt3)
            snd_stop(snd_mtt4)
            snd_stop(snd_mtt5)
            snd_stop(snd_mtt6)
            snd_stop(snd_mtt7)
            break
        case snd_tem: //temmie--------------------
            var blip4 = "snd_tem"
            var rand4 = irandom_range(1, 6)
            snd = asset_get_index(blip4)
            
            if rand4 > 1{
                blip4 += $"{rand4}"
                snd = asset_get_index(blip4)
            }
            
            //stop snd for all possible blips
            snd_stop(snd_tem)
            snd_stop(snd_tem2)
            snd_stop(snd_tem3)
            snd_stop(snd_tem4)
            snd_stop(snd_tem5)
            snd_stop(snd_tem6)
        
    }
    
    pitch *= pitchmod
    scr_snd(snd, pitch)
    
}