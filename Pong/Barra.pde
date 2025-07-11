class barra{
  float x;
  float y;
  float w;
  float h;
  float velocidadeY;
  float velocidadeX;
  color c;
  
  barra(float tempX, float tempY, float tempW, float tempH){
    x = tempX;
    y = tempY;
    w = tempW;
    h = tempH;
    velocidadeY = 0;
    velocidadeX = 0;
    c=(255);
  }

  void move(){
    y += velocidadeY;
    x += velocidadeX;
  }

  void display(){
    fill(c);
    rect(x-w/2,y-h/2,w,h);
  } 
  
  //detectar colisao
  float esquerda(){
    return x-w/2;
  }
  float direita(){
    return x+w/2;
  }
  float topo(){
    return y-h/2;
  }
  float inferior(){
    return y+h/2;
  }
}
