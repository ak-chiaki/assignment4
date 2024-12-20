class Plane {
  PVector position; 
  PVector velocity; 
  PVector acceleration; 
  int a;  //this varible help check the size of the plane when test plane if exceed the screen

  Plane(int x, int y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    a = 40;
}

   void applyForce(PVector force) { //applyforce on the plane
     acceleration.add(force);
}

  void move() {  //make the plane moveable
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
}
  
  void display() { //draw the plane
    fill(127);
    noStroke();
    triangle(position.x, position.y,position.x+10, position.y+10,position.x+10, position.y+30);
    triangle(position.x, position.y,position.x+10, position.y+30,position.x-10, position.y);
    quad(position.x+10, position.y+10,position.x+70, position.y+10,position.x+70, position.y+30,position.x+10, position.y+30);
    ellipse(position.x+70, position.y+20,20,20);
    quad(position.x+40, position.y+20,position.x+50, position.y+20,position.x+40, position.y+40,position.x+30, position.y+40);
}
}
