Population pop;
PVector goal  = new PVector(850/2, 80);
int frameR = 60;
int numObstacles = 5; //change this to create wanted amount of obstacles
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Util util = new Util();
boolean isStarted = false;
Button startB = new Button("Start", 930.0, 100.0, 90.0, 40.0, #00ff00);
Button stopB = new Button("Stop", 930.0, 100.0, 90.0, 40.0, #ff0000);
Button restartB = new Button("Restart", 930.0, 150.0, 90.0, 40.0, #fc8600);
Button sim100 = new Button("Sim 20", 930.0, 200.0, 90.0, 40.0, #74a7fc);
Button plus = new Button("+", 930.0, 250.0, 40.0, 40.0, #91e2e2);
Button min = new Button("-", 980.0, 250.0, 40.0, 40.0, #91e2e2);


void setup() {
  size(1250, 900); 
  frameRate(frameR);
  pop = new Population(1000);
  createObstacles();
}


void draw() { 
  background(255);
  fill(#ffffff);
  rect(50, 50, 800, 800);
  util.printText("generation: " + pop.gen, 980, 55);
  util.printText("minStep: " + (pop.minStep != 1000? pop.minStep: "none"), 980, 75);
  util.printText("Number of Obstacles " + numObstacles, 980, 300, 19, #76c1c1);
  restartB.show();
  sim100.show();
  plus.show();
  min.show();
  showObstacles();
  pop.show();
  restartB.show();
  fill(#08c92e);
  util.star(goal.x, goal.y, 7, 15, 5);

  if (isStarted) {
    stopB.show();
    if (pop.allDead()) {
      pop.calculateFitness();
      pop.naturalSelection();
      pop.mutateNewGen();
    } else {
      pop.update();
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
  } else if (plus.mouseIsOver() && numObstacles <10) {
    numObstacles++;
  } else if (min.mouseIsOver() && numObstacles > 1) {
    numObstacles--;
  } else if (sim100.mouseIsOver()) {
    isStarted = false;
    draw();
    int i = 0;
    while (i<20) {
      if (pop.allDead()) {
        pop.calculateFitness();
        pop.naturalSelection();
        pop.mutateNewGen();
        i++;
      } else {
        pop.update();
      }
    }
  }
}

void createObstacles() {
  obstacles = new ArrayList<Obstacle>();
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
