Spaceship spaceship;
AsteroidsBuffer asteroidsBuffer;
BulletsBuffer bulletsBuffer;
int score = 0;
int level = 1;
int lifes = 3;
boolean respawning = false;
float deathTime;

void setup(){
  size(800, 600);
  spaceship = new Spaceship();
  asteroidsBuffer = new AsteroidsBuffer();
  bulletsBuffer = new BulletsBuffer();
  generateStartAsteroids();
  textAlign(LEFT, TOP);
  textSize(48);
}

void draw(){
  checkLevelClear();
  background(0);

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
  text(score, 10, 10);
  for (int i = 0; i < lifes; i++) {
    pushMatrix();
    translate((20 + 10) * i + 20, 70);
    rotate(-HALF_PI);
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
