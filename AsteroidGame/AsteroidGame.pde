Spaceship s;
AsteroidsBuffer asteroidsBuffer;
BulletsBuffer bulletsBuffer;
int score = 0;

void setup(){
  size(800, 600);
  s = new Spaceship();
  asteroidsBuffer = new AsteroidsBuffer();
  bulletsBuffer = new BulletsBuffer();
  for(int i = 0; i < 5; i++){
    asteroidsBuffer.generateAsteroid(random(10, 50));
  }
  textAlign(LEFT, TOP);
  textSize(48);
}

void draw(){
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
  text(score, 0, 0);
}

void checkCollision(){
  for(Asteroid asteroid : asteroidsBuffer.getBuffer()){
    if(!asteroid.ativo) continue;
    for(Bullet bullet : bulletsBuffer.getBuffer()){
      if(!bullet.ativo) continue;
      PVector pos = bullet.getPosition();
      if(asteroid.pointInsideShape(pos.x, pos.y)){
        asteroid.ativo = false;
        bullet.ativo = false;
        score += asteroid.getRadius() * random(10, 20);
        if(asteroid.getRadius() > 17){
          int childAsteroids = (int)random(2, 4);
          float newRadius = asteroid.getRadius()/2;
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
