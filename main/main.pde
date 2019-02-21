Population pop;
PVector goal  = new PVector(400, 15);
int frameR = 100;
int numObstacles = 4; //change this to create wanted amount of obstacles
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Util util = new Util();


void setup() {
  size(800, 800); 
  frameRate(frameR);
  pop = new Population(1000);
  createObstacles();
}


void draw() { 
  background(255);
  showObstacles();
  fill(#08c92e);
  util.star(goal.x, goal.y, 7, 15, 5);
  util.printText("generation: " + pop.gen, 10, 30);
  util.printText("minStep: " + (pop.minStep != 1000? pop.minStep: "none"), 10, 50);


  if (pop.allDead()) {
    pop.calculateFitness();
    pop.naturalSelection();
    pop.mutateNewGen();
  } else {
    pop.update();
    pop.show();
  }
}

void createObstacles() {
  for (int i=0; i< numObstacles; i++) {
    Obstacle obs = new Obstacle();
    pop.addObstacle(obs);
    obstacles.add(obs);
  }
}

void showObstacles() {
  for (Obstacle obs : obstacles) {
    obs.show();
  }
}
