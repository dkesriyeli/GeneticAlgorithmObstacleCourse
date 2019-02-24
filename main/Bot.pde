class Bot {

  PVector pos;
  PVector vel;
  PVector acc;
  Movement movement;
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;
  float fitness = 0;

  Bot() {
    movement = new Movement(1000);
    pos = new PVector(800/2, 800-5);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  // show & move called every frame
  void show() { 
    if (isBest) {
      fill(#ff0000);
      ellipse(pos.x, pos.y, 12, 12);
    } else {
      fill(0);
      ellipse(pos.x, pos.y, 4, 4);
    }
  }


  void move() { 
    if (movement.directions.length > movement.step) {
      acc = movement.directions[movement.step];
      movement.step++;
    } else {
      dead = true;
    }
    vel.add(acc);
    vel.limit(obstacles.get(0).height); //limit speed to obstacle height or bot can go through obstacle
    pos.add(vel);
  }


  void update() {
    if (!dead && !reachedGoal) {
      move();
      if (hitObstacle() || nearEdge()) {
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y) < 5) {
        reachedGoal = true;
      }
    }
  }

  void addObstacle(Obstacle obs) {
    obstacles.add(obs);
  }

  boolean hitObstacle() {
    for (Obstacle obs : obstacles) {
      if (pos.x < obs.x + obs.width && pos.x > obs.x && pos.y > obs.y && pos.y < obs.y + obs.height) return true;
    }
    return false;
  }

  boolean nearEdge() {
    return pos.x< 0|| pos.y<0 || pos.x>800 - 4 || pos.y>800 -4;
  }

  void calculateFitness() {
    if (reachedGoal) {
      fitness = 1.0/4.0 + 10000.0/(float)(movement.step * movement.step);
    } else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * distanceToGoal);
    }
  }

  Bot getOffspring() {
    Bot baby = new Bot();
    baby.movement = movement.clone();
    baby.obstacles = (ArrayList<Obstacle>) obstacles.clone();
    return baby;
  }
}
