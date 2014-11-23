OPC opc;
PImage dot;
int mode = 1;

void setup()
{
  size(450, 450);

  dot = loadImage("dot.png");

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "192.168.0.10", 7890);
  LED_config(opc);
}

void draw()
{
  background(0);
  println("Got mode " + mode);
  if (mode == 1) {
    drawDot();
  } else if (mode == 2) {
    drawRing();
  } else {
    drawRadar();
  }
}

void keyPressed() {
  println(key);
  mode = key - 48;
}

int radarCount = 0;
void drawRadar() {
  int m = (millis() / 50 ) % 60;
  float s = map(m, 0, 60, 0, TWO_PI) - HALF_PI;
  stroke(255);
  strokeWeight(5);
  int cx, cy;
  cx = height/2;
  cy = width/2;
  line(cx, cy, cx + cos(s) * cx, cy + sin(s) * cx);
}

int ringCount = 0;
void drawRing() {
  stroke(255);
  strokeWeight(4);
  if (ringCount++ > height) ringCount = 0;
  float size = float(ringCount);
  fill(255);
  ellipse(height/2, width/2, size, size);
  fill(0);
  ellipse(height/2, width/2, size-10, size-10);
}

void drawDot() {
  
  // Change the dot size as a function of time, to make it "throb"
  float dotSize = height * 0.6 * (1.0 + 0.2 * sin(millis() * 0.01));
  
  // Draw it centered at the mouse location
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
}

