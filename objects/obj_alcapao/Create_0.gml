/// @description Insert description here
// You can write your code in this editor

tocou_som = false;

abre = function(){
	if(global.cranios>=8){
		image_index = 1;
		if(!tocou_som) audio_play_sound(snd_porta_abrindo,10,false)
		tocou_som = true;
	} else {
		image_index = 0;
		tocou_som = false;
	}
}