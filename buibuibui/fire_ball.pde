class FireBall {
  float x, y;
  float speed;
  float r = 10; 
  boolean active = false;

  void move() {
    x -= speed;
}

  void display() {
    fill(255, 0, 0);
    noStroke();
    ellipse(x, y, r*2, r*2);
}
}
