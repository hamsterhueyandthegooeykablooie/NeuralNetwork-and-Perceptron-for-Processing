Pipe pipe;

int number_of_players = 50;
int genCounter = 1;

int fit_sum;
int[] fitness_scores;
int[] fit_array;
int movingIndex;
float mutRate = 20;
//MUTRATE MUST BE BETWEEN 0 AND 100

Player parentone;
Player parenttwo;
Player child;

Player[] savedBrains;
Player[] childPlayers;

Population population;

float timeJump = 1;


void setup() {
  size(500, 500);
  pipe = new Pipe();

  parentone = new Player();
  parenttwo = new Player();
  child = new Player();

  childPlayers = new Player[number_of_players];
  for (int i = 0; i < number_of_players; i++) {
    childPlayers[i] = new Player();
  }

  savedBrains = new Player[number_of_players];
  for (int i = 0; i < number_of_players; i++) {
    savedBrains[i] = new Player();
    savedBrains[i].nn.randomize();
  }

  population = new Population(number_of_players);
}

void transferPlayer(Player toTransfer, Player toTransferTo) {
  toTransferTo.size = toTransfer.size;
  toTransferTo.playerx = toTransfer.playerx;
  toTransferTo.alive = toTransfer.alive;
  toTransferTo.velocity = toTransfer.velocity;
  toTransferTo.birdy = toTransfer.birdy;
  toTransferTo.score = toTransfer.score;
  toTransferTo.fitness = toTransfer.fitness;
  for (int i = 0; i < toTransfer.nn.weights.length; i++) {
    toTransferTo.nn.weights[i] = toTransfer.nn.weights[i];
  }
  for (int i = 0; i < toTransfer.nn.biases.length; i++) {
    toTransferTo.nn.biases[i] = toTransfer.nn.biases[i];
  }
}

void selectParents() {

  int number_of_best_players = 10;
  Player[] sortedBird = new Player[number_of_players];

  for (int i=0; i < number_of_players; i++)
  {
    sortedBird[i] = new Player();
    transferPlayer(savedBrains[i], sortedBird[i]);
  }

  for (int i=0; i < sortedBird.length; i++)
  {
    for (int j=0; j < sortedBird.length-1; j++)
    {
      if (sortedBird[j].fitness < sortedBird[j+1].fitness)
      {
        Player temp = new Player();
        transferPlayer(sortedBird[j], temp);
        transferPlayer(sortedBird[j+1], sortedBird[j]);
        transferPlayer(temp, sortedBird[j+1]);
      }
    }
  }

  for (int i = 0; i < number_of_players; i++) {
    transferPlayer(sortedBird[int(random(number_of_best_players))], parentone);
    //transferPlayer(savedBrains[fit_array[int(random(fit_array.length))]], parenttwo);
    makeChild(i);
  }
}

void makeChild(int i) {
  transferPlayer(parentone, child);
  child.nn.mutate(child.nn, mutRate);
  transferPlayer(child, childPlayers[i]);
}

void writeScore() {
  textSize(40);
  fill(0);
  text(pipe.totScore, width-70, 60);
}

void writeLivingPlayers() {
  textSize(40);
  fill(0);
  text(population.living_players, 30, 60);
}

void playerCopy(Player transfer, Player playerToCopyTo) {
  playerToCopyTo.gravity =  transfer.gravity;
}

void writeGen() {
  fill(0);
  textSize(40);
  text(genCounter, width-70, height-60);
}

void restart() {
  if (population.allDead == true) {
    genCounter++;

    pipe.totScore = 0;
    pipe.topval = random(50, width-200);
    pipe.botval = pipe.topval+175;
    pipe.pipex=500;

    for (int i = 0; i < number_of_players; i++) {
      transferPlayer(population.player[i], savedBrains[i]);
    }

    selectParents();

    for (int i = 0; i < number_of_players; i++) {
      transferPlayer(childPlayers[i], savedBrains[i]);
    }

    population = new Population(number_of_players);
    population.allDead = false;
  }
}

void keyPressed() {
  if (keyCode == 39) {
    timeJump *= 2;
  }

  if (timeJump>1) {
    if (keyCode == 37) {
      timeJump /= 2;
    }
  }

  if (key == 'k' || key == 'K') {
    for (int i = 0; i < number_of_players; i++) {
      population.player[i].alive = false;
    }
  }
}


void draw() {
  for (float t = 0; t < timeJump; t++) {
    background(100, 180, 180);
    pipe.update();
    writeScore();
    writeGen();
    writeLivingPlayers();
    population.update();
  }
}
