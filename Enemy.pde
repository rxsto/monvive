abstract class Enemy extends Entity {

  int hitDamage;
  Weapon weapon;

  int index;

  PImage image;

  Enemy() {
    super();
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
