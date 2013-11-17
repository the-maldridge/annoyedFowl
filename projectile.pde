class projectile {
  private float xpos=0;
  private float ypos=0;
  private float simTime;
  private float maxT;
  private float vel;
  private float gravity = 32;
  private float ballisticAngle;
  private PImage img = loadImage("glyphs/CD.png");
  private String simState = "STOP";
  
  projectile(float langle, float lpower) {
    //img = loadImage(glyph);
    ballisticAngle = langle;
    vel = lpower;
    xpos=0;
    ypos=0;
    simTime=0;
    maxT = ((2 * vel * sin(ballisticAngle)) / gravity);
    simState = "RUN";
  }
  
  private void drawShot() {
    //Draw the ball at the points that were calculated
    fill(0);
    imageMode(CENTER);
    image(img, xpos, height - ypos);
  }

  private void calPos() {
    //Calculates horizontal and vertical position
    xpos = vel * simTime * cos(ballisticAngle);
    ypos = (vel * simTime * sin(ballisticAngle)) - 0.5 *(gravity*(sq(simTime)));
  }
  
  public void update() {
    simTime = simTime + 0.05;
   if (simState == "RUN") {
      calPos();
      drawShot();
    } else {
      if (simTime > maxT) {
        simState="STOP";
      }
    }
  }
}
