/// @description Insert description here
// You can write your code in this editor


giro = (room_speed/4)*random_range(1,2);
vspeed = random_range(2,4)
hspeed = random_range(2,4)
velocidade_de_giro = irandom_range(-8,8);



girar_e_mover = function() {
	if(giro>0){
	image_angle += velocidade_de_giro;
	giro--;
	}
	if(hspeed>0){
	   hspeed *= .90
	   vspeed *= .90
	} else {
		hspeed = 0;
		vspeed = 0;
	}
}


tempo_comeca_sumir = room_speed*2;

sumir_com_tempo = function() {
	tempo_comeca_sumir--;
	if(tempo_comeca_sumir<=0) {
		image_alpha *= .97;
	}
	if(image_alpha <= .05){
		instance_destroy();
	}
}