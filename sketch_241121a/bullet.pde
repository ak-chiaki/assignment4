class Bullet {
  float x, y;
  float speed;
  float r = 5; 
  boolean active = false;

  void move() {
    x += speed;
  }

  void display() {
    fill(173, 216, 230);
    noStroke();
    ellipse(x, y, r*2, r*2);
  }
}
