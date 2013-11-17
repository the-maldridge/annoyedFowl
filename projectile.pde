class projectile {
  private float xpos;
  private float ypos;
  private float simTime;
  private float maxT;
  private float vel;
  private float gravity = 32;
  private float ballisticAngle;
  private PImage img;
  private String simState = "STOP";
  
  projectile(String glyph) {
    img = loadImage(glyph);
  }
  
  private void drawShot() {
    //Draw the ball at the points that were calculated
    fill(0);
    imageMode(CENTER);
    //ellipse(xpos, height - ypos, 3.0, 3.0);
    image(img, xpos, ypos);
  }

  private void calPos() {
    //Calculates horizontal and vertical position
    xpos = vel * simTime * cos(ballisticAngle);
    ypos = (vel * simTime * sin(ballisticAngle)) - 0.5 *(gravity*(sq(simTime)));
  }
  
  public void fireShot(float langle, float lpower) {
    ballisticAngle = langle;
    vel = lpower;
    maxT = ((2 * vel * sin(ballisticAngle)) / gravity);
    simState = "RUN";
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
