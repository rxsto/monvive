class Player extends Entity {

  PImage image = loadImage("player_base.png");

  int kills;

  ArrayList<Bullet> bullets = new ArrayList();

  float firerate = 0.4;

  boolean shooting = false;

  Player() {
    this.sizeX = image.width;
    this.sizeY = image.height;
  }

  void shooting () {
    firerateTimer();
    if (firerate == 0.4) {
      if (mousePressed) {

        shooting = true;

        Bullet bullet = new Bullet();

        bullets.add(bullet);

        bullet.speedX = 5;
        bullet.speedY = 5;

        float x = mouseX;
        float y = mouseY;
        float timer = 0.1;
        float positionStartX = positionX;
        float positionStartY = positionY;

        bullet.positionX = positionX;
        bullet.positionY = positionY;

        timer = timer - 0.0125;

        float distanceX = abs(x - positionStartX);
        float distanceY = abs(y - positionStartY);

        float p = sqrt(distanceX*distanceX + distanceY*distanceY);

        bullet.speedX = bullet.speedX * ((1/p)*distanceX);
        bullet.speedY = bullet.speedY * ((1/p)*distanceY);

        if (timer >= 0) {
          if (x < bullet.positionX) {
            bullet.speedX = -abs(bullet.speedX);
          }
          if (x > bullet.positionX) {
            bullet.speedX = abs(bullet.speedX);
          }
          if (y < bullet.positionY) {
            bullet.speedY  = -abs(bullet.speedY);
          }
          if (y > bullet.positionY) {
            bullet.speedY = abs(bullet.speedY);
          }
        }
      }
    }
    for (int i = 0; i < bullets.size(); i++) {
      bullets.get(i).positionX = bullets.get(i).positionX + bullets.get(i).speedX;
      bullets.get(i).positionY = bullets.get(i).positionY + bullets.get(i).speedY;
    }
  }

  void firerateTimer() {
    if (shooting == true) {
      firerate = firerate - 0.0125;
    }
    if (firerate <= 0) {
      firerate = 0.4;
      shooting = false;
    }
  }
}
