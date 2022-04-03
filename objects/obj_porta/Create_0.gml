/// @description Insert description here
// You can write your code in this editor
tempo_porta_aberta = room_speed*irandom_range(1,5);
contador_porta_aberta = tempo_porta_aberta;

fechaPorta = function() {
	if(image_index==1){
		contador_porta_aberta--;
		if(contador_porta_aberta <= 0){
			image_index=0;
			contador_porta_aberta = room_speed*irandom_range(1,5);
		}
	}
}