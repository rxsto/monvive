class Wave {

  int index;

  ArrayList<Enemy> enemys = new ArrayList();

  int enemyAmount = 0;

  Wave() {
    index = 1;
  }

  void spawnEnemys() {
    int newEnemy = round(random(1, 5)); 
    enemyAmount = newEnemy;

    for (int i = 0; i < newEnemy; i++) {
      Enemy enemy = new Knight();
      enemy = enemy.getEnemy();
      enemy.positionX = random(width/2 - 576, width/2 + 576);
      enemy.positionY = random(height/2 - 296, height/2 + 296);      

      while (main.collision(enemy) == false) {
        enemy.positionX = random(width/2 - 576, width/2 + 576);
        enemy.positionY = random(height/2 - 296, height/2 + 296);
      }

      enemys.add(enemy);
    }
  }

  void showEnemys() {
    for (int i = 0; i < enemyAmount; i++) {
      Enemy enemy = enemys.get(i);
      image(enemy.image, enemy.positionX, enemy.positionY);
    }
  }
}
