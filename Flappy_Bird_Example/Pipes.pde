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
    fill(0, 150, 0);
    rect(pipex, 0, 75, topval);
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

  void update() {
    edge();
    show();
    pipex = pipex-2;
  }
}
