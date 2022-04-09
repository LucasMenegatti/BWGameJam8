/// @description Insert description here

#region ================================== VARIÁVEIS GERAIS (PODE ALTERAR) ==================================
	shake = 4; // Força da vibração da tela
#endregion
#region  ============================================== MÉTODOS ==============================================
	tremer = function() {
		view_xport[0] = random_range(-shake,shake);
		view_yport[0] = random_range(-shake,shake);
	
		shake *= .98;
	
		if(shake < .5) instance_destroy()
	}
#endregion