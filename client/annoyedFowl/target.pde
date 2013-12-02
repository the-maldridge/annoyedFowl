class target {
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

  public int xpos() {
    return targetLoc;
  }
  
  public int ypos() {
    return img.height/2;
  }
  
  public int radius() {
    return img.height;
  }
}
