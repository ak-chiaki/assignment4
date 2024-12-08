class Plane {
  PVector position; 
  PVector velocity; 
  PVector acceleration; 
  float r;     

  Plane(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    r = 20;
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    position.add(velocity);

    acceleration.mult(0);
  }
  
  void display() {
    fill(127);
    noStroke();
    ellipse(position.x, position.y, r*2, r*2);
  }
}
