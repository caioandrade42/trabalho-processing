class Spaceship extends Entity {  
  
  Spaceship() {
    super();
    pos.x = width / 2;
    pos.y = height / 2;
    acc = new PVector();
  }

  void draw() {
    pos.add(acc);
    wrapPosition();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    noFill();
    stroke(255);
    triangle(-10, -10, 10, 0, -10, 10);
    popMatrix();
    speed = max(0, speed - 0.28);
    acc.mult(0.998);
    println(acc);
  }

  void control() {
    if (KeyboardListener.checkKey(RIGHT)) angle += 0.05;
    if (KeyboardListener.checkKey(LEFT))  angle -= 0.05;

    if (KeyboardListener.checkKey(UP)){
      speed = min(6, speed + 0.050);
      acc.x += cos(angle) * speed;
      acc.y += sin(angle) * speed;
      float limitSpeed = 2.8;
      acc.x = limitValue(acc.x, -limitSpeed, limitSpeed);
      acc.y = limitValue(acc.y, -limitSpeed, limitSpeed);
    }
  }
  
  float limitValue(float value, float minimum, float maximum){
    return min(max(value, minimum), maximum);
  }
}
