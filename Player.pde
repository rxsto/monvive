class Player extends Entity {
  
  PImage image = loadImage("player_base.png");
  PImage bullet = loadImage("healthBar1-10.png");
  int kills;
  Gun gun;
  
  Player() {
    this.sizeX = image.width;
    this.sizeY = image.height;
    gun = new Gun();
  }
  
  void shooting (){
  if (mousePressed){
  float x = mouseX;
  float y = mouseY;
  float timer = 0.1;
  gun.bulletPositionX = positionX;
  gun.bulletPositionY = positionY;
  timer = timer - 0.0125;
  if (timer >= 0){
  if(x < gun.bulletPositionX) {
        gun.bulletSpeedX = -abs(gun.bulletSpeedX);
      }
      if(x > gun.bulletPositionX) {
        gun.bulletSpeedX = abs(gun.bulletSpeedX);
      }
      if(y < gun.bulletPositionY) {
        gun.bulletSpeedY  = -abs(gun.bulletSpeedY);
      }
      if(y > gun.bulletPositionY) {
        gun.bulletSpeedY = abs(gun.bulletSpeedY);
  }
  }
  }
  gun.bulletPositionX = gun.bulletPositionX + gun.bulletSpeedX;
  gun.bulletPositionY = gun.bulletPositionY + gun.bulletSpeedY;
  }
}
