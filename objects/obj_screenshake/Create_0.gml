/// @description Insert description here
// You can write your code in this editor

shake = 4;

tremer = function() {
	view_xport[0] = random_range(-shake,shake);
	view_yport[0] = random_range(-shake,shake);
	
	shake *= .98;
	
	if(shake < .5) instance_destroy()
}