class Planet
{
  String name;
  float x, y;
  int distance;
  float theta;
  int size, largeSize;
  float speed;
  boolean mouseOver;
  int offset = 0;
  
  Planet(String name, int distance, float speed)
  {
    this.name = name;
    this.distance = distance;
    this.speed = speed;
    
    theta = 0;  // start all planets at the same angle
    size = 20;  // All planets currently represented as the same size
    largeSize = 500;
    mouseOver = false;  // Check if the mouse is over the planet
    
    update();  // Call update once to set planet location
  }
  
  void mouseOver()
  {
    mouseOver = dist(mouseX, mouseY, x, y) < size ? true : false;
  }
  
  // Render as part of the system
  void render()
  {
    stroke(c_planet);
    strokeWeight(1);
    noFill();
    ellipse(centreX, centreY, distance*2, distance*2);  // Draw orbit
    if (mouseOver)
    {
      fill(c_planet);
    }
    strokeWeight(3);
    ellipse(x, y, size, size);  // Draw planet
    
    // Draw text
    fill(c_planet_text);
    textAlign(LEFT, CENTER);
    text(name, x + size, y);
  }
  
  // Render a planet on it's own
  void renderLarge()
  {
    noFill();
    stroke(c_singleplanet);
    offset++;
    if (offset == 100)
    {
      offset = 0;
    }
    ellipse(centreX, centreY, largeSize, largeSize);
    for (int i = 0; i < largeSize; i+=100)
    {
      arc(centreX, centreY, i-offset, largeSize, HALF_PI, PI + HALF_PI);
      arc(centreX, centreY, i+offset, largeSize, PI + HALF_PI, TWO_PI+HALF_PI);
    }
  }
  
  void update()
  {
    theta += speed;
    x = (cos(theta) * distance) + centreX;
    y = (sin(theta) * distance) + centreY;
  }
  
}