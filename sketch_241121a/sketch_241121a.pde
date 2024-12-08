// Kiro Liu Assignment4

Plane plane;

void setup() {
  size(400, 400);
  plane = new Plane(100, height);
}

void draw() {
 background(255);
 playControl();
  plane.update();
  plane.display();
  positionControl();

}

void playControl(){
    if (mousePressed) {
    plane.applyForce(new PVector(0, -0.2));
  } else {
    plane.applyForce(new PVector(0, 0.1));
  }
}

void positionControl(){
    if (plane.position.y > height - plane.a) {
    plane.position.y = height - plane.a;
    plane.velocity.y = 0; 
  }
  else if (plane.position.y < 0 ) {
    plane.position.y = 0 ;
     plane.velocity.y = 0; 
  }
}
