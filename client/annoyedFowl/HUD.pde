class HUD {
  HUD() {}
  
  void update(int hits, int trys) {
    textSize(25);
    String text = str(hits) + "/" + str(trys);
    textAlign(RIGHT);
    text(text, width/2, 35);
  }
}
