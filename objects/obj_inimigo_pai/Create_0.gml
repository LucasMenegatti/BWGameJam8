/// @description Insert description here
// You can write your code in this editor

#region ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
	vida_maxima					= 9;		// Vida máxima dos inimigos
	
	velocidade_minima			= 1;		// Velocidade mínima do inimigo (Será escolhido aleatoriamente um número entre estes dois parâmetros)
	velocidade_maxima			= 3;		// Velocidade máxima do inimigo
	
	direcao_inicial_minima		= 190;		// Direçao em graus mínima inicial do inimigo (Será escolhido aleatoriamente um número entre estes dois parâmetros)
	direcao_inicial_maxima		= 260;		// Direçao em graus máxima inicial do inimigo

	distancia_detecta			= 800;		// Distancia, em pixels, em que o inimigo passa a seguir o player
	
	altura_barra_vida			= 16;		// Define a altura em pixels da barra de vida dos inimigos
	comprimento_barra_vida		= 24;		// Define o comprimento em pixels da barra de vida dos inimigos
	margem_barra_vida			= 16;		// Define a distância em pixels entre a barra de vida e a parte superior da sprite dos inimigos
	
	anguloMinimoVoltarAoColidir = 120;		// Define qual o ângulo (em graus) minimo para voltar quando bate na parede (Será escolhido aleatoriamente um número entre estes dois parâmetros)
	anguloMaximoVoltarAoColidir = 210;		// Define qual o ângulo (em graus) máximo para voltar quando bate na parede
	
	som_quando_leva_dano		= snd_hit;	// Define qual o som tocar quando o inimigo leva dano
	som_quando_morre			= [snd_d1,	// Define quais são os sons que podem ser tocados ao morrer
								   snd_d2,
								   snd_d3]
#endregion
#region ================================ VARIÁVEIS DE CONTROLE (NÃO ALTERAR) ================================
	vida_atual = vida_maxima;				// Qando o inimigo é criado, sua vida é igual a vida máxima (NÃO MUDAR)
	
	speed = random_range(velocidade_minima,velocidade_maxima);
	direction = irandom_range(direcao_inicial_minima,direcao_inicial_maxima);
	image_angle = direction;
	
	espessura_parede = 128/2.8;
	
	areaUtilDaRoom_x1 = sprite_width/2+espessura_parede;
	areaUtilDaRoom_y1 = sprite_height/2+espessura_parede;
	areaUtilDaRoom_x2 = room_width-sprite_width/2-espessura_parede;
	areaUtilDaRoom_y2 = room_height-sprite_height/2-espessura_parede;
	
#endregion
#region ======================================= FUNÇÕES ATIVAS NO STEP =======================================
	ativasNoStep = function() {
		colidiuParede();
		seguirPlayer();
		levaDano();
	}
#endregion
#region ======================================= FUNÇÕES ATIVAS NO DRAW =======================================
	ativasNoDraw = function() {
		draw_self();
		desenhaVida();
	}
#endregion
#region  ============================================== MÉTODOS ==============================================
	colidiuParede = function() {
		if(x<=areaUtilDaRoom_x1||x>=areaUtilDaRoom_x2||y<=areaUtilDaRoom_y1||y>=areaUtilDaRoom_y2) {
			direction += irandom_range(anguloMinimoVoltarAoColidir,anguloMaximoVoltarAoColidir);
			image_angle = direction;
		}
	}

	seguirPlayer = function() {
		if(instance_exists(obj_player)){
			if(point_distance(x,y,obj_player.x,obj_player.y)<distancia_detecta){
				direction = point_direction(x,y,obj_player.x,obj_player.y);
				image_angle = direction;
			}
		}
	}

	levaDano = function() {
		var _idTiro = instance_place(x,y,obj_tiro);			// Verifica a colisão com um tiro
		if(_idTiro){
			instance_destroy(_idTiro);						// Destroi o tiro que colidiu com o chefão
			_idTiro = noone;								// Reseta a variável que tinha o id do tiro
			vida_atual--;									// Diminui a vida do chefão
			audio_play_sound(som_quando_leva_dano,2,false); // Toca o som de levar dano
		}
		if(vida_atual <=0){									// Se a vida do chefão chegar a zero
			morte_inimigo();								// Chama o evento morte chefao
		}
	}
	
	morte_inimigo = function() {
		gera_sangue();
		dropa_cranio();
		toca_som_morte();
		instance_destroy();
	}
	#region MÉTODOS PARA O MÉTODO morte_inimigo()
		// Desenha o efeito de sangue na surface
		gera_sangue = function() {
			if(instance_exists(obj_surface)){
				repeat(irandom_range(5,25))
				{
					instance_create_layer(x, y, layer,obj_sangue);
				}
			}
		}
		
		// Dropa o item crânio
		dropa_cranio = function() {
			instance_create_layer(x,y,"cranios",obj_cranio);
		}
	
		// Toca o som de morte
		toca_som_morte = function() {
			audio_play_sound(som_quando_morre[irandom(array_length(som_quando_morre)-1)],2,false);
		}
	#endregion
#endregion
#region EVENTOS DE DRAW
	desenhaVida = function() {
		x1 = x-sprite_width/2-(comprimento_barra_vida/2);
		y1 = y-sprite_height/2-(margem_barra_vida+altura_barra_vida);
		x2 = x+sprite_width/2+(comprimento_barra_vida/2);
		y2 = y-sprite_height/2-margem_barra_vida;
		draw_healthbar(x1,y1,x2,y2,(vida_atual/vida_maxima)*100, c_black, c_black, c_black, 0, 0, 0);
	}
#endregion