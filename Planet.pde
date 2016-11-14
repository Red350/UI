class Planet
{
  String name;
  float x, y;
  int distance;
  float theta;
  int size;
  float speed;
  boolean mouseOver;
  float scaleValue;
  
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
  
  void render()
  {
    scale(scaleValue);
    stroke(c_green);
    strokeWeight(1);
    noFill();
    ellipse(centreX, centreY, distance*2, distance*2);  // Draw orbit
    if (mouseOver)
    {
      fill(c_green);
    }
    strokeWeight(3);
    ellipse(x, y, size, size);  // Draw planet
    
    // Draw text
    fill(255);
    textAlign(LEFT, CENTER);
    text(name, x + size, y);
  }
  
  void update()
  {
    theta += speed;
    x = (cos(theta) * distance) + centreX;
    y = (sin(theta) * distance) + centreY;
  }
  
}