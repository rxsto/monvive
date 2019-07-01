class Obstacle extends Display {

  PImage image = loadImage("obstacle.png");
  
  Obstacle() {  
    this.sizeX = image.width;
    this.sizeY = image.height;
    
    positionX = 5000;
    positionY = 5000;   
  }
}
