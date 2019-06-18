class Player extends Entity {
  
  PImage image = loadImage("player_base.png");
  int kills;
  Gun gun;
  
  Player() {
    this.sizeX = image.width;
    this.sizeY = image.height;
    
  }
}
