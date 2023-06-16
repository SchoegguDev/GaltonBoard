class Structure {
  float x;
  float y;
  float diameter;

  Structure(float x, float y, float diameter) {
    this.x = x;
    this.y = y;
    this.diameter = diameter;
  }

  void display() {
    fill(0);
    ellipse(x, y, diameter, diameter);
  }

  boolean intersects(Ball ball) {
    float distX = ball.x - x;
    float distY = ball.y - y;
    float distance = sqrt(distX*distX + distY*distY);
    return distance < (ball.diameter/2 + diameter/2);
  }
}
