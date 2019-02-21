class Movement {

  PVector[] directions;
  int step = 0;


  Movement(int size) {
    directions = new PVector[size];
    createMovement();
  }



  void createMovement() {
    for (int i = 0; i< directions.length; i++) {
      float randomAngle = random(TWO_PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }

  Movement clone() {
    Movement clone = new Movement(directions.length);
    for (int i = 0; i < directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }
    return clone;
  }

  void mutate() {
    float mutationRate = 0.01;
    for (int i =0; i< directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
