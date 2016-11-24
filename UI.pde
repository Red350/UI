/*  OOP Assignment: Sci-fi UI
    Pádraig Redmond 
    C15755659
*/

import processing.sound.*;

/* Constants */
public static final int fadeSpeed = 30; // Number of frames over which a fade transition happens
public static final int numDebris = 100;  // Number of debris objects after a purge

int centreX, centreY;
int state;
int fadeVariable;
int introGap = 10;
boolean mouseLock = false;  // Prevents the mouse from being clicked during transitions

// Planets
ArrayList<Planet> planets;  
Planet clickedPlanet;

// Buttons
SysViewButton sysViewButton;
PurgeButton purgeButton;

// Colours that need to be faded are made using the ColorHandler class
ColorHandler c_intro_text;
ColorHandler c_system;
ColorHandler c_system_purge;
ColorHandler c_system_text;
ColorHandler c_singleplanet;
ColorHandler c_debris;
ColorHandler c_button;

// These array lists store the colours for each screen
ArrayList<ColorHandler> screen_intro;
ArrayList<ColorHandler> screen_system;
ArrayList<ColorHandler> screen_singleplanet;

// These array lists point to the arrays above when they are being faded
ArrayList<ColorHandler> fadeIn;
ArrayList<ColorHandler> fadeOut;

// Intro text
String fileInput[];
StringParser introText;
PFont introFont;

// Sounds
SoundFile bgMusic;

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
  sysViewButton = new SysViewButton(100, 500, 100, 50, "SYSTEM VIEW");
  purgeButton = new PurgeButton(width/6, height/2, 100, 50, "PURGE");
  
  // Initialise colours
  c_intro_text = new ColorHandler(color(192,192,192,255));
  c_system = new ColorHandler(color(0,255,0,0));
  c_system_purge = new ColorHandler(color(255,0,0,0));
  c_system_text = new ColorHandler(color(255,255,255,0));
  c_singleplanet = new ColorHandler(color(255,0,0,0));
  c_debris = new ColorHandler(color(255,0,0,0));
  c_button = new ColorHandler(color(0,255,255,0));
  
  screen_intro = new ArrayList<ColorHandler>();
  screen_system = new ArrayList<ColorHandler>();
  screen_singleplanet = new ArrayList<ColorHandler>();
  
  screen_intro.add(c_intro_text);
  screen_system.add(c_system);
  screen_system.add(c_system_purge);
  screen_system.add(c_system_text);
  screen_singleplanet.add(c_singleplanet);
  screen_singleplanet.add(c_debris);
  screen_singleplanet.add(c_button);
  
  // Initialise intro text
  fileInput = loadStrings("debug.txt");
  if(fileInput == null)
    System.exit(1);
  introText = new StringParser(join(fileInput, "\n"));
  introFont = createFont("starwars.ttf", 30, true);
  if(introFont == null)
    System.exit(1);
  textFont(introFont);
  
  // Initialise sounds
  bgMusic = new SoundFile(this, "deepspace.mp3");
  if(bgMusic == null)
    System.exit(1);
   bgMusic.loop();
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
      mouseOverPlanets();  // Checks mouse is hovering over any planet
      break;
     
    // Transition from system view to single planet
    case 3:
      drawPlanets();
      clickedPlanet.renderLarge();
      sysViewButton.render();
      purgeButton.render();
      if (fade())
      {
        state = 4;
        mouseLock = false;
      }
      break;
    
    // Single planet
    case 4:
      clickedPlanet.renderLarge();
      
      // Draw planet buttons
      sysViewButton.update();
      sysViewButton.render();
      purgeButton.update();
      purgeButton.render();
      break;
      
    // Transition from single planet to system view
    case 5:
      drawPlanets();
      sysViewButton.render();
      purgeButton.render();
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
    return true;
  }
}

// Calls mouseOver function for each planet
// TODO: Make the planet mouseover function part of its update function
void mouseOverPlanets()
{
  for (Planet p: planets)
  {
    p.mouseOver();
  }
}

// Calls the clicked method for each object that can be clicked
void mouseClicked()
{
  if(!mouseLock)
  {
    for (Planet p : planets)
    {
      p.clicked();
    } 
    sysViewButton.clicked();
    
    purgeButton.clicked();
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
    fadeIn = screen_system;
    fadeOut = screen_intro;
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