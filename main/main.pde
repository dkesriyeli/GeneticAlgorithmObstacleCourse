Population pop;
PVector goal  = new PVector(400, 15);
int frameR = 100;
int numObstacles = 5; //change this to create wanted amount of obstacles
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Util util = new Util();
boolean isStarted = false;
Button startB = new Button("start", 900.0, 100.0, 90.0, 40.0, #00ff00);
Button stopB = new Button("stop", 900.0, 100.0, 90.0, 40.0, #ff0000);
Button restartB = new Button("restart", 900.0, 200.0, 90.0, 40.0, #fc8600);


void setup() {
  size(1200, 810); 
  frameRate(frameR);
  pop = new Population(1000);
  createObstacles();
}


void draw() { 
  background(255);
  fill(#ffffff);
  rect(0, 0, 800, 800);
  util.printText("generation: " + pop.gen, 900, 30);
  util.printText("minStep: " + (pop.minStep != 1000? pop.minStep: "none"), 900, 50);
  restartB.show();
  if (isStarted) {
    showObstacles();
    stopB.show();
    restartB.show();
    fill(#08c92e);
    util.star(goal.x, goal.y, 7, 15, 5);
    if (pop.allDead()) {
      pop.calculateFitness();
      pop.naturalSelection();
      pop.mutateNewGen();
    } else {
      pop.update();
      pop.show();
    }
  } else {
    startB.show();
  }
}

void mouseClicked() {
  if (startB.mouseIsOver()) {
    isStarted = !isStarted;
  } else if (restartB.mouseIsOver()) {
    setup();
  }
}

void createObstacles() {
  for (int i=0; i< numObstacles; i++) {
    Obstacle obs = new Obstacle();
    while (obs.isOverlapping(obstacles)) {
      obs = new Obstacle();
    }
    pop.addObstacle(obs);
    obstacles.add(obs);
  }
}

void showObstacles() {
  for (Obstacle obs : obstacles) {
    obs.show();
  }
}
