abstract class Display {

  int sizeX;
  int sizeY;

  float positionX;
  float positionY;

  float getLeftEdge() {
    return this.positionX - this.sizeX;
  }

  float getRightEdge() {
    return this.positionX + this.sizeX;
  }

  float getTopEdge() {
    return this.positionY - this.sizeY;
  }

  float getBottomEdge() {
    return this.positionY + this.sizeY;
  }
}
