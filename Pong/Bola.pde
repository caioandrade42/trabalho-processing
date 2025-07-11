class bola {
  float x;
  float y;
  float velocidadeX;
  float velocidadeY;
  float diametro;
  color c;
  
  bola(float tempX, float tempY, float tempdiametro) {
    x = tempX;
    y = tempY;
    diametro = tempdiametro;
    velocidadeX = 0;
    velocidadeY = 0;
    c = (225); 
  }
  
  void move() {
    // movimento da bola
    y = y + velocidadeY;
    x = x + velocidadeX;
  }
  
  void display() {
    fill(c);
    ellipse(x,y,diametro,diametro);
  }
  
  // detectar de colisao
  float Esquerda(){
    return x-diametro/2;
  }
  float direita(){
    return x+diametro/2;
  }
  float topo(){
    return y-diametro/2;
  }
  float inferior(){
    return y+diametro/2;
  }

}
