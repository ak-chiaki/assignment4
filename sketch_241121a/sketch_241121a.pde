// Kiro Liu Assignment4

Plane plane;
int fireballsMAX = 100; 
int bulletsMAX = 200; 
Bullet[] bullets = new Bullet[bulletsMAX];
FireBall[] fireBalls = new FireBall[fireballsMAX];

int bulletNumber = 0; 
int bulletCD = 0; 
int fireBallCount = 0; 
int fireBallCD = 0; 
int score = 0; 
int gamestatus = 1; 

void setup() {
  size(400, 400);
  fill(0,0,200); 
   plane = new Plane(100, height);

  for (int i = 0; i < bulletsMAX; i++) {
    bullets[i] = new Bullet();
  }

  for (int i = 0; i < fireballsMAX; i++) {
    fireBalls[i] = new FireBall();
  }
  
  
}

void draw() {
  background(255);

  if (gamestatus == 1) {
    
      playControl();      
      plane.move();       
      positionControl();  
      bulletsControl();   
      fireBallsControl(); 
      bulletsCollisions(); 
      planeCollisions();  
    
  }

  plane.display(); 
  fill(0);
  text("Score: " + score, 10, 20); 
}


void playControl() {
 
  if (mousePressed) {
    plane.applyForce(new PVector(0, -0.2));
  } 
  else {
    
    plane.applyForce(new PVector(0, 0.1));
    
  }
  
}

void positionControl() {
  if (plane.position.y > height - plane.a) {
     plane.position.y = height - plane.a;
     plane.velocity.y = 0; 
  } else if (plane.position.y < 0) 
  {
     plane.position.y = 0;
     plane.velocity.y = 0; 
  }
  
}

void bulletsControl() {
  if (keyPressed && key == ' ') {
      if (bulletCD == 0) {
         Bullet b = bullets[bulletNumber];
         b.active = true;
         b.x = plane.position.x + 70; 
         b.y = plane.position.y + 20; 
         b.speed = 4; 
         bulletNumber = (bulletNumber + 1) % bulletsMAX;
         bulletCD = 10; 
        } 
           else
           {
           bulletCD--;
           if (bulletCD < 0) {
            bulletCD = 0;
           }
           }
  } else {
    bulletCD = 0;
  }

  for (int i = 0; i < bulletsMAX; i++) {
    if (bullets[i].active) {
      bullets[i].move(); 
      bullets[i].display();
      if (bullets[i].x > width) {
        bullets[i].active = false;
      }
 }
 }
}

void fireBallsControl() {

  if (fireBallCount < fireballsMAX) {
    if (fireBallCD <= 0 && random(1) < 0.4) {
        for (int i = 0; i < fireballsMAX; i++) {
           if (!fireBalls[i].active) {
                fireBalls[i].active = true;
                fireBalls[i].x = width + 10; 
                fireBalls[i].y = random(0, height);
                fireBalls[i].speed = 2; 
                fireBalls[i].r = 10;
                fireBallCount++;
                fireBallCD = 30; 
                break;
     }
   }
  } else {
      fireBallCD--;
 }
}


  for (int i = 0; i < fireballsMAX; i++) {
    if (fireBalls[i].active) {
      fireBalls[i].move(); 
      fireBalls[i].display();
      if (fireBalls[i].x < -fireBalls[i].r) {
        fireBalls[i].active = false;
        fireBallCount--;
  }
 }
}
}

void bulletsCollisions() {

  for (int i = 0; i < bulletsMAX; i++) {
    if (bullets[i].active) {
      for (int j = 0; j < fireballsMAX; j++) {
        if (fireBalls[j].active) {
          float dx = bullets[i].x - fireBalls[j].x;
          float dy = bullets[i].y - fireBalls[j].y;
          float dist = sqrt(dx*dx + dy*dy);
             if (dist < bullets[i].r + fireBalls[j].r) {
              bullets[i].active = false;
              fireBalls[j].active = false;
              fireBallCount--;
              score++;
              break;
            }
  }
  }
  }
  }
}

void planeCollisions() {
  float planeMinX = plane.position.x + 10;
  float planeMaxX = plane.position.x + 70;
  float planeMinY = plane.position.y + 10;
  float planeMaxY = plane.position.y + 30;

  for (int i = 0; i < fireballsMAX; i++) {
    if (fireBalls[i].active) {

      if (fireBalls[i].x > planeMinX && fireBalls[i].x < planeMaxX &&
          fireBalls[i].y > planeMinY && fireBalls[i].y < planeMaxY) {
        gamestatus = 2; 
  }
  }
  }
}

void keyPressed() {
}
