   // Kiro Liu Assignment4
Plane plane;
int fireballsMAX = 100; //maximum of the fireballs
int bulletsMAX = 200;  // masimum of the bullets
Bullet[] bullets = new Bullet[bulletsMAX];
FireBall[] fireBalls = new FireBall[fireballsMAX];

int bulletNumber = 0; 
int bulletCD = 0; 
int fireBallCount = 0; 
int fireBallCD = 0; 
int score = 0;          
int gamestatus = 1; //game status control the win and lose

void setup() {
  size(400, 400);
 
   plane = new Plane(100, height);

  for (int i = 0; i < bulletsMAX; i++) {
    bullets[i] = new Bullet();
  }

  for (int i = 0; i < fireballsMAX; i++) {
    fireBalls[i] = new FireBall();        
  }
  
  
}

void draw() {

 background(150,248,255); 
  if (gamestatus == 1) { // when game status = 1, game start.
    
      playControl();      //player's mouse control the movement of plane
      plane.move();         // make plane moveable
      positionControl();    //control the plane always in the screen
      bulletsControl();      //control the movement and generation of the bullets
      fireBallsControl();    //control the movement and generation of the fireballs
      bulletsCollisions();   //check the collisions between the fireballs and bullets
      planeCollisions();    //check the collisions between the fireballs and plane
      plane.display();      //show the plane
  }
  
  if (gamestatus == 2 )
  {
    fill(0);
    textSize(30);
    text("GAMEOVER press A to restart" ,30,200);
    if(keyPressed && key == 'a')
    {
     restartGame();
    }
  }

  //information
  fill(0);
  textSize(30);
  text("Score: " + score, 10, 20); 

}


void restartGame() {
  score = 0;//clean the score

  plane.position.set(100, height); //initialize the position of the plane
  plane.velocity.set(0, 0);
  plane.acceleration.set(0, 0);

  for (int i = 0; i < bulletsMAX; i++) {
    bullets[i].active = false; //initialize all the bullets
  }
  bulletNumber = 0;
  bulletCD = 0;
  
  for (int i = 0; i < fireballsMAX; i++) { //initialize all the fireballs
    fireBalls[i].active = false;
  }

  fireBallCount = 0;
  fireBallCD = 0;
  
  gamestatus = 1; //make game restart
}






void playControl() {
 
  if (mousePressed) {
    plane.applyForce(new PVector(0, -0.2));  //plane goes up when mousepressed
  } 
  else { 
    plane.applyForce(new PVector(0, 0.1));  //plane goes down with velocity when mouse not pressed
  }
}

void positionControl() {
  if (plane.position.y > height - plane.a) {
     plane.position.y = height - plane.a;
     plane.velocity.y = 0;  //when the position of plane exceed the bottom of the screen, make is stop move with velocity 
  } else if (plane.position.y < 0) // //when the position of plane exceed the top of the screen, make is stop move with velocity
  {
     plane.position.y = 0;
     plane.velocity.y = 0; 
  }
  
}

void bulletsControl() {
  if (keyPressed && key == ' ') { // shot bullets when keypressed
      if (bulletCD == 0) {  //When CD = 0, shot a bullet
         Bullet b = bullets[bulletNumber];
         b.active = true; // make the bullet active
         b.x = plane.position.x + 70;  // the position where bullets were generated
         b.y = plane.position.y + 20; 
         b.speed = 4;  //bullets' speed
         bulletNumber = (bulletNumber + 1) % bulletsMAX; // when bulletNumber+1 = the maximum of the bullets, bulletNumber will be give a "0". Then the array can be reusd.
         bulletCD = 10;  //CoodDown of each bullet
        } 
           else
           {
           bulletCD--; // if CD is not zero, count down.
           if (bulletCD < 0) {
            bulletCD = 0; // make sure CD is always equal or more than 0
           }
           }
  } else {
    bulletCD = 0; //reset CD to 0 when key is not pressed
  }

  for (int i = 0; i < bulletsMAX; i++) { //show the "active" bullets
    if (bullets[i].active) {
      bullets[i].move(); 
      bullets[i].display();
      if (bullets[i].x > width) {     //when bullets exceed the screen, clean them.
        bullets[i].active = false;
      }
 }
 }
}

void fireBallsControl() {
  if (fireBallCount < fireballsMAX) {  
    if (fireBallCD <= 0) {             //generate fireballs
          for (int i = 0; i < fireballsMAX; i++) {
             if (!fireBalls[i].active) {
                fireBalls[i].active = true;
                fireBalls[i].x = width + 10;   //make them generated outside of the screen
                fireBalls[i].y = random(0, height); //make them generated randomly in Y position
                fireBalls[i].speed = 2;  //the moving speed
                fireBalls[i].r = 10; // the radius of the balls
                fireBallCount++;  
                fireBallCD = 10; 
                break; //the loop end when each ball sucessfully generated
                }
           }
     } else {
      fireBallCD--; //CD countdown
      }
   }

  //show the active Fireballs
  for (int i = 0; i < fireballsMAX; i++) {
    if (fireBalls[i].active) {
      fireBalls[i].move(); 
      fireBalls[i].display();
      if (fireBalls[i].x < -fireBalls[i].r) {
        fireBalls[i].active = false;          //when fireballs exceed the screen, clean them.
        fireBallCount--;
  }
 }
}
}

void bulletsCollisions() { //check the collisions between the bullets and fireballs
  for (int i = 0; i < bulletsMAX; i++) {
    if (bullets[i].active) {  //only check the active bullets
      for (int j = 0; j < fireballsMAX; j++) {
        if (fireBalls[j].active) { 
          float dx = bullets[i].x - fireBalls[j].x; //calculate the distane between the bullet and the fireball
          float dy = bullets[i].y - fireBalls[j].y;
          float distance = sqrt(dx*dx + dy*dy);                     
             if (distance < bullets[i].r + fireBalls[j].r) { //if the distance < sum of radius of bullet and fireball, collisions happned
              bullets[i].active = false;
              fireBalls[j].active = false;//clean the bullet and fireball
              fireBallCount--; 
              score++; // earn point when successfully hit a fireball
              break; //end the loop when collision happend
            }
        }
      }
    }
  }
}

void planeCollisions() { // check the collision between the plane and fireball
  float planeMinX = plane.position.x + 10;  // give a range to define the collision
  float planeMaxX = plane.position.x + 70;
  float planeMinY = plane.position.y + 10;
  float planeMaxY = plane.position.y + 30;

  for (int i = 0; i < fireballsMAX; i++) {
    if (fireBalls[i].active) {

      if (fireBalls[i].x > planeMinX && fireBalls[i].x < planeMaxX &&
          fireBalls[i].y > planeMinY && fireBalls[i].y < planeMaxY) {   //check if the fireball in the range of the plane
        gamestatus = 2;  //game end!
  }
  }
  }
}

void keyPressed() {
}
