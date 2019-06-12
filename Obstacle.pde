class Obstacle extends Display {

  PImage image = loadImage("obstacle.png");
  PImage image1 = loadImage("obstacle1.png");
  
  Obstacle() {  
    this.sizeX = image.width;
    this.sizeY = image.height;    
  }
}
