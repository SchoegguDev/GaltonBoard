class Ball {
  float x;
  float y;
  float speedX;
  float speedY;
  float diameter;
  color ballColor;
  boolean isInPlay;

  Ball(float x, float y, float diameter, color ballColor, boolean isInPlay) {
    this.x = x + random(-0.5, 0.5); // random offset -> Bälle sollen nicht gerade nach unten fallen
    this.y = y;
    this.speedX = 0;
    this.speedY = 2;
    this.diameter = diameter;
    this.ballColor = ballColor;
    this.isInPlay = isInPlay;
  }

  void display() {
    fill(ballColor);
    ellipse(x, y, diameter, diameter); 
  }

  void move(ArrayList<Structure> Structures, ArrayList<Wall> walls, ArrayList<Ball> balls) {
    x += speedX;
    y += speedY;

    for (Structure p : Structures) {
      if (p.intersects(this)) {
        PVector ballCenter = new PVector(x, y);
        PVector StructureCenter = new PVector(p.x, p.y);
        PVector direction = PVector.sub(ballCenter, StructureCenter);
        direction.normalize();
        speedX = direction.x;
        speedY = direction.y;
        break; 
      }
    }

    for (Wall w : walls) {
      if (w.intersects(this)) {
        speedX *= -1;
      }
    }

    for (Ball b : balls) {
      if (b != this && b.intersects(this)) {
        PVector ballCenter = new PVector(x, y);
        PVector otherBallCenter = new PVector(b.x, b.y);
        PVector direction = PVector.sub(ballCenter, otherBallCenter);
        direction.normalize();
        speedX = direction.x;
        speedY = direction.y;
      }
    }

    if (y + diameter/2 >= height) {
      speedY *= -0.5;
      y = height - diameter/2;
    }
    speedY += 0.1;
  }

  boolean intersects(Ball obstacle) {
    float distX = obstacle.x - x;
    float distY = obstacle.y - y;
    float distance = sqrt(distX*distX + distY*distY);
    return distance < (obstacle.diameter/2 + diameter/2);
  }
}
