class Wave {

  int index;

  ArrayList<Enemy> enemies = new ArrayList();

  int enemyAmount = 0;

  Wave() {
    index = 1;
  }

  void spawnEnemies() {
    int newEnemy = round(random(1, index)); 
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
    
    boolean collision = false;
    
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
      if(enemy.getTopEdge() + 30 <= main.player.getBottomEdge() && enemy.getBottomEdge() - 30 >= main.player.getTopEdge() && enemy.getRightEdge() - 20 >= main.player.getLeftEdge() && enemy.getLeftEdge() + 20 <= main.player.getRightEdge()) {
        collision = true;
      }else
      collision = false;
      if(collision == false) {
      enemy.positionX = enemy.positionX - enemy.speedX;
      enemy.positionY = enemy.positionY - enemy.speedY;
      }else
      main.player.currentHealth = main.player.currentHealth - 0.33;
      
      if(i == enemyAmount) {
        i = 0;
      }
    }
  }
}
