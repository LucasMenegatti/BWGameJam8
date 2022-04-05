/// @description Insert description here
// You can write your code in this editor

// Parede esquerda
if(x<128){
	if(y<128){
		image_index = 0;
	} else if(y>=128&&y<room_height-128){
		image_index = 1;
	} else {
		image_index = 2;	
	}
}

// Parede baixo e cima
if(x>=128&&x<room_width-128){
	if(y<room_height/2) {
		image_index = 3;
	} else {
		image_index = 4;
	}
}

// Paredes da direita
if(x>=room_width-128){
	if(y<128){
		image_index = 5;
	} else if(y>=128&&y<room_height-128){
		image_index = 6;
	} else {
		image_index = 7;	
	}
}