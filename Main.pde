import processing.sound.*;

class Main {

  SoundFile soundTrack;

  ArrayList<Obstacle> obstacles = new ArrayList();

  Player player;

  // Initialize images
  PImage exitButton = loadImage("exitButton2.png");
  PImage cursor = loadImage("crosshair4.png");

  // Get random number of obstacles
  int numberObstacles = round(random(15, 30));

  boolean playerCollidedTop;

  boolean playerCollidedBottom;

  boolean playerCollidedRight;

  boolean playerCollidedLeft;

  Obstacle collisionObstacle = new Obstacle();

  Main(Schulprojekt instance) {  
    soundTrack = new SoundFile(instance, "soundTrack.wav");
    soundTrack.loop();

    for (int i = 0; i < numberObstacles; i++) {
      Obstacle obstacle = new Obstacle();
      obstacle.positionX = random(width/2 - 576, width/2 + 576);
      obstacle.positionY = random(height/2 - 296, height/2 + 296);      

      while (!collision(obstacle)) {
        obstacle.positionX = random(width/2 - 576, width/2 + 576);
        obstacle.positionY = random(height/2 - 296, height/2 + 296);
      }

      obstacles.add(obstacle);
    }
    
    player = new Player();
    player.positionX = random(width/2 - 576, width/2 + 576);
    player.positionY = random(height/2 - 296, height/2 + 296);      

    while (!collision(player)) {
      player.positionX = random(width/2 - 576, width/2 + 576);
      player.positionY = random(height/2 - 296, height/2 + 296);
    }
  }

  // Permanent method
  void update() {

    // Set background to black
    background(66, 66, 66);

    // Creates a crosshair as a cursor
    //cursor(cursor); // TODO: FIX INVALID HOTSPOT

    // Set bar on top to grey
    fill(97, 97, 97);
    rect(width/2, 48, width, 96);
    
    textSize(64);
    fill(238, 238, 238);
    text("Monvive", 24, 72);

    // Set playground to light grey
    fill(238, 238, 238);
    rect(width/2, height/2, 1280, 720, 8);

    // Set position of exitButton button
    image(exitButton, width - exitButton.width + 16, 48);

    // Set position of obstacles
    for (int i = 0; i < numberObstacles; i++) {
      Obstacle obstacle = obstacles.get(i);
      image(obstacle.image, obstacle.positionX, obstacle.positionY);
    }
    
    image(player.image, player.positionX, player.positionY);

    // Execute on mousePressed
    if (mousePressed) {
      // When exitButton is pressed close application
      if (mouseX < width - exitButton.width/4 && mouseX > width - exitButton.width - 16 && mouseY < exitButton.height + 16 && mouseY > exitButton.height - 48) {
        exit();
      }
    }

    movementCollision(player);

    println(playerCollidedTop);
    
    // Execute on keyPressed
    if (keyPressed) {
      // Executed when special keys are pressed (up, down etc)
      if (key == CODED) {
        // TODO: IMPLEMENT COLLISION
        switch(keyCode) {
        case UP:     
          if (playerCollidedTop == false) {
            this.player.positionY = this.player.positionY - this.player.speed;
          }
          playerCollidedBottom = false;
          break;
        case DOWN:
          if (playerCollidedBottom == false) {
            this.player.positionY = this.player.positionY + this.player.speed;
          }
          break;
        case LEFT:
          if (playerCollidedLeft == false) {
            this.player.positionX = this.player.positionX - this.player.speed;
          }
          break;
        case RIGHT:
          if (playerCollidedRight == false) {
            this.player.positionX = this.player.positionX + this.player.speed;
          }
          break;
        }
      }
    }
  }

  boolean collision(Display d) {
    boolean collided = false;

    // Check if object hits obstacles
    for (int i = 0; i < obstacles.size(); i++) {
      Obstacle o = obstacles.get(i);
      if (d.getTopEdge() <= o.getBottomEdge() && d.getBottomEdge() >= o.getTopEdge() && d.getRightEdge() >= o.getLeftEdge() && d.getLeftEdge() <= o.getRightEdge()) {
        collided = true;

        collisionObstacle = o;
      }
    }

    return !collided;
  }

  void movementCollision(Display d) {  
    if (getCollidedObstacle(d) != null) {
      Obstacle o = getCollidedObstacle(d);
      collisionObstacle = getCollidedObstacle(d);
      if (d.positionY < o.positionY - 55 && d.positionY > o.positionY - 60) {
        playerCollidedBottom = true;
        playerCollidedTop = false;
        playerCollidedRight = false;
        playerCollidedLeft = false;
      }
      if (d.positionY > o.positionY + 55 && d.positionY < o.positionY + 60) {
        playerCollidedBottom = false;
        playerCollidedTop = true;
        playerCollidedRight = false;
        playerCollidedLeft = false;
      }
      if (d.positionX < o.positionX - 35 && d.positionX > o.positionX - 40) {
        playerCollidedBottom = false;
        playerCollidedTop = false;
        playerCollidedRight = true;
        playerCollidedLeft = false;
      }
      if (d.positionX > o.positionX + 35 && d.positionX < o.positionX + 40) {
        playerCollidedBottom = false;
        playerCollidedTop = false;
        playerCollidedRight = false;
        playerCollidedLeft = true;
      }
    } else {
      playerCollidedTop = false;

      playerCollidedBottom = false;

      playerCollidedRight = false;

      playerCollidedLeft = false;
    }

    if (d.positionX < collisionObstacle.positionX - 40 || d.positionX > collisionObstacle.positionX + 40) {
      playerCollidedTop = false;
      playerCollidedBottom = false;
    }
    if (d.positionY < collisionObstacle.positionY - 60 || d.positionY > collisionObstacle.positionY + 60) {
      playerCollidedRight = false;
      playerCollidedLeft =false;
    }
  }

  Obstacle getCollidedObstacle(Display d) {
    if (!collision(d)) {
      return collisionObstacle;
    } else {
      return null;
    }
  }
}
