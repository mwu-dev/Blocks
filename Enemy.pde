class Enemy {

  //class variables
  final int widthx = displayWidth;//the width and height of the frame
  final int heighty = displayHeight;
  float size;                    //size of the enemy cube
  int level;                     //"level" of the enemy, scalar multiplier
  PVector speed;                 //speed of the enemy dropping down
  PVector pos;                   //position of the enemy
  char dir;                      //direction the cube moves

  //constructor with given level
  Enemy(int lev) {
    level = lev;
    size = random(100, 250) * (float)Math.sqrt(level);

    switch(level) {
    case 1:
      levelOne();
      break;
    case 2:
      if (biRand()) {
        levelTwo();
      } else {
        levelOne();
      }
      break;
    case 3:
      int choice = triRand();
      switch(choice) {
      case 0:
        levelOne();
        break;
      case 1:
        levelTwo();
        break;
      case 2:
        levelThree();
        break;
      }
      break;
    }
  }

  boolean biRand() {
    return random(1) > 0.5;
  }

  int triRand() {
    float rand = random(1);
    return (rand <= 0.33)? 0 : (rand <= 0.67)? 1 : 2;
  }

  void levelOne() {
    pos = new PVector(random(0, widthx), 0-size);
    while (pos.x + size > widthx) {
      pos = new PVector(random(0, widthx), 0-size);
    }
    speed = new PVector(0, random(10, 15) * level);
    dir = 'd';
  }

  void levelTwo() {
    if (biRand()) {
      pos = new PVector(0-size, random(0, heighty));
      while (pos.y + size > heighty) {
        pos = new PVector(0-size, random(0, heighty));
      }
      speed = new PVector(random(10, 15) * level,0);
      dir = 'r';
    } else {
      pos = new PVector(widthx + size, random(0, heighty));
      while (pos.y + size > heighty) {
        pos = new PVector(widthx + size, random(0, heighty));
      }
      speed = new PVector(-random(10, 15) * level,0);
      dir = 'l';
    }
  }

  void levelThree() {
    pos = new PVector(random(0, widthx), heighty+size);
    while (pos.x + size > widthx) {
      pos = new PVector(random(0, widthx), heighty+size);
    }
    speed = new PVector(0, -random(10, 15) * level);
    dir = 'u';
  }

  //show the enemy
  void show() {
    fill(0, 255, 0);
    rect(pos.x, pos.y, size, size);
  }

  //move the enemy
  void move() {
    //if it moves past the frame, reset its location
    if (dir == 'd' && pos.y > heighty) {
      reset();
    }
    else if(dir == 'u' && pos.y+size < 0){
      reset();
    }
    else if(dir == 'l' && pos.x+size < 0){
      reset();
    }
    else if(dir == 'r' && pos.x > widthx){
      reset();
    }
    pos.add(speed);
  }

  void reset() {
    switch(level) {
    case 1:
      levelOne();
      break;
    case 2:
      if (biRand()) {
        levelTwo();
      } else {
        levelOne();
      }
      break;
    case 3:
      int choice = triRand();
      switch(choice) {
      case 0:
        levelOne();
        break;
      case 1:
        levelTwo();
        break;
      case 2:
        levelThree();
        break;
      }
      break;
    }
    size = random(100, 250) * level;
  }
}
