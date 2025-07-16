Spaceship s;
AsteroidsBuffer asteroidsBuffer;
BulletsBuffer bulletsBuffer;
int score = 0;
int level = 1;

void setup(){
  size(800, 600);
  s = new Spaceship();
  asteroidsBuffer = new AsteroidsBuffer();
  bulletsBuffer = new BulletsBuffer();
  for(int i = 0; i < 4; i++){
    asteroidsBuffer.generateAsteroid(random(10, 50));
  }
  textAlign(LEFT, TOP);
  textSize(48);
}

void draw(){
  checkLevelClear();
  background(0);

  s.control();

  asteroidsBuffer.draw();
  bulletsBuffer.draw();
  if(KeyboardListener.checkKey(32)){
    PVector pos = s.getPosition();
    bulletsBuffer.generateBullet(pos.x, pos.y, s.getAngle());
  }
  
  checkCollision();

  s.draw();
  
  stroke(255);
  text(score, 20, 20);
}

void checkLevelClear(){
  for(Asteroid asteroid : asteroidsBuffer.getBuffer()){
    if(asteroid.active) return;
  }
  level++;
  
  for(int i = 0; i < min(15, level * 4); i++){
    asteroidsBuffer.generateAsteroid(random(10, 50));
  }
  
}

void checkCollision(){
  for(Asteroid asteroid : asteroidsBuffer.getBuffer()){
    if(!asteroid.active) continue;
    for(Bullet bullet : bulletsBuffer.getBuffer()){
      if(!bullet.active) continue;
      PVector pos = bullet.getPosition();
      if(asteroid.pointInsideShape(pos.x, pos.y)){
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

void keyPressed(){
  KeyboardListener.addKey(keyCode);
  
}

void keyReleased(){
  KeyboardListener.removeKey(keyCode);
}
