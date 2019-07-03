class Wave {

  int index;

  ArrayList<Enemy> enemies = new ArrayList();

  int enemyAmount = 0;

  Wave() {
    index = 1;
  }

  void spawnEnemies() {
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

      enemies.add(enemy);
    }
    println("[Main] Spawned " + enemyAmount + " enemies in wave " + index);
  }

  void showEnemies() {
    for (int i = 0; i < enemyAmount; i++) {
      Enemy enemy = enemies.get(i);
      image(enemy.image, enemy.positionX, enemy.positionY);
    }
  }
  void movementEnemies(Player player) {
    float x = player.positionX;
    float y = player.positionY;
    
    for(int i = 0;i < enemyAmount; i++) {
      Enemy enemy = enemies.get(i);
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
