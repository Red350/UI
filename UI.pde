/*  OOP Assignment: Sci-fi UI
    Pádraig Redmond C15755659
*/

int centreX, centreY;
int state;

ArrayList<Planet> planets;
Planet clickedPlanet;

// Colours
color c_planet = color(0,255,0,50);
color c_planet_text = color(255,255,255,50);
color c_singleplanet = color(255,0,0,0);

void setup()
{
  size(1200, 800);
  
  // Centre of the planet system
  centreX = width/2;
  centreY = height/2;
  
  state = 1;  // Default planet view
  
  Planet p;
  planets = new ArrayList<Planet>();
  p = new Planet("Tatooine", 200, 0.01);
  planets.add(p);
  p = new Planet("Alderaan", 300, 0.001);
  planets.add(p);
}

void draw()
{
  background(0);
  switch(state)
  {
    // Draw intro
    case 0:
      break;
    
    // Draw planet view
    case 1:
      drawPlanets();
      mouseOver();
      break;
     
    // Transition from planet view to single planet
    case 2:
      drawPlanets();
      clickedPlanet.renderLarge();
      if(frameCount % 4 == 0)
      {
        // Fade out planet system
        c_planet -= 0x01000000;
        c_planet_text -= 0x01000000;
        
        // Fade in single planet
        c_singleplanet += 0x01000000;
        if (c_planet >> 24 == 0)
        {
          state = 3;
          c_planet += 0x32000000;
          c_planet_text += 0x32000000;
        }
      }
      break;
    
    // Single planet
    case 3:
      clickedPlanet.renderLarge();
      break;
  }
}
 
// Calls mouseOver function for each planet
void mouseOver()
{
  for (Planet p: planets)
  {
    p.mouseOver();
  }
}

// Checks if a planet has been clicked
void mouseClicked()
{
  // Can use the fact that if the mouse is over a planet,
  // the planet's mouseOver boolean will be set to true.
  for (Planet p : planets)
  {
    if (p.mouseOver == true)
    {
      clickedPlanet = p;
      state = 2;
    }
  }
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