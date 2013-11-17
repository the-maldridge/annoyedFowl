class target {
  private int rangeFactor = 25;
  private int targetLoc;
  private PImage img = loadImage("glyphs/target.png");
  
  target() {}

  public void create() {
    targetLoc = int(random(100, width));
    update();
  }
  public void update() {
    image(img, targetLoc, height - img.height/2);
  }

  public int leftEdge() {
    return targetLoc - rangeFactor;
  }
  
  public int rightEdge() {
    return targetLoc + rangeFactor;
  }
}

