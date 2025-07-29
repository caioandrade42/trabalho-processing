import processing.sound.*;
SoundFile base;
SoundFile bateuEsquerda;
SoundFile bateuDireita;
SoundFile ponto;

PImage crash;

bola bola; 

barra barraEsquerda;
barra barraDireita;

int placarEsquerda = 0;
int placardireita = 0;

void setup(){
  crash = loadImage("pong.png");
  fullScreen();  
  bola = new bola(width/2, height/2, 50);
  setaVelocidade();
  
  // Tenta carregar os arquivos de som com tratamento de erro
  try {
    base = new SoundFile(this, "026491_pixel-song-8-72675.mp3");
    bateuEsquerda = new SoundFile(this, "bateuesquerdo.mp3");
    bateuDireita = new SoundFile(this, "bateudireita.mp3");
    ponto = new SoundFile(this,"cute-level-up-3-189853.mp3");
    
    // Testa se o áudio funciona
    if (base != null) {
      base.play();
    }
  } catch (Exception e) {
    println("Aviso: Não foi possível carregar os arquivos de áudio. O jogo continuará sem som.");
    println("Erro: " + e.getMessage());
  }
  
  barraEsquerda = new barra(15, height/2, 30,200);
  barraDireita = new barra(width-15, height/2, 30,200);

}

void draw(){
  background(0);
  image(crash,(width/2)-100,0,200,200);
  bola.move();
  bola.display();
  
  barraEsquerda.move();
  barraEsquerda.display();
  barraDireita.move();
  barraDireita.display();

  
  if (bola.direita() > width) {
    playSafely(base, true); // para e toca
    playSafely(ponto, false); // só toca
    setaVelocidade();
    placarEsquerda = placarEsquerda + 1;
    bola.x = width/2;
    bola.y = height/2;
  }
  if (bola.Esquerda() < 0) {
    playSafely(base, true); // para e toca
    playSafely(ponto, false); // só toca
    setaVelocidade();
    placardireita = placardireita + 1;
    bola.x = width/2;
    bola.y = height/2;
  }

  if (bola.inferior() > height) {
    bola.velocidadeY *= -1;
  }

  if (bola.topo() < 0) {
    bola.velocidadeY *= -1;
  }
  
  if (barraEsquerda.inferior() > height) {
    barraEsquerda.y = height-barraEsquerda.h/2;
  }

  if (barraEsquerda.topo() < 0) {
    barraEsquerda.y = barraEsquerda.h/2;
  }
    
  if (barraDireita.inferior() > height) {
    barraDireita.y = height-barraDireita.h/2;
  }

  if (barraDireita.topo() < 0) {
    barraDireita.y = barraDireita.h/2;
  }
  if ( bola.Esquerda() < barraEsquerda.direita() && bola.y > barraEsquerda.topo() && bola.y < barraEsquerda.inferior()){
    bola.velocidadeX = (bola.velocidadeX*1.1)* -1;
    bola.velocidadeY = map(bola.y - barraEsquerda.y, -barraEsquerda.h/2, barraEsquerda.h/2, -10, 10);
    playSafely(bateuEsquerda, false);
  }

  if ( bola.direita() > barraDireita.esquerda() && bola.y > barraDireita.topo() && bola.y < barraDireita.inferior()) {
    bola.velocidadeX = (bola.velocidadeX*1.1)* -1;
    bola.velocidadeY = map(bola.y - barraDireita.y, -barraDireita.h/2, barraDireita.h/2, -10, 10);
    playSafely(bateuDireita, false);
  } 
  
  textSize(40);
  textAlign(CENTER);
  text(placardireita, width/2+30, 30);
  text(placarEsquerda, width/2-30, 30); 
}

void keyPressed(){
  if(bola.velocidadeX>0){
    if(keyCode == UP){
    barraDireita.velocidadeY=-(bola.velocidadeX-1);
  }
  if(keyCode == DOWN){
    barraDireita.velocidadeY=bola.velocidadeX-1;
  }
  if(key == 'a'){
    barraEsquerda.velocidadeY=-(bola.velocidadeX-1);
  }
  if(key == 'z'){
    barraEsquerda.velocidadeY=bola.velocidadeX-1;
  }
  }
  if(bola.velocidadeX<0){
    if(keyCode == UP){
    barraDireita.velocidadeY=bola.velocidadeX-1;
  }
  if(keyCode == DOWN){
    barraDireita.velocidadeY=-(bola.velocidadeX-1);
  }
  if(key == 'a'){
    barraEsquerda.velocidadeY=bola.velocidadeX-1;
  }
  if(key == 'z'){
    barraEsquerda.velocidadeY=-(bola.velocidadeX-1);
  }
  }
}

void keyReleased(){
  if(keyCode == UP){
    barraDireita.velocidadeY=0;
  }
  if(keyCode == DOWN){
    barraDireita.velocidadeY=0;
  }
  if(key == 'a'){
    barraEsquerda.velocidadeY=0;
  }
  if(key == 'z'){
    barraEsquerda.velocidadeY=0;
  }
}


void mousePressed(){
  reset();
}

void setaVelocidade(){
    float velocidade = random(0,1);    
   if(velocidade>0.5){
     bola.velocidadeX = 5;
     bola.velocidadeY = 5;
   }
   if(velocidade<0.5){
     bola.velocidadeX = -5;
     bola.velocidadeY = -5;
   }
}

void reset() {
  placardireita=0;
  placarEsquerda=0;
  bola.x = width/2;
  bola.y = height/2;
  setaVelocidade();
  playSafely(base, true); // para e toca
}

// Função auxiliar para tocar sons com segurança
void playSafely(SoundFile sound, boolean stopFirst) {
  try {
    if (sound != null) {
      if (stopFirst) {
        sound.stop();
      }
      sound.play();
    }
  } catch (Exception e) {
    // Ignora erros de áudio silenciosamente para não interromper o jogo
  }
}
