import processing.sound.*;
SoundFile sons;

// Cobra
ArrayList<PVector> cobra;
// Posição da comida
PVector comida;
// Direção
PVector direcao;
// Tamanho de cada segmento da cobra (unidade base)
int tamanhoCobra = 20;
// Pontuação do jogador
int pontuacao = 0;
// Estado do jogo
boolean jogando = true;

int tabuleiroLargura = 600;
int tabuleiroAltura = 600;

float escala;
float offsetX, offsetY;
float tamanhoSegmentoReal;
void setup() {
    SoundFile sons = new SoundFile(this, "./data/ai.wav");
    SoundFile sons2 = new SoundFile(this, "./data/comida.wav");
  fullScreen();
  calcularEscala();
  frameRate(10);
  iniciarJogo();
}

void draw() {
  background(0);
  translate(offsetX, offsetY);
  if (!jogando) {
    exibirFimDeJogo();
  } else {
    moverCobra();
    verificarColisoes();
    desenharCobra();
    desenharComida();
    exibirPontuacao();
  }
}

void calcularEscala() {
  escala = min((float)width / tabuleiroLargura, (float)height / tabuleiroAltura);
  tamanhoSegmentoReal = tamanhoCobra * escala;
  offsetX = (width - (tabuleiroLargura * escala)) / 2;
  offsetY = (height - (tabuleiroAltura * escala)) / 2;
}

void iniciarJogo() {
  cobra = new ArrayList<PVector>();
  cobra.add(new PVector(tabuleiroLargura / 2, tabuleiroAltura / 2));
  direcao = new PVector(1, 0);
  posicionarComida();
  pontuacao = 0;
  jogando = true;
}

void moverCobra() {
  PVector novaCabeca = cobra.get(0).copy();
  novaCabeca.x += direcao.x * tamanhoCobra;
  novaCabeca.y += direcao.y * tamanhoCobra;
  
  cobra.add(0, novaCabeca);
  if (dist(novaCabeca.x, novaCabeca.y, comida.x, comida.y) < 1) {
    sons2.play();
    pontuacao++;
    posicionarComida();
  } else {
    cobra.remove(cobra.size() - 1);
  }
}

void verificarColisoes() {
  PVector cabeca = cobra.get(0);
  if (cabeca.x < 0 || cabeca.x >= tabuleiroLargura || cabeca.y < 0 || cabeca.y >= tabuleiroAltura) {
    sons.play();
    jogando = false;
  }
  for (int i = 1; i < cobra.size(); i++) {
    if (cabeca.equals(cobra.get(i))) {
      sons.play();
      jogando = false;
    }
  }
}

void desenharCobra() {
  fill(0, 255, 0);
  noStroke();
  for (PVector segmento : cobra) {
    rect(segmento.x * escala, segmento.y * escala, tamanhoSegmentoReal, tamanhoSegmentoReal);
  }
}

void desenharComida() {
  fill(255, 0, 0);
  rect(comida.x * escala, comida.y * escala, tamanhoSegmentoReal, tamanhoSegmentoReal);
}

void posicionarComida() {
  int cols = tabuleiroLargura / tamanhoCobra;
  int rows = tabuleiroAltura / tamanhoCobra;
  
  comida = new PVector(floor(random(cols)) * tamanhoCobra, 
                       floor(random(rows)) * tamanhoCobra);
}

void exibirPontuacao() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(16 * escala);
  text("Pontuação: " + pontuacao, 10 * escala, 10 * escala);
}

void exibirFimDeJogo() {
  fill(255, 0, 0);
  textAlign(CENTER, CENTER);
  
  textSize(48 * escala);
  text("FIM DE JOGO", tabuleiroLargura * escala / 2, tabuleiroAltura * escala / 2 - (60 * escala));
  
  textSize(32 * escala);
  text("Pontuação: " + pontuacao, tabuleiroLargura * escala / 2, tabuleiroAltura * escala / 2);
  
  textSize(24 * escala);
  text("Pressione 'R' para reiniciar", tabuleiroLargura * escala / 2, tabuleiroAltura * escala / 2 + (60 * escala));
}

void keyPressed() {
  if (jogando) {
    if (key == CODED) {
      if (keyCode == UP && direcao.y == 0) {
        direcao.set(0, -1);
      } else if (keyCode == DOWN && direcao.y == 0) {
        direcao.set(0, 1);
      } else if (keyCode == LEFT && direcao.x == 0) {
        direcao.set(-1, 0);
      } else if (keyCode == RIGHT && direcao.x == 0) {
        direcao.set(1, 0);
      }
    }
  }
  if (!jogando && (key == 'r' || key == 'R')) {
    iniciarJogo();
  }
}