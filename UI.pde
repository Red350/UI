/*  OOP Assignment: Sci-fi UI
    Pádraig Redmond C15755659
*/

int centreX, centreY;

ArrayList<Planet> planets;

void setup()
{
  size(1200, 800);
  
  centreX = width/2;
  centreY = height/2;
  
  planets = new ArrayList<Planet>();
  Planet p = new Planet("Tatooine", 200, 0.01);
  planets.add(p);
}

void draw()
{
  background(0);
  drawPlanets();
}

// Function to draw the array list of planets
// Also updates the planets before they're drawn

void drawPlanets()
{
  for (Planet p: planets)
  {
    p.update();
    p.render();
  }
}