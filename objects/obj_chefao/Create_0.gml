/// @description Define as funções do chefão

// Herdando o evento do pai
event_inherited();

#region ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
	vida_maxima				= 60;					// Define a vida máxima do chefão

	speed					= 0.5;					// Define a velocidade de movimento do chefão
	
	altura_barra_vida		= 16;					// Define a altura em pixels da barra de vida do chefão
	comprimento_barra_vida	= 128;					// Define o comprimento em pixels da barra de vida do chefão
	margem_barra_vida		= 12;					// Define a distância em pixels entre a barra de vida e a parte superior da sprite do chefão
	
	som_quando_leva_dano	= snd_hit;				// Define qual o som tocar quando o chefão leva dano
	som_quando_morre		= [snd_boss_death];		// Define qual o som tocar quando o chefão morre
#endregion
#region ================================ VARIÁVEIS DE CONTROLE (NÃO ALTERAR) ================================
	vida_atual				= vida_maxima;			// Qando o chefão é criado, sua vida é igual a vida máxima (NÃO MUDAR)
#endregion
#region ======================================= FUNÇÕES ATIVAS NO STEP =======================================
	ativasNoStep = function() {
		colidiuParede();
		levaDano();
		sempreOlharPlayer();
	}
#endregion
#region  ============================================== MÉTODOS ==============================================
// Método para fazer o chefão ficar sempre olhando para o player
	sempreOlharPlayer = function() {
		if(instance_exists(obj_player)){ // Verifica se o player existe
			image_angle = point_direction(x,y, obj_player.x, obj_player.y); // caso o player exista, olha para o player
		}
	}

// Método para o chefão MORRER
	morte_inimigo = function() {
		gera_sangue();
		dropa_cranio();
		toca_som_morte();
		// Informa para o jogo que o chefão não está presente na tela
		global.chefao = false;
		instance_destroy();
	}
#endregion