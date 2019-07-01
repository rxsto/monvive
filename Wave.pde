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

    for (int i = 0; i < enemyAmount; i++) {
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
  void movementEnemys(Player player) {
    float x = player.positionX;
    float y = player.positionY;
    
    for(int i = 0;i < enemyAmount; i++) {
      Enemy enemy = enemys.get(i);
      if(x < enemy.positionX) {
        enemy.speedX = abs(enemy.speedX);
      }
      if(x > enemy.positionX) {
        enemy.speedX = -abs(enemy.speedX);
      }
      if(y < enemy.positionY) {
        enemy.speedY = abs(enemy.speedY);
      }
      if(y > enemy.positionY) {
        enemy.speedY = -abs(enemy.speedY);
      }
      enemy.positionX = enemy.positionX - enemy.speedX;
      enemy.positionY = enemy.positionY - enemy.speedY;
      if(i == enemyAmount) {
        i = 0;
      }
    }
  }
}
