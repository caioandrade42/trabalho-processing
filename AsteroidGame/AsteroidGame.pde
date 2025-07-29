Spaceship spaceship;
AsteroidsBuffer asteroidsBuffer;
BulletsBuffer bulletsBuffer;
int score = 0;
int level = 1;
int lifes = 3;
boolean respawning = false;
float deathTime;
GameState state = GameState.Start;

final int FONT_SIZE = 64;

String[] startMenuText = {
  "Asteroid Game",
  "Press Space to Play"
};

String[] gameOverMenuText = {
  "Asteroid Game",
  "Score: " + score,
  "Press Space to Play"
};

void setup(){
  fullScreen();
  spaceship = new Spaceship();
  asteroidsBuffer = new AsteroidsBuffer(50);
  bulletsBuffer = new BulletsBuffer(10);
  textSize(FONT_SIZE);
  background(0);
}

void draw(){
  background(0);
  switch(state){
    case Start:
      startMenu();
      break;
    case Playing:
      playGame();
      break;
    case GameOver:
      gameOver();
      break;
  }
  
}

void startMenu(){
  drawText(CENTER, width * 0.5, height * 0.5 - FONT_SIZE, startMenuText);

  if(KeyboardListener.checkKey(32)){
    reset();
  }
}

void drawText(int textAlignX, float originX, float originY, String[] lines) {
  textAlign(textAlignX, TOP);
  float lineHeight = textAscent() + textDescent();
  for (int i = 0; i < lines.length; i++) {
    text(lines[i], originX, originY + i * lineHeight);
  }
}


void playGame(){
  if(lifes < 0){
    state = GameState.GameOver;
    return;
  }

  checkLevelClear();

  checkCollisionAsteroidWithBullet();
  if(!respawning){
    if(checkCollisionAsteroidWithSpaceship()){
      lifes--;
      respawning = true;
      deathTime = millis();
      spaceship.explode();
    }
    if(KeyboardListener.checkKey(32)){
      PVector pos = spaceship.getPosition();
      bulletsBuffer.generateBullet(pos.x, pos.y, spaceship.getAngle());
    }
    spaceship.control();
  }else if(millis() - deathTime > 5000){
    spaceship.reset();
    respawning = false; 
  }

  asteroidsBuffer.draw();
  bulletsBuffer.draw();

  spaceship.draw();
  
  drawUI();
}

void gameOver(){
  gameOverMenuText[1] = "Score: " + score;
  drawText(CENTER, width * 0.5, height * 0.5 - FONT_SIZE, gameOverMenuText);
  if(KeyboardListener.checkKey(32)){
    reset();
  }
}

void reset(){
  state = GameState.Playing;
  lifes = 3;
  level = 1;
  score = 0;
  asteroidsBuffer.clear();
  bulletsBuffer.clear();
  spaceship.smoke.clear();
  spaceship.explosion.clear();
  spaceship.reset();
  respawning = false; 
}

void checkLevelClear(){
  for(Asteroid asteroid : asteroidsBuffer.getBuffer()){
    if(asteroid.active) return;
  }
  level++;
  generateStartAsteroids();
}

void generateStartAsteroids(){
  for(int i = 0; i < min(15, level * 4); i++){
    float x;
    float y;
    do{
      x = random(0, width);
      y = random(0, height);
    }while(dist(x, y, spaceship.getPosition().x, spaceship.getPosition().y) < 150);
    asteroidsBuffer.generateAsteroid(x, y, random(10, 50));
  }
}

void checkCollisionAsteroidWithBullet(){
  for(Asteroid asteroid : asteroidsBuffer.getBuffer()){
    if(!asteroid.active) continue;
    for(Bullet bullet : bulletsBuffer.getBuffer()){
      if(!bullet.active) continue;
      PVector pos = bullet.getPosition();
      if(CollisionUtils.pointInsideShape(asteroid.shape, asteroid.getPosition(), pos.x, pos.y)){
        asteroid.active = false;
        bullet.active = false;
        score += asteroid.getRadius() * (level * random(5, 10));
        if(asteroid.getRadius() > 17){
          int childAsteroids = (int)random(2, 4);
          float newRadius = max(14, asteroid.getRadius() / 2);
          for(int i = 0; i < childAsteroids; i++){
            asteroidsBuffer.generateAsteroid(asteroid.getPosition().x, asteroid.getPosition().y, newRadius);
          }
        }
      }
    }
  }
}

boolean checkCollisionAsteroidWithSpaceship(){
  if(respawning) return false;
  for(Asteroid asteroid : asteroidsBuffer.getBuffer()){
    if(!asteroid.active) continue;
    int count = asteroid.shape.getVertexCount();

    for (int i = 0; i < spaceship.transformedVerts.length; i++) {
      PVector s1 = spaceship.transformedVerts[i];
      PVector s2 = spaceship.transformedVerts[(i + 1) % spaceship.transformedVerts.length];
  
      for (int j = 0; j < count; j++) {
        PVector a1 = asteroid.shape.getVertex(j).copy().add(asteroid.pos);
        PVector a2 = asteroid.shape.getVertex((j + 1) % count).copy().add(asteroid.pos);
          
        if (CollisionUtils.linesIntersect(s1, s2, a1, a2)) return true;
      }
    }
  }
  return false;
}

void drawUI(){
  textAlign(LEFT, TOP);
  text("Score: " + score, 20, 20);
  for (int i = 0; i < lifes; i++) {
    pushMatrix();
    translate((20 + 40) * i + 40, 120);
    rotate(-HALF_PI);
    scale(1.5);
    shape(spaceship.shipShape);
    popMatrix();
  }
}

void keyPressed(){
  KeyboardListener.addKey(keyCode);
  
}

void keyReleased(){
  KeyboardListener.removeKey(keyCode);
}
