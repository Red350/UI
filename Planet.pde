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
    strokeWeight(3);
    offset++;
    if (offset == 100)
    {
      offset = 0;
    }
    
    ellipse(centreX, centreY, largeSize, largeSize);
    arc(centreX, centreY, largeSize-offset, largeSize, HALF_PI, PI + HALF_PI);
    for (int i = 0; i < largeSize; i+=100)
    {
      // Draw left side of planet
      arc(centreX, centreY, i-offset, largeSize, HALF_PI, PI + HALF_PI);
      // Draw right side of planet
      if (i != 0 || offset != 0)
      {
        arc(centreX, centreY, i+offset, largeSize, PI + HALF_PI, TWO_PI+HALF_PI);
      }
    }
    
    // Draw horizontal lines
    // 492 736 191
    //curve(492, 191, 508, 195, 674, 195, 736, 191);
    //curve(1,1, 463, 191, 736, 191, 100,100);
    arc(centreX, centreY-largeSize/2, largeSize, 100, QUARTER_PI+radians(12), PI-QUARTER_PI-radians(12));
    arc(centreX, centreY-largeSize/2+100, largeSize, 100, QUARTER_PI-radians(15), PI-QUARTER_PI+radians(15));
    arc(centreX, centreY-largeSize/2+200, largeSize, 100, QUARTER_PI-radians(35), PI-QUARTER_PI+radians(35));
    arc(centreX, centreY-largeSize/2+300, largeSize, 100, QUARTER_PI-radians(30), PI-QUARTER_PI+radians(35));
  }
  
  void update()
  {
    theta += speed;
    x = (cos(theta) * distance) + centreX;
    y = (sin(theta) * distance) + centreY;
  }
  
}