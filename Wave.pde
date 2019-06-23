class Wave {
  
  int index;
  
  ArrayList<Enemy> enemys = new ArrayList();
  
  int enemyAmount;
  
  Wave() {
    index = 1;
  }
  
  void spawn() {
   int newEnemy = round(random(1, 5)); 
   enemyAmount = newEnemy;
   
   for(int i = 0; i < newEnemy; i++) {
     Obstacle enemy = new Enemy();
      enemy.positionX = random(width/2 - 576, width/2 + 576);
      enemy.positionY = random(height/2 - 296, height/2 + 296);      

      while (main.collision(enemy) == false) {
        enemy.positionX = random(width/2 - 576, width/2 + 576);
        enemy.positionY = random(height/2 - 296, height/2 + 296);
      }

      enemys.add(enemy);
    }
  }
}
