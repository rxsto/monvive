class Player extends Entity {

  PImage image = loadImage("player_base.png");
  PImage bullet = loadImage("bullet.png");
  int kills;
  Gun gun;

  Player() {
    this.sizeX = image.width;
    this.sizeY = image.height;
    gun = new Gun();
  }

  void shooting () {
    if (mousePressed) {
      gun.bulletSpeedX = 5;
      gun.bulletSpeedY = 5;
      float x = mouseX;
      float y = mouseY;
      float timer = 0.1;
      float positionStartX = positionX;
      float positionStartY = positionY;

      gun.bulletPositionX = positionX;
      gun.bulletPositionY = positionY;
      timer = timer - 0.0125;

      float distanceX = abs(x - positionStartX);
      float distanceY = abs(y - positionStartY);
      
      float p = sqrt(distanceX*distanceX + distanceY*distanceY);
     
      gun.bulletSpeedX = gun.bulletSpeedX * ((1/p)*distanceX);
      gun.bulletSpeedY = gun.bulletSpeedY * ((1/p)*distanceY);

      //int testXY = abs(round(distanceX / distanceY));
      //int testYX = abs(round(distanceY / distanceX));
      
      ////gun.bulletSpeedX = round(gun.bulletSpeedX * testXY);
      ////gun.bulletSpeedY = round(gun.bulletSpeedY * testYX);
      
      //if(gun.bulletSpeedX > 5) {
      //  gun.bulletSpeedX = 5;
      //}
      //if(gun.bulletSpeedX < -5) {
      //  gun.bulletSpeedX = -5;
      //}
      //if(gun.bulletSpeedY > 5) {
      //  gun.bulletSpeedY = 5;
      //}
      //if(gun.bulletSpeedY < -5) {
      //  gun.bulletSpeedY = -5;
      //}

      if (timer >= 0) {
        if (x < gun.bulletPositionX) {
            gun.bulletSpeedX = -abs(gun.bulletSpeedX);
        }
        if (x > gun.bulletPositionX) {
          gun.bulletSpeedX = abs(gun.bulletSpeedX);
        }
        if (y < gun.bulletPositionY) {
          gun.bulletSpeedY  = -abs(gun.bulletSpeedY);
        }
        if (y > gun.bulletPositionY) {
          gun.bulletSpeedY = abs(gun.bulletSpeedY);
        }
      }
    }
    gun.bulletPositionX = gun.bulletPositionX + gun.bulletSpeedX;
    gun.bulletPositionY = gun.bulletPositionY + gun.bulletSpeedY;

  }
}
