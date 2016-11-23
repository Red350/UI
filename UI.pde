/*  OOP Assignment: Sci-fi UI
    Pádraig Redmond C15755659
*/

/* Constants */
public static final int fadeSpeed = 30; // Number of frames over which a fade transition happens
public static final int numDebris = 100;  // Number of debris objects after a purge

int centreX, centreY;
int state;
int fadeVariable;
int introGap = 10;
boolean mouseLock = false;  // Prevents the mouse from being clicked during transitions

// Planets and debris
ArrayList<Planet> planets;  
Planet clickedPlanet;
Debris purgeDebris[];

// Buttons
Button testButton;
Button purgeButton;

// Colours that need to be faded are made using the ColorHandler class
ColorHandler c_intro_text;
ColorHandler c_system;
ColorHandler c_system_purge;
ColorHandler c_system_text;
ColorHandler c_singleplanet;

// Array lists for storing colors
// Colors are just integers in processing
ArrayList<ColorHandler> fadeIn;
ArrayList<ColorHandler> fadeOut;

// Intro text
String fileInput[];
StringParser introText;
PFont introFont;

void setup()
{
  size(1200, 800);
  frameRate(60);
  
  // Centre of the planet system
  centreX = width*2/3;
  centreY = height/2;
  
  state = 0;  // Default planet view
  
  fadeVariable = fadeSpeed;
  
  // Initialise planets
  Planet p;
  planets = new ArrayList<Planet>();
  p = new Planet("Tatooine", 200, 0.01);
  planets.add(p);
  p = new Planet("Alderaan", 300, 0.001);
  planets.add(p);
  
  // Initialise buttons
  testButton = new Button(100, 500, 100, 50, #00FFFF, "SYSTEM VIEW");
  purgeButton = new Button(width/6, height/2, 100, 50, #00FFFF, "DO NOT PRESS");
  
  // Initialise colours
  c_intro_text = new ColorHandler(color(192,192,192,255));
  c_system = new ColorHandler(color(0,255,0,0));
  c_system_purge = new ColorHandler(color(255,0,0,0));
  c_system_text = new ColorHandler(color(255,255,255,0));
  c_singleplanet = new ColorHandler(color(255,0,0,0));
  fadeIn = new ArrayList<ColorHandler>();
  fadeOut = new ArrayList<ColorHandler>();
  
  // Initialise intro text
  fileInput = loadStrings("debug.txt");
  if(fileInput == null)
    System.exit(1);
  introText = new StringParser(join(fileInput, "\n"));
  introFont = createFont("starwars.ttf", 30);
  if(introFont == null)
    System.exit(1);
  textFont(introFont);
  //introText = new StringParser("Test string\r06\nNext String\r08\b\b\b\b\r04");
}

void draw()
{
  background(0);
  fill(255);
  // show mouse coordinates
  textAlign(LEFT, CENTER);
  textSize(12);
  text(" State " + state + " x: "+mouseX+" y: "+mouseY+ " fps: " + frameRate, 10, 15);
  
  drawPanel();  // Draw the user panel of the left side of the screen
  updatePlanets();  // Update the planets every frame, even when not displayed
  
  switch(state)
  {
    // Draw intro
    case 0:
      drawIntro();
      break;
    
    // Transition from intro to system view
    case 1:
      drawIntro();
      drawPlanets();
      if(fade())
      {
        state = 2;
      }
      break;
    
    // Draw planet view
    case 2:
      drawPlanets();
      mouseOver();  // Checks if the mouse is hovering over any planet
      break;
     
    // Transition from system view to single planet
    case 3:
      drawPlanets();
      clickedPlanet.renderLarge();
      if (fade())
      {
        state = 4;
        mouseLock = false;
      }
      break;
    
    // Single planet
    case 4:
      clickedPlanet.renderLarge();
      // Draw debris
      if (purgeDebris != null)
      {
        for (int i = 0; i < numDebris; i++)
        {
          purgeDebris[i].update();
          purgeDebris[i].render();
        }
      }
      
      // Draw planet buttons
      testButton.update();
      testButton.render();
      purgeButton.update();
      purgeButton.render();
      break;
      
    // Transition from single planet to system view
    case 5:
      drawPlanets();
      clickedPlanet.renderLarge();
      if (fade())
      {
        state = 2;
        mouseLock = false;
      }
      break;
  }
}

void drawPanel()
{
}

// Fades colours in or out depending on the
// contents of the two global colour array lists
boolean fade()
{
  if (fadeVariable > 0)
  {
    // fade colours
    for(ColorHandler c : fadeOut)
    {
      c.setAlpha((int)map(fadeVariable,0,fadeSpeed,0,255));
    }
    for(ColorHandler c : fadeIn)
    {
      c.setAlpha((int)map(fadeVariable,0,fadeSpeed,255,0));
    }
    fadeVariable--;
    return false;
  }
  else
  {
    // Clear the fade arrays
    fadeIn.clear();
    fadeOut.clear();
    return true;
  }
}

// Calls mouseOver function for each planet
// TODO: Make the planet mouseover function part of its update function
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
  if(!mouseLock)
  {
    // Can use the fact that if the mouse is over a planet,
    // the planet's mouseOver boolean will be set to true.
    for (Planet p : planets)
    {
      if (p.mouseOver)
      {
        mouseLock = true;
        // Clear mouseOver flag to prevent it from being clicked again
        p.mouseOver = false;
        clickedPlanet = p;
        state = 3;
        // add colours to their respective fade arrays
        // In this case we are fading out the system and fading in large planet
        fadeOut.add(c_system);
        fadeOut.add(c_system_text);
        fadeOut.add(c_system_purge);
        fadeIn.add(c_singleplanet);
        fadeVariable = fadeSpeed;
      }
    }
    
    if(testButton.mouseOver)
    {
      testButton.mouseOver = false;  // Clear mouseOver flag to prevent it from being clicked again
      mouseLock = true;
      state = 5;  // Transition from single planet to system view
      fadeIn.add(c_system);
      fadeIn.add(c_system_text);
      fadeIn.add(c_system_purge);
      fadeOut.add(c_singleplanet);
      fadeVariable = fadeSpeed;
    }
    
    // PURGE
    if(purgeButton.mouseOver)
    {
      if(clickedPlanet.purge == false)
      {
        clickedPlanet.purge();
        purgeDebris = new Debris[numDebris];
        Debris d;
        for(int i = 0; i < numDebris; i++)
        {
          d = new Debris(centreX, centreY,random(-10,+10),random(-10,+10),random(0,PI/32), (int)random(180,240));
          purgeDebris[i] = d;
        }
      }
    }
  }
}

void drawIntro()
{
  introText.update();
  noFill();
  strokeWeight(1);
  stroke(c_intro_text.c);
  rect(introGap,introGap,width-introGap*2,height-introGap*2);
  fill(c_intro_text.c);
  textSize(30);
  textAlign(LEFT,TOP);
  textLeading(30);
  text(introText.toString(), introGap*2, introGap*2);
  if(introText.finished)
  {
    introText.finished = false;
    fadeIn.add(c_system);
    fadeIn.add(c_system_text);
    fadeIn.add(c_system_purge);
    fadeOut.add(c_intro_text);
    fadeVariable = fadeSpeed;
    state = 1;
  }
}

// Function to update the position of the planets in the system view
void updatePlanets()
{
  for (Planet p: planets)
  {
    p.update();
  }
}

// Function to draw the planets in the system view
void drawPlanets()
{
  for (Planet p: planets)
  {
    p.render();
  }
}