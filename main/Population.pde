class Population {

  Bot[] bots;
  float fitnessSum;
  int gen = 1;
  int bestBotIndex = 0;
  int minStep = 1000;

  Population(int size) {
    bots = new Bot[size];
    for (int i = 0; i< size; i++) {
      bots[i] = new Bot();
    }
  }


  void show() {
    for (int i = 1; i< bots.length; i++) {
      bots[i].show();
    }
    bots[0].show();
  }

  void update() {
    for (int i = 0; i< bots.length; i++) {
      if (bots[i].movement.step > minStep) {
        bots[i].dead = true;
      } else {
        bots[i].update();
      }
    }
  }

  void calculateFitness() {
    for (int i = 0; i< bots.length; i++) {
      bots[i].calculateFitness();
    }
  }


  boolean allDead() {
    for (int i = 0; i< bots.length; i++) {
      if (!bots[i].dead && !bots[i].reachedGoal) { 
        return false;
      }
    }
    return true;
  }

  void naturalSelection() {
    Bot[] newGen = new Bot[bots.length];
    setBestBot();
    calculateFitnessSum();

    newGen[0] = bots[bestBotIndex].getOffspring();
    newGen[0].isBest = true;
    for (int i = 1; i< newGen.length; i++) {
      Bot parent = selectParent();
      newGen[i] = parent.getOffspring();
    }
    bots = newGen.clone();
    gen ++;
  }

  void mutateNewGen() {
    for (int i = 1; i< bots.length; i++) { // best bot not mutated
      bots[i].movement.mutate();
    }
  }

  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i = 0; i< bots.length; i++) {
      fitnessSum += bots[i].fitness;
    }
  }

  Bot selectParent() {
    float rand = random(fitnessSum);
    float runningSum = 0;
    for (int i = 0; i< bots.length; i++) {
      runningSum+= bots[i].fitness;
      if (runningSum > rand) {
        return bots[i];
      }
    }
    return null;
  }

  void setBestBot() {
    float max = 0;
    int maxIndex = 0;
    for (int i = 0; i< bots.length; i++) {
      if (bots[i].fitness > max) {
        max = bots[i].fitness;
        maxIndex = i;
      }
    }
    bestBotIndex = maxIndex;
    if (bots[bestBotIndex].reachedGoal) {
      minStep = bots[bestBotIndex].movement.step;
    }
  }

  void addObstacle(Obstacle obs) {
    for (int i = 0; i< bots.length; i++) {
      bots[i].addObstacle(obs);
    }
  }
}
