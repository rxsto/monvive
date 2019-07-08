abstract class Enemy extends Entity {

  int hitDamage;
  Weapon weapon;

  float speedX = 1;
  float speedY = 1;

  int index;

  PImage image;

  Enemy() {
    super();
    
    float newSpeed = random(0.8 + main.wave.index/10, 1.6 + main.wave.index/10);

    speedX = newSpeed;
    speedY = newSpeed;

    

    index = round(random(0.5, 3.5));
    if (index == 1) {
      image = loadImage("enemy_base.png");
    } else {
      if (index == 2) {
        image = loadImage("enemy_base.png");
      } else {
        if (index == 3) {
          image = loadImage("enemy_base.png");
        }
      }
    }
    sizeX = image.width/2;
    sizeY = image.height/2;
  }

  Enemy getEnemy() {
    if (index == 1) {
      Archer archer = new Archer();
      return archer;
    } else {
      if (index == 2) {
        Bomber bomber = new Bomber();
        return bomber;
      } else {
        if (index == 3) {
          Knight knight = new Knight();
          return knight;
        } else {
          return null;
        }
      }
    }
  }
}
