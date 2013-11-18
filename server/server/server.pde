import processing.net.*;

private String scoreTable;
Server cloud;

//Class that stores a name and an associated score
class NameAndScore
{
  String name;
  Integer score;
  NameAndScore(String n, Integer s)
  {
    name = n;
    score = s;
  }
  
  String GetName()
  {
    return name;
  }
  
  Integer GetScore()
  {
    return score;
  }
  
  void SetName(String n)
  {
    name = n;
  }
  
  void SetScore(int s)
  {
    score = s;
  }
};

//Holds an array of Names and Scores
private ArrayList<NameAndScore> nas;

//BubbleSort will display names in ascending order
void bubblesort()
{
  Integer j;
  boolean flag = true;
  NameAndScore temp;
  
  while(flag)
  {
    flag = false;
    for(j = 0; j < nas.size() - 1; j++) {
      if(nas.get(j).GetScore() > nas.get(j+1).GetScore()) 
      {
        temp = nas.get(j);
        nas.get(j).SetScore(nas.get(j+1).GetScore());
        nas.get(j).SetName(nas.get(j+1).GetName());
        nas.get(j+1).SetScore(temp.GetScore());
        nas.get(j+1).SetName(temp.GetName());
        flag = true;
      }
    }
  }
}

void setup() {
  cloud = new Server(this, 9600);
  nas = new ArrayList<NameAndScore>();
}

void draw() {
    Client newScore = cloud.available();
    if (newScore != null) {
<<<<<<< HEAD
      println("client conected");
      scores.add(int(newScore.readChar()));
      names.add(str(newScore.readChar() + newScore.readChar() + newScore.readChar()));
    
      scoreTable = "High Scores Table:\n";
      for (int i=0; i<scores.size(); i++) {
        String name = names.get(i);
        String score = str(scores.get(i));
        println(name);
        scoreTable += name + "\t" + score;
      }
=======
      nas.add(new NameAndScore(str(newScore.readChar() + newScore.readChar() + newScore.readChar()),
      int(newScore.readChar())));
      
      //Bubblesort will run everytime a new score is added
      bubblesort();
      scoreTable = "High Scores Table:\n";
      for (int i=0; i<nas.size(); i++) {
        String name = nas.get(i).GetName();
        String score = str(nas.get(i).GetScore());
        scoreTable += name + "\t" + score;
     }
>>>>>>> 08177716cd8d52d7433320630bbc754693b3485d
    
      cloud.write(scoreTable);
      cloud.disconnect(newScore);
    }
}
