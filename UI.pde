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
boolean pausePlanets = false;

// Planets
ArrayList<Planet> planets;  
Planet clickedPlanet;
Sun sun;
ArrayList<Star> stars;

// Buttons
SysViewButton sysViewButton;
PurgeButton purgeButton;
PauseButton pauseButton;
QuitButton quitButton;
ArrayList<Button> buttons;

// Colours that need to be faded are made using the ColorHandler class
ColorHandler c_intro_text;
ColorHandler c_system;
ColorHandler c_sun;
ColorHandler c_system_purge;
ColorHandler c_system_text;
ColorHandler c_system_button;
ColorHandler c_singleplanet;
ColorHandler c_singleplanet_surface;
ColorHandler c_singleplanet_text;
ColorHandler c_debris;
ColorHandler c_singleplanet_button;

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
StringParser exitText;
PFont introFont;

// Sounds
SoundFile bgMusic;
SoundFile explosionSound;
SoundFile mouseOverSound;
SoundFile buttonClickSound;

void setup()
{
  size(1000,1000);
  frameRate(60);
  
  // Centre of the planet system
  centreX = width/2;
  centreY = height/2;
  
  state = 0;  // Default planet view
  
  fadeVariable = fadeSpeed;
  
  // Initialise planets, sun and star
  planets = new ArrayList<Planet>();
  Table t = loadTable("planets.csv", "header");
  for(TableRow row : t.rows())
  {
    Planet p = new Planet(row.getString("name"), row.getInt("distance"), row.getFloat("speed"), row.getFloat("theta"));
    planets.add(p);
  }
  
  sun = new Sun(centreX, centreY);
  stars = new ArrayList<Star>();
  for(int i = 0; i < 1000; i++)
  {
    Star s = new Star((int)random(width), (int)random(height), 0,0,1);
    stars.add(s);
  }
  
  // Initialise colours
  c_intro_text = new ColorHandler(color(192,192,192,255));
  c_system = new ColorHandler(color(0,255,0,0));
  c_sun = new ColorHandler(color(255,255,0,0));
  c_system_purge = new ColorHandler(color(255,0,0,0));
  c_system_text = new ColorHandler(color(255,255,255,0));
  c_system_button = new ColorHandler(color(0,255,255,0));
  c_singleplanet = new ColorHandler(color(255,0,0,0));
  c_singleplanet_surface = new ColorHandler(color(50,0,0,0));
  c_singleplanet_text = new ColorHandler(color(255,255,255,0));
  c_debris = new ColorHandler(color(255,0,0,0));
  c_singleplanet_button = new ColorHandler(color(0,255,255,0));
  
  screen_intro = new ArrayList<ColorHandler>();
  screen_system = new ArrayList<ColorHandler>();
  screen_singleplanet = new ArrayList<ColorHandler>();
  
  screen_intro.add(c_intro_text);
  screen_system.add(c_system);
  screen_system.add(c_sun);
  screen_system.add(c_system_purge);
  screen_system.add(c_system_text);
  screen_system.add(c_system_button);
  screen_singleplanet.add(c_singleplanet);
  screen_singleplanet.add(c_singleplanet_surface);
  screen_singleplanet.add(c_singleplanet_text);
  screen_singleplanet.add(c_debris);
  screen_singleplanet.add(c_singleplanet_button);
  
  // Initialise buttons
  sysViewButton = new SysViewButton(100, height-100, 100, 50, "SYSTEM VIEW", c_singleplanet_button);
  purgeButton = new PurgeButton(width-200, height-100, 100, 50, "PURGE", c_singleplanet_button);
  pauseButton = new PauseButton(100, 20, 100, 50, "PAUSE", c_system_button);
  quitButton = new QuitButton(width-200, 20, 100, 50, "LOG OUT", c_system_button);
  
  buttons = new ArrayList<Button>();
  buttons.add(sysViewButton);
  buttons.add(purgeButton);
  buttons.add(pauseButton);
  buttons.add(quitButton);
  
  // Initialise intro text and fonts
  fileInput = loadStrings("debug.txt");
  if(fileInput == null)
    System.exit(1);
  introText = new StringParser(join(fileInput, "\n"));
  
  fileInput = null;
  fileInput = loadStrings("exit.txt");
  if(fileInput == null)
    System.exit(1);
  exitText = new StringParser(join(fileInput, "\n"));
  
  introFont = createFont("starwars.ttf", 30, true);
  if(introFont == null)
    System.exit(1);
  textFont(introFont);
  
  // Initialise sounds
  explosionSound = new SoundFile(this, "sounds\\muffled-distant-explosion.wav");
  if(explosionSound == null)
    System.exit(1);
  mouseOverSound = new SoundFile(this, "sounds\\sci-fi-button-beep.wav");
  if(mouseOverSound == null)
    System.exit(1);
  mouseOverSound.amp(0.5);
  buttonClickSound = new SoundFile(this, "sounds\\click.wav");
  if(buttonClickSound == null)
    System.exit(1);
  buttonClickSound.amp(0.1);
  bgMusic = new SoundFile(this, "sounds\\deepspace.mp3");
  if(bgMusic == null)
    System.exit(1);
   bgMusic.loop();
}

