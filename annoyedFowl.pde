float ballisticAngle, currentTime, maxT, vel, xpos=0, ypos=0, gravity=32, max=0; //Simulation variables
float launchAngle = radians(45), launchPower = 50; //Launch variables

//Engine constants
final float STEP_ANGLE = 0.1;
final float STEP_POWER = 5;
final float STEP_TIME = 0.05;

//State container
String state = "IDLE";

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
void calPos() {
    //Calculates horizontal and vertical position
    xpos = vel * currentTime * cos(ballisticAngle);
    ypos = (vel * currentTime * sin(ballisticAngle)) - 0.5 *(gravity*(sq(currentTime)));
}

void setup() {
  size(800, 400);
}

void draw() {
  background(255);


  if (state=="RUN") {
    currentTime += STEP_TIME; //Increment the Simulation Time
    if (currentTime > maxT) {
      state="IDLE";
      noLoop(); //Conditionally halt the simulation if complete
    }
  }

  drawCannon();  //Draw the cannon on the screen in the lowerleft corner
  calPos();
  drawShot(xpos, height - ypos); //Draw cannonball itself
  drawHUD(); //Draw Text on screen with debug values
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
      vel = launchPower;
      maxT = ((2 * vel * sin(ballisticAngle)) / gravity);
      state="RUN";
      break;
    default: 
      println("that was not a valid key");
  }
}
