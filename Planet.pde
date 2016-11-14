class Planet
{
  String name;
  float x, y;
  int distance;
  float theta;
  int size;
  float speed;
  boolean mouseOver;
  
  Planet(String name, int distance, float speed)
  {
    this.name = name;
    this.distance = distance;
    this.speed = speed;
    
    theta = 0;  // start all planets at the same angle
    size = 20;  // All planets currently represented as the same size
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
    
  }
  
  void update()
  {
    theta += speed;
    x = (cos(theta) * distance) + centreX;
    y = (sin(theta) * distance) + centreY;
  }
  
}