void draw()
{
  background(0);

  // Uncomment code below for debug info
  //fill(255);
  //textAlign(LEFT, CENTER);
  //textSize(12);
  //text(" State " + state + " x: "+mouseX+" y: "+mouseY+ " fps: " + frameRate, 10, 15);
  
  if(!pausePlanets)
  {
    updatePlanets();
  }
  drawStars();
  
  switch(state)
  {
    // Draw intro
    case 0:
      drawIntro();
      break;
    
    // Transition from intro to system view
    case 1:
      //drawStarsFadeIn();
      drawIntro();
      drawSystem();
      if(fade())
      {
        state = 2;
      }
      break;
    
    // Draw system view
    case 2:
      drawSystem();
      mouseOverPlanets();
      pauseButton.update();
      quitButton.update();
      break;
     
    // Transition from system view to single planet
    case 3:
      drawSystem();
      drawSinglePlanet();
      if (fade())
      {
        state = 4;
        mouseLock = false;
      }
      break;
    
    // Single planet
    case 4:
      drawSinglePlanet();
      sysViewButton.update();
      purgeButton.update();
      break;
      
    // Transition from single planet to system view
    case 5:
      drawSystem();
      drawSinglePlanet();
      if (fade())
      {
        state = 2;
        mouseLock = false;
      }
      break;
      
    // Transition from system view to exit
    case 6:
      drawSystem();
      drawExit();
      if (fade())
      {
        state = 7;
        mouseLock = false;
      }
      break;
    
    // Exit
    case 7:
      drawExit();
      break;
  }
  //saveFrame("C:\\Users\\Red\\Dropbox\\College\\OOP\\Assignment\\UI\\screenshots\\test-#####.tif");
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
    for (Button b : buttons)
    {
      b.clicked();
    }
  }
}

void drawExit()
{
  exitText.update();
  noFill();
  strokeWeight(1);
  stroke(c_intro_text.c);
  rect(introGap,introGap,width-introGap*2,height-introGap*2);
  fill(c_intro_text.c);
  textSize(30);
  textAlign(LEFT,TOP);
  textLeading(30);
  text(exitText.toString(), introGap*2, introGap*2);
  if(exitText.finished)
  {
    System.exit(0);
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
void drawSystem()
{
  for (Planet p: planets)
  {
    p.render();
  }
  sun.render();
  pauseButton.render();
  quitButton.render();
}

void drawSinglePlanet()
{
  clickedPlanet.renderLarge();
  sysViewButton.render();
  purgeButton.render();
}

void drawStars()
{
  for(Star s : stars)
  {
    s.render();
  }
}

void drawStarsFadeIn()
{
  for(Star s : stars)
  {
    s.renderFade();
  }
}