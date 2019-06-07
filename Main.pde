import processing.sound.*;

class Main {

  SoundFile soundTrack;

  ArrayList<Obstacle> obstacles = new ArrayList();

  // Initialize images
  PImage exitButton = loadImage("exitButton2.png");
  PImage cursor = loadImage("crosshair4.png");
  PImage player = loadImage("player_base.png");

  // Get random number of obstacles
  int numberObstacles = round(random(5, 10));

  Main(Schulprojekt instance) {  
    soundTrack = new SoundFile(instance, "soundTrack.wav");
    soundTrack.loop();

    for (int i = 0; i < numberObstacles; i++) {
      Obstacle obstacle = new Obstacle();
      obstacle.positionX = random(width/2 - 600, width/2 + 600);
      obstacle.positionY = random(height/2 - 320, height/2 + 320);

      while (!collision(obstacle)) {
        obstacle.positionX = random(width/2 - 600, width/2 + 600);
        obstacle.positionY = random(height/2 - 320, height/2 + 320);
      }

      image(obstacle.image, obstacle.positionX, obstacle.positionY);
      obstacles.add(obstacle);
    }
  }

  // Permanent method
  void update() {

    // Set background to black
    background(0, 0, 0);

    // Creates a crosshair as a cursor
    cursor(cursor);

    // Set bar on top to chocolate brown 5
    fill(139, 69, 19);
    rect(width/2, 48, width, 96);

    // Set playground to white
    fill(255, 255, 255);
    rect(width/2, height/2, 1280, 720);

    // Set position of exitButton button
    image(exitButton, width - exitButton.width + 16, 48);

    // Set position of player
    image(player, width/2, height/2);

    // Set position of obstacles
    for (int i = 0; i < numberObstacles; i++) {
      Obstacle obstacle = obstacles.get(i);
      image(obstacle.image, obstacle.positionX, obstacle.positionY);
    }

    // when exitButton is pressed close application
    if (mousePressed) {
      if (mouseX < width - exitButton.width/4 && mouseX > width - exitButton.width - 16 && mouseY < exitButton.height + 16 && mouseY > exitButton.height - 48)
      {
        exit();
      }
    }
  }

  boolean collision(Display object) {
    boolean collided = false;

    // Check if object hits wall
    if (width/2 - 640 > object.positionX - object.sizeX || width/2 + 640 < object.positionX + object.sizeX || height/2 - 360 > object.positionY - object.sizeY || height/2 + 360 < object.positionY + object.sizeY) {
      collided = true;
    }

    // Check if object hits obstacles
    for (int i = 0; i < obstacles.size(); i++) {
      if (obstacles.get(i).positionX - obstacles.get(i).sizeX < object.positionX + object.sizeX && obstacles.get(i).positionX + obstacles.get(i).sizeX > object.positionX - object.sizeX && obstacles.get(i).positionY - object.sizeY < object.positionY + object.sizeY && obstacles.get(i).positionY + obstacles.get(i).sizeY > object.positionY - object.sizeY) {
        collided = true;
      }
    }

    return !collided;
  }
}
