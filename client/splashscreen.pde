class splash {
  private PImage sp;
  
  splash(String glyph) {
    sp = loadImage(glyph);
  }
 
 void drawSplash() {
   image(sp, 0, 0); 
 }
}
