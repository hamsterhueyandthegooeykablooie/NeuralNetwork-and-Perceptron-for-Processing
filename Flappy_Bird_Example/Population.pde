class Population {

  Player[] player;

  int num_of_players;
  int living_players;

  boolean allDead;

  Population(int player_num) {
    num_of_players = player_num;
    player = new Player[num_of_players];
    for (int i = 0; i < num_of_players; i++) {
      // INJECTING SAVED INTO NEXT GENERATION AND RESETTING ALL RELEVANT VARIABLES IN PLAYER CLASS
      player[i] = new Player();
      transferPlayer(savedBrains[i], player[i]);
      player[i].size = 50;
      player[i].playerx = 150;
      player[i].alive = true;
      player[i].velocity = 0;
      player[i].birdy = 150;
      player[i].score = 0;
      player[i].fitness = 0;
    }
    living_players = player.length;
    allDead = false;
  }

  void checkPlayers() {
    living_players = 0;
    for (int i = 0; i < num_of_players; i++) {
      if (player[i].alive) {
        living_players++;
      }
    }
    if (living_players == 0) {
      allDead = true;
      restart();
    } else {
      allDead = false;
    }
  }

  //KILL SWITCH

  void update() {
    for (int i = 0; i < num_of_players; i++) {
      checkPlayers();
      player[i].update();
    }
  }
}
