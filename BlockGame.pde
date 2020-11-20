ArrayList<Enemy> enemies = new ArrayList<Enemy>();
final int startingNum = 1;
final int limit = 10;
int count = 0;
boolean paused = false;
boolean alive = true;
boolean userSelected = false;
int level = 1;

void setup() {
  frameRate(60);
  fullScreen();
  textAlign(CENTER);
  //size(1600, 1600);
}
void draw() {
  background(0);
  if (!userSelected) {
    fill(0, 255, 0);
    textSize(128);
    text("CHOOSE DIFFICULTY", displayWidth/2, 400);
    rect(displayWidth/2-300, 500, 600, 200);
    rect(displayWidth/2-300, 800, 600, 200);
    rect(displayWidth/2-300, 1100, 600, 200);
    textSize(128);
    fill(255);
    text("EASY", displayWidth/2, 650);
    text("MEDIUM", displayWidth/2, 950);
    text("HARD", displayWidth/2, 1250);
  } else {

    count++;

    fill(255);
    rect(mouseX, mouseY, 50, 50);
    if (enemies.size() < limit && count >= 300 && count%300 == 0) {
      enemies.add(new Enemy(level));
    }
    for (Enemy enemy : enemies) {
      enemy.show();
      enemy.move();
    }
    
    if (overlap(mouseX, mouseY)) {
      noLoop();
      alive = false;
      background(0);
      textSize(64);
      fill(255);
      text("You lose!", width/2, height/2);
      text("Time survived: " + count/60 + " second(s)", width/2, height/2+200);
    }


  }
}

boolean overlap(float x, float y) {

  float mouseLeft = x;
  float mouseRight = x + 50;
  float mouseUp = y;
  float mouseDown = y + 50;

  if (enemies.size() > 0) {
    for (int i = 0; i < enemies.size(); i++) {
      Enemy curr = enemies.get(i);
      if (inRangeX(mouseLeft, mouseRight, curr.pos.x, curr.size) && inRangeY(mouseUp, mouseDown, curr.pos.y, curr.size)) {
        System.out.println("this");
        return true;
      }
    }
  }
  return false;
}

void mouseClicked() {
  if (!userSelected) {
    if (mouseX >= displayWidth/2-300 && mouseX <= displayWidth/2+300 && mouseY >= 500 && mouseY <= 700) {
      level = 1;    
      for (int i = 0; i < startingNum; i++) {
        enemies.add(new Enemy(level));
      }
      userSelected = true;
    } else if (mouseX >= displayWidth/2-300 && mouseX <= displayWidth/2+300 && mouseY >= 800 && mouseY <= 1000) {
      level = 2;
      for (int i = 0; i < startingNum; i++) {
        enemies.add(new Enemy(level));
      }
      userSelected = true;
    } else if (mouseX >= displayWidth/2-300 && mouseX <= displayWidth/2+300 && mouseY >= 1100 && mouseY <= 1300) {
      level = 3;
      for (int i = 0; i < startingNum; i++) {
        enemies.add(new Enemy(level));
      }
      userSelected = true;
    }
  }
  if (!alive) {
    reset();
    enemies.add(new Enemy(level));
    loop();
  }
}

void reset() {
  enemies = new ArrayList<Enemy>();
  alive = true;
  count = 0;
  paused = false;
}

void keyPressed() {
  if (key == 'p' && !paused) {
    noLoop();
    paused = true;
  } else if (key == 'p' && paused) {
    loop();
  } else if (key == 'r') {
    reset();
    userSelected = false;
    loop();
  }
}

boolean inRangeX(float left, float right, float pos, float size) {
  float posLeft = pos;
  float posRight = pos + size;
  return posLeft <= right && posRight >= left;
}

boolean inRangeY(float up, float down, float pos, float size) {
  float posUp = pos;
  float posDown = pos + size;
  return posUp <= down && posDown >= up;
}
