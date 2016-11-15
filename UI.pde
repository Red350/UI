/*  OOP Assignment: Sci-fi UI
    Pádraig Redmond C15755659
*/

int centreX, centreY;
int state;
int fadeSpeed;

ArrayList<Planet> planets;
Planet clickedPlanet;

// Colours
ColorHandler c_intro;
ColorHandler c_system;
ColorHandler c_system_text;
ColorHandler c_singleplanet;

// Array lists for storing colors
// Colors are just integers in processing
ArrayList<ColorHandler> fadeIn;
ArrayList<ColorHandler> fadeOut;

void setup()
{
  size(1200, 800);
  
  // Centre of the planet system
  centreX = width*2/3;
  centreY = height/2;
  
  state = 2;  // Default planet view
  
  fadeSpeed = 2;  // Must be greater than 0, larger values means slower fading
  
  // Initialise planets
  Planet p;
  planets = new ArrayList<Planet>();
  p = new Planet("Tatooine", 200, 0.01);
  planets.add(p);
  p = new Planet("Alderaan", 300, 0.00);
  planets.add(p);
  
  // Initialise colours
  c_intro = new ColorHandler(color(0,0,255,255));
  c_system = new ColorHandler(color(0,255,0,100));
  c_system_text = new ColorHandler(color(255,255,255,100));
  c_singleplanet = new ColorHandler(color(255,0,0,0));
  fadeIn = new ArrayList<ColorHandler>();
  fadeOut = new ArrayList<ColorHandler>();
}

void draw()
{
  background(0);
  text("x: "+mouseX+" y: "+mouseY, 10, 15);
  switch(state)
  {
    // Draw intro
    case 0:
      drawIntro();
      break;
    
    // Draw planet view
    case 2:
      drawPlanets();
      mouseOver();
      break;
     
    // Transition from planet view to single planet
    case 3:
      drawPlanets();
      clickedPlanet.renderLarge();
      if(frameCount % fadeSpeed == 0)
      {
        fade();
        ////Fade out planet system
        //c_system -= 0x01000000;
        //c_system_text -= 0x01000000;
        
        //// Fade in single planet
        //c_singleplanet += 0x01000000;
        //if (c_system >> 24 == 0)
        //{
        //  state = 3;
        //  c_system += 0x32000000;
        //  c_system_text += 0x32000000;
        //}
      }
      break;
    
    // Single planet
    case 4:
      clickedPlanet.renderLarge();
      break;
  }
}

// Fades colours in or out depending on the
// contents of the two global colour array lists
int fade()
{
  for (ColorHandler c : fadeIn)
  {
    c.fadeIn(1);
  }
  for (ColorHandler c: fadeOut)
  {
    c.fadeOut(1);
  }
  return 0;
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
// If so change state to the transition between system and planet view
void mouseClicked()
{
  // Can use the fact that if the mouse is over a planet,
  // the planet's mouseOver boolean will be set to true.
  for (Planet p : planets)
  {
    if (p.mouseOver == true)
    {
      // Clear mouseOver flag to prevent it from being clicked again
      p.mouseOver = false;
      clickedPlanet = p;
      state = 3;
      // add colours to their respective fade arrays
      // In this case we are fading out the system and fading in large planet
      fadeIn.add(c_system);
      fadeOut.add(c_system_text);
      fadeIn.add(c_singleplanet);
    }
  }
}

void drawIntro()
{
  ellipse(100,100,100,100);
  if(frameCount==120)
  {
    state=1;
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