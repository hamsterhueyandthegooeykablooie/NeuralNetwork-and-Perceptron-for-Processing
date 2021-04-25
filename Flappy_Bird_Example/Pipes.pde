class Pipe {

  float topval;
  float botval;
  float pipex;

  boolean hitedge;

  int totScore;
  boolean restart = false;

  Pipe() {
    topval = random(50, 300);
    botval = topval+150;
    pipex = 500;
    hitedge = false;
  }

  void show() {
    stroke(0, 255, 0);
    fill(0, 150, 0);
    rect(pipex, -10, 75, topval+10);
    rect(pipex, botval, 75, width);
  }

  void edge() {
    if (pipex<0) {
      topval = random(50, width-200);
      botval = topval+175;
      hitedge = true;
      pipex=500;
      if (population.allDead == false) {
        totScore++;
      }
    }
  }
  
  void drawBottom() {
    stroke(11, 6.7, 3.3);
    fill(101, 67, 33);
    rect(0, height-25, width, 25);
  }

  void update() {
    drawBottom();
    edge();
    show();
    pipex = pipex-2;
  }
}
