float ballisticAngle, currentTime, maxT, vel, xpos=0, ypos=0, gravity=32, max=0; //Simulation variables
float launchAngle = radians(45), launchPower = 100; //Launch variables
int targetStart;
int targetWidth = 25;
int numAttempts = 0;

//Engine constants
final float STEP_ANGLE = 0.1;
final float STEP_POWER = 5;
final float STEP_TIME = 0.05;

String state = "IDLE"; //State container

void drawShot(float x, float y) {
  //Draw the ball at the points that were calculated
  fill(0);
  ellipse(x, y, 3.0, 3.0);
}

void drawHUD() {
  //Draw the text readout for the simulation in procress
  String text = "Time:" + nf(currentTime, 4, 2) 
    + ", X:" + int(xpos) + ", Y:" + int(ypos);  
  text(text, 10, 20); //Contains Time, X, Y
  text("Angle: " + nf(degrees((launchAngle)), 4,2) + "Power: " + launchPower, 10, 35);
  text("Number of Attempts: " + int(numAttempts) + " State: " + state, 10, 50);
}

void drawTarget() {
  stroke(255, 0, 0);
  line(targetStart, height-1, targetStart + targetWidth, height-1);
  stroke(0);
}

void checkTarget() {
  float xpos = vel * currentTime * cos(launchAngle);
  if(xpos >= targetStart && xpos <= targetStart + targetWidth) {
    state = "HIT";
  }
  else {
    state = "MISS";
  }
}

void drawCannon() {
  //Get a new translation matrix, rotate, and restore the canvas
  pushMatrix(); 
  fill(0);
  translate(0, height-7); 
  rotate(launchAngle * -1); 
  rect(0, 0, 25, 7);  
  popMatrix();  
} 



void setup() {
  size(800, 400);
  
  targetStart = int(random(100, width - targetWidth));
  numAttempts = 0;
  state = "IDLE";
}

void draw() {
  background(255);


  if (state=="RUN") {
    currentTime += STEP_TIME; //Increment the Simulation Time
    if (currentTime > maxT) {
      checkTarget();  //Check in see if the player hit the target or not
    }
    //Calculates horizontal and vertical position
    xpos = vel * currentTime * cos(ballisticAngle);
    ypos = (vel * currentTime * sin(ballisticAngle)) - 0.5 *(gravity*(sq(currentTime)));
  }
  if (state=="MISS")
  {
    
  }

  drawTarget();  //Draw target in random area on screen.
  drawCannon();  //Draw the cannon on the screen in the lowerleft corner
  drawHUD(); //Draw Text on screen with debug values

  drawShot(xpos, height - ypos); //Draw cannonball itself
  drawCannon();
}

void keyPressed() {
  switch(key) {
    case 'd':
      launchAngle = launchAngle-STEP_ANGLE<0?0:launchAngle-STEP_ANGLE;
      break;
    case 'a':
      launchAngle = launchAngle+STEP_ANGLE>HALF_PI?HALF_PI:launchAngle+STEP_ANGLE;
      break;
    case 'w':
      launchPower = launchPower+STEP_POWER>175?175:launchPower+STEP_POWER;
      break;
    case 's':
      launchPower = launchPower-STEP_POWER<50?50:launchPower-STEP_POWER;
      break;
    case ' ':
      ballisticAngle = launchAngle;
      currentTime = 0;
      vel = launchPower;
      maxT = ((2 * vel * sin(ballisticAngle)) / gravity);
      numAttempts = numAttempts + 1;  //Increment the number of attempts
      state="RUN";
      break;
    default: 
      println("that was not a valid key");
  }
}
