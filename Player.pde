class Player extends Entity {

  PImage image = loadImage("player_base.png");

  int kills = 0;

  ArrayList<Bullet> bullets = new ArrayList();

  float firerate = 0.3;

  boolean shooting = false;

  Player() {
    this.sizeX = image.width;
    this.sizeY = image.height;
  }

  void shooting () {
    firerateTimer();

    if (firerate == 0.3) {
      if (mousePressed) {

        shooting = true;

        Bullet bullet = new Bullet();

        bullets.add(bullet);

        bullet.speedX = 15;
        bullet.speedY = 15;

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
      Bullet b = bullets.get(i);

      b.sizeX = b.image.width;
      b.sizeY = b.image.height;

      b.positionX = b.positionX + b.speedX;
      b.positionY = b.positionY + b.speedY;

      if (b.positionX < width/2 - 670 || b.positionX > width/2 + 670 || b.positionY < height/2 - 390 || b.positionY > height/2 + 390) {
        bullets.remove(b);
      }
      if (!main.collisionBullet(b)) {
        bullets.remove(b);
      }
    }
  }

  void firerateTimer() {
    if (shooting == true) {
      firerate = firerate - 0.0125;
    }
    if (firerate <= 0) {
      firerate = 0.3;
      shooting = false;
    }
  }
}
