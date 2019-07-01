class Bullet extends Display {
  
  PImage image = loadImage("bullet.png");
  
  float speedX = 15;
  float speedY = 15;
  
  int baseDamage = 49;
  
  Bullet() {
  sizeX = image.width;
  sizeY = image.height;
  }
}
