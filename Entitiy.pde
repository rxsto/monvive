abstract class Entity extends Display {

  int speed;
  int baseHealth;
  float currentHealth;
  
  Entity() {
   speed = 2;
   baseHealth = 100;
   currentHealth = 100;
  }
}
