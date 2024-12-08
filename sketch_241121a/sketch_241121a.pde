// Kiro Liu Assignment4

Plane plane;

void setup() {
  size(400, 400);
  plane = new Plane(width/2, height-50);
}

void draw() {
  background(255);
  if (mousePressed) {
    plane.applyForce(new PVector(0, -0.2));
  } else {
    plane.applyForce(new PVector(0, 0.1));
  }

  plane.update();
  plane.display();
  
  if (plane.position.y > height - plane.r) {
    plane.position.y = height - plane.r;
    plane.velocity.y = 0; 
  }
  else if (plane.position.y < 0 + plane.r) {
    plane.position.y = 0 + plane.r;
    plane.velocity.y = 0; 
  }
}
