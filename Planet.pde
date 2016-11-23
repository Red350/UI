class Planet
{
  String name;
  float x, y;
  int distance;
  float theta;
  int size, largeSize, fifthLs;
  float speed;
  boolean mouseOver;
  int offset = 0;
  boolean purge = false;
  float purgeX, purgeY;
  float purgeArcLength = PI / 8;
  
  Planet(String name, int distance, float speed)
  {
    this.name = name;
    this.distance = distance;
    this.speed = speed;
    
    theta = 0;  // start all planets at the same angle
    size = 20;  // All planets currently represented as the same size
    largeSize = 700;
    fifthLs = largeSize / 5; // This is used to calculate the horizontal lines on the large planet
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
    stroke(c_system.c);
    strokeWeight(1);
    noFill();
    textAlign(LEFT, CENTER);
    textSize(12);
    ellipse(centreX, centreY, distance*2, distance*2);  // Draw orbit
    if (mouseOver)
    {
      fill(c_system.c);
    }
    
    // Draw either a planet or an X where the planet was purged
    if (!purge)
    {
      strokeWeight(3);
      ellipse(x, y, size, size);  // Draw planet
      
      // Draw text
      fill(c_system_text.c);
      text(name, x + size, y);
    } else {
      // Draw an X where the planet was purged
      stroke(c_system_purge.c);
      line(purgeX+size/2, purgeY+size/2, purgeX-size/2, purgeY-size/2);
      line(purgeX+size/2, purgeY-size/2, purgeX-size/2, purgeY+size/2);
      // Draw text
      fill(c_system_text.c);
      text(name, purgeX + size, purgeY);
      
      // Draw predicted position of where it would have been
      stroke(c_system.c);
      noFill();
      for(float i = 0; i < TWO_PI; i += purgeArcLength)
      {
        arc(x, y, size, size, i, i+purgeArcLength/2);
      }
    } 
  }
  
  // Render a planet on it's own
  void renderLarge()
  {
    if (!purge)
    {
      noFill();
      stroke(c_singleplanet.c);
      strokeWeight(2);
      offset++;
      if (offset == 100)
      {
        offset = 0;
      }
      
      // Draw half ellipses that move across the planets surface
      // to give the illusion of rotation
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
      // Sadly could not figure out how to calculate exactly what kind of arcs should be drawn,
      // so had to resort to trial and error.
      arc(centreX, centreY-largeSize/2, largeSize, fifthLs, QUARTER_PI+radians(12), PI-QUARTER_PI-radians(12));
      arc(centreX, centreY-largeSize/2+fifthLs, largeSize, fifthLs, QUARTER_PI-radians(15), PI-QUARTER_PI+radians(15));
      arc(centreX, centreY-largeSize/2+fifthLs*2, largeSize, fifthLs, QUARTER_PI-radians(35), PI-QUARTER_PI+radians(35));
      arc(centreX, centreY-largeSize/2+fifthLs*3, largeSize, fifthLs, QUARTER_PI-radians(30), PI-QUARTER_PI+radians(30));
      arc(centreX, centreY-largeSize/2+fifthLs*4, largeSize, fifthLs, QUARTER_PI+radians(4), PI-QUARTER_PI-radians(4));
    }
  }
  
  void purge()
  {
    purge = true;
    purgeX = x;
    purgeY = y;
  }
  
  void update()
  {
    theta += speed;
    x = (cos(theta) * distance) + centreX;
    y = (sin(theta) * distance) + centreY;
  }
  
}