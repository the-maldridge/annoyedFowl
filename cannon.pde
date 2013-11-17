class cannon {
  private float launchAngle = radians(45);
  private float launchPower = 100;
  private PImage img;
  final float STEP_ANGLE = 0.1;
  final float STEP_POWER = 5;
  
  cannon(String glyph) {
    img=loadImage(glyph);
  }


  private void update() {
    pushMatrix();
    translate(img.width/2, height - img.height/2);
    rotate(launchAngle * -1);
    imageMode(CENTER);
    image(img, 0, 0);
    popMatrix();
  }

  public void raiseCannon() {
    launchAngle = launchAngle+STEP_ANGLE>HALF_PI?HALF_PI:launchAngle+STEP_ANGLE;
  }
  
  public void lowerCannon() {
    launchAngle = launchAngle-STEP_ANGLE<0?0:launchAngle-STEP_ANGLE;
  }
  
  public void incPower() {
    launchPower = launchPower+STEP_POWER>175?175:launchPower+STEP_POWER;
  }
  
  public void decPower() {
    launchPower = launchPower-STEP_POWER<50?50:launchPower-STEP_POWER;
  }
  public projectile fire() {
    projectile p = new projectile(launchAngle, launchPower);
    return p;
  }
}
