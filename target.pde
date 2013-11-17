class target {
  private int targetStart;
  private int targetWidth;
  
  target(String glyph) {
    targetStart = int(random(100, width - targetWidth));
    targetWidth = 50;
    stroke(255, 0, 0);
    line(targetStart, height-1, targetStart + targetWidth, height-1);
    stroke(0);
  }

  void checkTarget() {
    //check if target hit
  }
}
