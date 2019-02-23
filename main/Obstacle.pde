class Obstacle {

  float x; 
  float y;
  float width;
  float height;
  color col = #177ab7; 


  Obstacle() {
    x = random(0, 100);
    y = random(100, 700);
    width = random(300, 750 - x);
    height = 10;
  }

  void show() {
    fill(col);
    rect(x, y, width, height);
  }

  boolean isOverlapping(Obstacle other) {
    return !(other.x > x + width || other.y + other.height <= y || x > other.x + other.width || y + height <= other.y);
  }

  boolean isOverlapping(ArrayList<Obstacle> others) {
    for (Obstacle o : others) {
      if (this.isOverlapping(o)) return true;
    }
    return false;
  }
}
