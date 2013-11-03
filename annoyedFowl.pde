float xpos;
float ypos;
float currentTime;
float vel;
float gravity;
float maxT;
float angle;
float deltaTime;
float cannonAngle;
float firingAngle;
boolean isFired;

void drawShot() {
   fill(0);
   ellipse(xpos, ypos, 3.0, 3.0);
    
    if(isFired == true)
  {
    //Calculates horizontal and vertical position
    xpos = vel * currentTime * cos(firingAngle);
    ypos = (vel * currentTime * sin(firingAngle)) - 0.5 *(gravity*(sq(currentTime)));
    ypos = height - ypos;
  }
}

void drawHUD() {
  String text = "Flight Time:" + nf(currentTime, 4, 2); 
  text(text, 10, 20); //Contains Time
  String posText = "xpos:" + int(xpos) + ", ypos:" + int(ypos);
  text(posText, 10, 35);  //Contains X and Y coodinates of cannonball
  String angleText = "Cannon Angle: " + nf(degrees(cannonAngle), 2, 3);
  text(angleText, 10, 50);  //Contains the current angle of the cannon
}

void drawCannon()
{
  //Adjust origin to draw cannon in lowerleft corner
  pushMatrix();
  fill(0);
  translate(0, height - 5);
  rotate(cannonAngle * -1);
  rect(0, 0, 40, 5);
  popMatrix();
}

void keyPressed()
{
  if(key == CODED)
  {
    if(keyCode == LEFT)
    {
      cannonAngle = cannonAngle + .01; //Increment cannon position
      if(cannonAngle > HALF_PI) //Clamp cannon angle so it does not go beyond the left boundary
      {
        cannonAngle = HALF_PI;
      }
    }
    else if(keyCode == RIGHT)
    {
      cannonAngle = cannonAngle - .01; //Decrement cannon position
      if(cannonAngle < 0) //Clamp cannon angle so it does not go below the screen
      {
        cannonAngle = 0;
      }
    }
  }
  else if(key == ' ')
  {
    fireCannon();
  }
}

void fireCannon()
{
  //Restart the simulation
  currentTime = 0;
  firingAngle = cannonAngle;
  maxT = 2*vel*sin(firingAngle)/gravity;
  isFired = true;
}

void setup() {
  size(800, 400);
  xpos = 0;
  ypos = 0;
  currentTime = 0;
  vel = 150;
  gravity = 32;
  angle = cannonAngle = firingAngle = radians(45);
  maxT = ((2 * vel * sin(angle)) / gravity);
  deltaTime = 0.01;
  isFired = false;
}

void draw() {
  background(255);
  
  if (currentTime > maxT) {
    isFired = false;
    //checkTarget();
  }
  else {
    if(isFired == true) 
    {
      currentTime += deltaTime; //Increment the Simulation Time
    }
  }

  drawCannon();  //Draw the cannon on the screen in the lowerleft corner
  drawHUD(); //Draw Text on screen with debug values
  drawShot(); //Draw cannonball itself
}
