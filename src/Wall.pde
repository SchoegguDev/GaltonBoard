class Wall {
  float x;
  float y1;
  float y2;
  float thickness;

  Wall(float x, float y1, float y2, float thickness) {
    this.x = x;
    this.y1 = y1;
    this.y2 = y2;
    this.thickness = thickness;
  }

  void display() {
    stroke(0);
    strokeWeight(thickness);
    line(x, y1, x, y2);
  }

  boolean intersects(Ball ball) {
    return abs(ball.x - x) < (ball.diameter/2 + thickness/2) && ball.y > y1 && ball.y < y2;
  }
}

ArrayList<Ball> balls = new ArrayList<Ball>();
ArrayList<Structure> Structures = new ArrayList<Structure>();
ArrayList<Wall> walls = new ArrayList<Wall>();
int numberOfRows = 10;
float startingX;
float startingY = 100;
float gap = 40;
int ballDropInterval = 60;
int ballDropCounter = 0;

void setup() {
  size(800, 800);
  startingX = width / 2;
  ellipseMode(CENTER);
  for (int i = 0; i < numberOfRows; i++) {
    for (int j = -i; j <= i; j+=2) {
      Structures.add(new Structure(startingX + j*gap, startingY + i*gap, 25));
    }
  }
  for (int i = 0; i < 60; i++) {
    balls.add(new Ball(width / 2 + random(-5, 5), 30, 20, color(0, 0, 255), false)); // Ball initial x-position varies randomly between -5 and 5 pixels
  }
  for (int i = 50; i < width; i+=50) {
    walls.add(new Wall(i, height - 100, height, 5));
  }
}

void draw() {
  background(255);
  if (ballDropCounter == ballDropInterval) {
    for (Ball b : balls) {
      if (!b.isInPlay) {
        b.isInPlay = true;
        break;
      }
    }
    ballDropCounter = 0;
  }
  ballDropCounter++;

  boolean allBallsInPlay = true;
  for (Ball b : balls) {
    if (b.isInPlay) {
      b.display();
      b.move(Structures, walls, balls);
      if (b.y + b.diameter/2 < height - 100) {
        allBallsInPlay = false;
      }
    } else {
      allBallsInPlay = false;
    }
  }

  for (Structure p : Structures) {
    p.display();
  }

  for (Wall w : walls) {
    w.display();
  }

  if (allBallsInPlay) {
    stroke(255, 0, 0);
    drawNormalDistributionCurve();
    stroke(0);
  }
}

void drawNormalDistributionCurve() {
  noFill();
  beginShape();
  for (int x = 0; x < width; x++) {
    float y = (float)(1.1 * 100 * Math.exp(-Math.pow(x - width / 2, 2) / (1.5 * Math.pow(125, 2))));
    vertex(x, height - y);
  }
  endShape();
}
