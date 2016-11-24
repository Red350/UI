int centreSize = 50;
float theta1 = 0;
float theta2 = 0;
float temp;
float d = 100;
int numPeaks = 4;

void drawPanel()
{
  noStroke();
  fill(c_system_text.c);
  ellipse(200,200,50,50);
  fill(125);
  temp = theta2;
  for(int i = 0; i < 18; i++)
  {
    temp += TWO_PI/18*numPeaks;
    d = sin(temp)*10+50;
    ellipse(200 + cos(theta1) * d, 200 - sin(theta1) * d, 10, 10);
    
    theta1 = theta1 + TWO_PI/18;
  }
  theta2 = theta2 +0.05;
  theta1 = 0;
  
}