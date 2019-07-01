import processing.sound.*;

class Main {

  SoundFile soundTrack;

  ArrayList<Obstacle> obstacles = new ArrayList();

  Player player;

  Wave wave = new Wave();

  // Initialize images
  PImage exitButton = loadImage("exitButton2.png");
  PImage cursor = loadImage("crosshair4.png");
  PImage healthbar = loadImage("healthBarFull.png");
  PImage background = loadImage("background.png");

  // Get random number of obstacles
  int numberObstacles = round(random(1, 1));

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

    // Set background
    image(background, width/2, height/2  );

    // Set bar on top to grey
    fill(97, 97, 97);
    rect(width/2, 48, width, 96);

    textSize(64);
    fill(238, 238, 238);
    text("Monvive", 24, 72);
    text("Kills: ", 500, 72); 

    // Set position of exitButton button
    image(exitButton, width - exitButton.width + 16, 48);

    // Set position of obstacles
    for (int i = 0; i < numberObstacles; i++) {
      Obstacle obstacle = obstacles.get(i);
      image(obstacle.image, obstacle.positionX, obstacle.positionY);
    }

    image(healthbar, player.positionX, player.positionY - 45);
    image(player.image, player.positionX, player.positionY);
    for (int i = 0; i < player.bullets.size(); i++) {
      image(player.bullets.get(i).image, player.bullets.get(i).positionX, player.bullets.get(i).positionY);
    }
    player.shooting();

    // Execute on mousePressed
    if (mousePressed) {
      // When exitButton is pressed close application
      if (mouseX < width - exitButton.width/4 && mouseX > width - exitButton.width - 16 && mouseY < exitButton.height + 16 && mouseY > exitButton.height - 48) {
        exit();
      }
    }

    movementCollision(player);

    wave.movementEnemys(player);



    for (int i = 0; i < wave.enemys.size(); i++) {
      if (wave.enemys.get(i).currentHealth <= 0) {
        wave.enemyAmount--;
        wave.enemys.remove(wave.enemys.get(i));
      }
    }

    for (int i = 0; i < player.bullets.size(); i++) {
      collisionBulletEnemy(player.bullets.get(i));
    }

    // Execute on keyPressed
    if (keyPressed) {
      if (key == 'W' || key == 'w') { 
        if (playerCollidedTop == false) {
          this.player.positionY = this.player.positionY - this.player.speedX;
          playerCollidedBottom = false;
        }
      } else 

      if (key == 'S' || key == 's') {
        if (playerCollidedBottom == false) {
          this.player.positionY = this.player.positionY + this.player.speedX;
          playerCollidedTop = false;
        }
      } else

        if (key == 'A' || key == 'a') {
          if (playerCollidedLeft == false) {
            this.player.positionX = this.player.positionX - this.player.speedY;
            playerCollidedRight = false;
          }
        } else
          if (key == 'D' || key == 'd') {
            if (playerCollidedRight == false) {
              this.player.positionX = this.player.positionX + this.player.speedY;
              playerCollidedLeft = false;
            }
          }
    }

    if (wave.enemyAmount == 0) {
      wave.spawnEnemys();
      wave.index++;
    }
    wave.showEnemys();
  }

  boolean collision(Display d) {
    boolean collided = false;

    // Check if object hits obstacles
    for (int i = 0; i < obstacles.size(); i++) {
      Obstacle o = obstacles.get(i);
      if (d.getTopEdge() <= o.getBottomEdge() + 100 && d.getBottomEdge() >= o.getTopEdge() - 100 && d.getRightEdge() >= o.getLeftEdge() - 100 && d.getLeftEdge() <= o.getRightEdge() + 100) {
        collided = true;

        collisionObstacle = o;
      }
    }

    return !collided;
  }

  void collisionBulletEnemy(Bullet d) {

    // Check if object hits obstacles
    for (int i = 0; i < wave.enemys.size(); i++) {
      Enemy e = wave.enemys.get(i);
      if (d.getTopEdge()  <= e.getBottomEdge() && d.getBottomEdge() >= e.getTopEdge() && d.getRightEdge() >= e.getLeftEdge() && d.getLeftEdge() <= e.getRightEdge()) {
        e.currentHealth = e.currentHealth - d.baseDamage;       
        player.bullets.remove(d);
      }
    }
  }

  boolean collisionBullet(Display d) {
    boolean collided = false;

    // Check if object hits obstacles
    for (int i = 0; i < obstacles.size(); i++) {
      Obstacle o = obstacles.get(i);

      if (d.getTopEdge() + 50 <= o.getBottomEdge() && d.getBottomEdge() - 50 >= o.getTopEdge() && d.getRightEdge() - 50 >= o.getLeftEdge()  && d.getLeftEdge() + 50 <= o.getRightEdge()) {
        collided = true;
      }
    }
    return !collided;
  }

  boolean collisionMovement(Display d) {
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
      playerCollidedLeft = false;
    }
    if (d.positionY < height/2 - 328) {
      playerCollidedTop = true;
    }
    if (d.positionY > height/2 + 328) {
      playerCollidedBottom = true;
    }
    if (d.positionX < width/2 - 624) {
      playerCollidedLeft = true;
    }
    if (d.positionX > width/2 + 624) {
      playerCollidedRight = true;
    }
  }

  Obstacle getCollidedObstacle(Display d) {
    if (!collisionMovement(d)) {
      return collisionObstacle;
    } else {
      return null;
    }
  }
}
