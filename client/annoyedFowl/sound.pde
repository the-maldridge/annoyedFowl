import ddf.minim.*;

class Sound
{
  AudioPlayer song;
  
  Sound(String name)
  {
    song = minim.loadFile(name);
  }
  
  void play()  //Plays a sounds and then rewind
  {
    song.play();
    song.rewind();
  }
  
  void playWithoutRewind()  //Does not rewind sound, good for single use sounds
  {
    song.play();
  }
  
  void rewind()
  {
    song.rewind();
  }
  
  void stop()
  {
    song.close();
  }
}
