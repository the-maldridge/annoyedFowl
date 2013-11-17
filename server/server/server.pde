import processing.net.*;

private ArrayList<String> names;
private ArrayList<Integer> scores;
private String scoreTable;
Server cloud;

void setup() {
  cloud = new Server(this, 9600);
  names = new ArrayList<String>();
  scores = new ArrayList<Integer>();
}

void draw() {
    Client newScore = cloud.available();
    if (newScore != null) {
      scores.add(int(newScore.readChar()));
      names.add(str(newScore.readChar() + newScore.readChar() + newScore.readChar()));
    
      scoreTable = "High Scores Table:\n";
      for (int i=0; i<scores.size(); i++) {
        String name = names.get(i);
        String score = str(scores.get(i));
        scoreTable += name + "\t" + score;
      }
    
      cloud.write(scoreTable);
      cloud.disconnect(newScore);
    }
}
    
