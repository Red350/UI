class Planet
{
  String name;
  float x, y;
  int distance;
  float theta;
  int size;
  float speed;
  
  Planet(String name, int distance, float speed)
  {
    this.name = name;
    this.distance = distance;
    this.speed = speed;
    
    theta = 0;  // start all planets at the same angle
    size = 20;  // All planets currently represented as the same size
    
    update();  // Call update once to set planet location
  }
  
  void render()
  {
    noFill();
    stroke(#20C20E);
    ellipse(x, y, size, size);
    ellipse(centreX, centreY, distance*2, distance*2);
  }
  
  void update()
  {
    theta += speed;
    x = (cos(theta) * distance) + centreX;
    y = (sin(theta) * distance) + centreY;
  }
  
}