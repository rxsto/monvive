

// Declaring object main of class Main
private Main main;


// Define start conditions
void setup() {

  // Set screen size to fullscreen
  fullScreen();

  // Set rect origin to center
  rectMode(CENTER);

  // Set image origin to center
  imageMode(CENTER);

  // Initializing main
  main = new Main(this);
  
  lul oskar noob
}

// Run game
void draw() {

  // Run method update of main
  main.update();
}
