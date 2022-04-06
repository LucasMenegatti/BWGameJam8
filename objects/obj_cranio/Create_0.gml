/// @description Insert description here

#region ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
	tempo_minimo_de_giro				= 1;  // Tempo mínimo em que o cranio fica girando, dado em 1/4 de segundo (Será escolhido aleatoriamente um número entre estes dois parâmetros)
	tempo_maximo_de_giro				= 2;  // Tempo máximo em que o cranio fica girando, dado em 1/4 de segundo
	
	grau_minimo							= -8; // Minimo de quantos graus a imagem do crânio vai ser incrementada cada frame
	grau_maximo							= 8;  // Máximo de quantos graus a imagem do crânio vai ser incrementada cada frame
	
	velocidade_minima_inicial_cranio	= 2;  // Velocidade inicial minima do cranio
	velocidade_maxima_inicial_cranio	= 4;  // Velocidade inicial máxima do cranio
	
	tempo_some							= 2;  // Tempo em segundos para o crânio começar a sumir
#endregion
#region ================================ VARIÁVEIS DE CONTROLE (NÃO ALTERAR) ================================
	tempo_de_giro = (room_speed/4)*random_range(tempo_minimo_de_giro,tempo_maximo_de_giro);
	graus_de_giro = irandom_range(grau_minimo,grau_maximo);

	vspeed = random_range(velocidade_minima_inicial_cranio,velocidade_maxima_inicial_cranio);
	hspeed = random_range(velocidade_minima_inicial_cranio,velocidade_maxima_inicial_cranio);
	
	tempo_comeca_sumir = room_speed*tempo_some;
#endregion
#region  ============================================== MÉTODOS ==============================================
	girar_e_mover = function() {
		if(tempo_de_giro>0){
		image_angle += graus_de_giro;
		tempo_de_giro--;
		}
		if(hspeed>0){
		   hspeed *= .90
		   vspeed *= .90
		} else {
			hspeed = 0;
			vspeed = 0;
		}
	}

	sumir_com_tempo = function() {
		tempo_comeca_sumir--;
		if(tempo_comeca_sumir<=0) {
			image_alpha *= .97;
		}
		if(image_alpha <= .05){
			instance_destroy();
		}
	}
#endregion