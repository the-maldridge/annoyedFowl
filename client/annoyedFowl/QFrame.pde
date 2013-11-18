  public class QFrame extends JFrame {
    thirdApplet t;
  public QFrame(String[] scores){
    setBounds(0, 0, 810, 410);
    t = new thirdApplet(scores);
    add(t);
    t.init();
    show();
  }
  
  public void closeWindow(){
    WindowEvent c = new WindowEvent(this, WindowEvent.WINDOW_CLOSING);
    Toolkit.getDefaultToolkit().getSystemEventQueue().postEvent(c);
  }
  
  
  
  
  
  
  
  
  public class thirdApplet extends PApplet{
  String display[];
  int EbuttonX, buttonY, buttonH, buttonW, RbuttonX; 
  boolean Ebutton, Rbutton;
  
  thirdApplet(String[] scores){
    display = scores;
  }
  void setup(){
    size(800,400);
    Ebutton = false;
    Rbutton = false;
    buttonH = 50;
    buttonW = 150;
    RbuttonX = width/3 - buttonW/2;
    buttonY = height*6/7 - buttonH/2;
    EbuttonX = width *2/3 - buttonW/2;
  }
  void draw(){
    background(255);
    update(mouseX ,mouseY);
    
   if(Rbutton){
        fill(200);
    }else{
       fill(255); 
    }
    stroke(0);
    rect(RbuttonX, buttonY, buttonW, buttonH);   
    if(Ebutton){
        fill(200);
    }else{
       fill(255); 
    }
    stroke(0);
    rect(EbuttonX, buttonY, buttonW, buttonH);
    
    
    textSize(20);
       stroke(0);
       fill(0);
       textAlign(CENTER);
       text("Play again", width/3, height*6/7 + 30);
       
    textSize(20);
       stroke(0);
       fill(0);
       textAlign(CENTER);
       text("Exit", width*2/3, height*6/7 + 30);
    
    
    fill(0);
    textAlign(CENTER,CENTER);
    text("1." + display[5],width/2, height/7);
    textAlign(CENTER,CENTER);
    text("2." + display[4],width/2, height*2/7);
    textAlign(CENTER,CENTER);
    text("3." + display[3],width/2, height*3/7);
    textAlign(CENTER,CENTER);
    text("4." + display[2],width/2, height*4/7);
    textAlign(CENTER,CENTER);
    text("5." + display[1],width/2, height*5/7);
  }
  
  void mousePressed(){
    if(Rbutton){
      closeWindow();
    }else if (Ebutton){
      exit();
    }
  }
  
  void update(int x, int y) {
  if ( overbutton(RbuttonX , buttonY, buttonW, buttonH) ) {
    Rbutton = true;
    Ebutton = false;
  } else if ( overbutton(EbuttonX , buttonY, buttonW, buttonH) ) {
    Ebutton = true;
    Rbutton = false;
  } else {
    Ebutton = Rbutton = false;
  }
}
 
 
 boolean overbutton(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
} 
  
}
}
