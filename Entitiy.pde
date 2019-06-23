abstract class Entity extends Display {

  int speedX;
  int speedY;
  int baseHealth;
  float currentHealth;
  
  Entity() {
   speedX = 2;
   speedY = 2;
   baseHealth = 100;
   currentHealth = 100;
  }
}
