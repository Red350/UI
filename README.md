# Assignment for OOP: Sci-Fi UI
Name: Pádraig Redmond

Student Number: C15755659

## Description
NOTE: If you're running the program several times, replace intro.txt with a blank text file to avoid having to wait through the intro each time.

### Intro
I planned very early for my UI to be based on a solar system. I created an [experimental project](https://github.com/Red350/Solar_system_experiment) in the first few weeks of the module, which consisted of a solar system simulation that could be sped up, slowed down, and even reversed. I ended up starting completely from scratch with the actual assingnment, though I learned a lot from that which I applied to the current version.

This UI is loosely inspired by Star Wars, mostly just the names and the idea of blowing up planets. It's intended to be part of a spaceship, sort of a projection onto a window looking out into space.

### String Parser
To give the illusion of typed text, I wrote a string parsing class. It effectively prints characters to the screen at a set rate, but also adds the functionality of delay and backspace.

A '^' character followed by 2 numbers will cause the cursor to flash on and off equal to the number given, making it seem like the terminal is waiting.

A '$' character is interpreted as a backspace, and will clear text already printed to the screen.

### Colour Fade
Colours in processing are not objects, they are simply 32 bit integers, with each 2 bytes referring to the rgb and alpha values of the colour. This made fading colours in and out a bit more complicated than I thought it would be.

I wrote a colour handler class that can be used to set the rgb or alpha of a colour to a specific value. It uses bit operations on a processing color value to clear the relevant bits and then set them to the new value.

Each screen has an associated ColorHandler array that stores any colour used for that screen. When fading, there are two other arrays, fadeIn and fadeOut, which unsurprisingly point to the respective arrays to be faded in and out.

## Asset Credits

### Font
Star wars font - [STARWARS.TTF](http://www.fonts2u.com/starwars.font) by Jose Gonzalez Pareja

### Audio
Background music - [deepspace.mp3](https://www.freesound.org/people/keinzweiter/sounds/161615/) by keinzweiter
Background music - [space1.mp3](https://www.freesound.org/people/alaupas/sounds/176685/) by alaupas
Button click - https://www.freesound.org/people/kwahmah_02/sounds/256116/
Button mouse over - https://www.freesound.org/people/DrMinky/sounds/166186/
