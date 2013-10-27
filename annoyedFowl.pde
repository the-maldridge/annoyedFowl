float xpos;
float ypos;
float currentTime;
float vel;
float gravity;
float maxT;
float angle;
float deltaTime;

void drawShot(float x, float y)
{
  fill(0);
  ellipse(x, y, 3.0, 3.0);
}

void drawPosition() 
{
  String text = "time:" + nf(currentTime, 4, 2) 
    + " xpos:" + int(xpos) + " ypos:" + int(ypos);  
  text(text, 10, 20);
}


void setup()
{
  size(800, 400);
  
  xpos = 0;
  ypos = 0;
  currentTime = 0;
  vel = 150;
  gravity = 32;
  angle = radians(45);
  maxT = ((2 * vel * sin(angle)) / gravity);
  deltaTime = 0.01;
}

void draw()
{
  background(255);
  currentTime += deltaTime;      //Update time
  
  if (currentTime > maxT)
  {
    noLoop();
  }
  
  //Calculates horizontal and vertical position
  xpos = vel * currentTime * cos(angle);
  ypos = (vel * currentTime * sin(angle)) - 0.5 *(gravity*(sq(currentTime)));

  //Draw cannonball
  drawPosition();
  drawShot(xpos, height - ypos);
}
