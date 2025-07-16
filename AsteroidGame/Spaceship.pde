class Spaceship extends Entity {

  Spaceship() {
    super();
    pos.x = width / 2;
    pos.y = height / 2;
    acc = new PVector();
  }

  void draw() {
    move();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    noFill();
    stroke(255);
    triangle(-10, -10, 10, 0, -10, 10);
    popMatrix();
    speed = max(0, speed - 0.025);
  }

  void control() {
    if (KeyboardListener.checkKey(RIGHT)) angle += 0.1;
    if (KeyboardListener.checkKey(LEFT))  angle -= 0.1;

    if (KeyboardListener.checkKey(UP))    speed = min(3.5, speed + 0.1);
    if (KeyboardListener.checkKey(DOWN))  speed = max(0, speed - 0.1);
  }
}
