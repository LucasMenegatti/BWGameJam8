/// @description Insert description here
// You can write your code in this editor
#region ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
	tempo_minimo_aberto = 1; // Tempo em segundos mínimo que a porta fica aberta (Será escolhido aleatoriamente um número entre estes dois parâmetros)
	tempo_maximo_aberto = 5; // Tempo em segundos máximo que a porta fica aberta
#endregion
#region ================================ VARIÁVEIS DE CONTROLE (NÃO ALTERAR) ================================
	tempo_porta_aberta = room_speed*irandom_range(tempo_minimo_aberto,tempo_maximo_aberto);
	contador_porta_aberta = tempo_porta_aberta;
	portaDoPlayer = false;
#endregion
#region  ============================================== MÉTODOS ==============================================
	fechaPorta = function() {
		if(image_index==1){
			contador_porta_aberta--;
			if(contador_porta_aberta <= 0){
				image_index=0;
				contador_porta_aberta = room_speed*irandom_range(tempo_minimo_aberto,tempo_maximo_aberto);
			}
		}
	}
#endregion