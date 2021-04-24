class Player {

  int playerx;
  float birdy;
  float velocity;

  float gravity;
  int size;

  int score;
  int fitness;

  boolean alive = true;

  NN nn;
  float[] inputs = {birdy, velocity, pipe.topval, pipe.botval};
  int[] hidden = {2, 3};

  Player() {
    gravity = 0.4;

    playerx = 150;
    velocity = 0;
    birdy = 150;
    size = 50;
    fitness = 0;

    score = 0;
    alive = true;

    nn = new NN(inputs, hidden, 1);
  }

  void show() {
    fill(0, 255, 255);
    ellipse(playerx, birdy, size, size);
  }

  void jump() {
    if (nn.outputs[0] > 0.5) {
      if (velocity > 3  ) {
        velocity = -8;
      }
    }
  }

  void brain() {
    inputs[0] = birdy;
    inputs[1] = velocity;
    inputs[2] = pipe.topval;
    inputs[3] = pipe.botval;

    nn.compute();
  }

  void edge() {
    if (birdy > 500) {
      alive = false;
    }
    if (birdy < 0) {
      alive = false;
    }
  }

  void scoring () {
    if (pipe.hitedge == true) {
      score++;
      pipe.hitedge = false;
    }
  }

  void hitPipe() {
    if (pipe.pipex+75>125) {  
      if (pipe.pipex<175) {
        if (birdy+25>pipe.botval) {
          alive = false;
        }
        if (birdy-25<pipe.topval) {
          alive = false;
        }
      }
    }
  }

  void die () {
    if (alive == false) {
      score = 0;
      birdy = 150;
      velocity = 0;
      size = 0;
    }
  }

  void update() {
    if (alive) {
      fitness++;
      brain();
      jump();
      edge();
      show();
      scoring();
      hitPipe();
      die();
      velocity += gravity; 
      birdy += velocity;
    }
  }
}
