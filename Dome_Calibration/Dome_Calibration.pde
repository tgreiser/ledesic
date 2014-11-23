OPC opc;
PImage dot;
int mode = 1;

void setup()
{
  size(450, 450);

  dot = loadImage("dot.png");

  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "127.0.0.1", 7890);
  LED_config(opc);
}

void draw()
{
  background(0);

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
  override = 0;
  mode = key - 48;
}

int radarCount = 0;
void drawRadar() {
  int m = (millis() / 50 ) % 60;
  float s = map(m, 0, 60, 0, TWO_PI) - HALF_PI;
  if (override != 0) { s = override; } 
//map(override, 0, width, 0, TWO_PI) - HALF_PI; }
  stroke(255);
  strokeWeight(5);
  int cx, cy;
  cx = height/2;
  cy = width/2;
  line(cx, cy, cx + cos(s) * cx, cy + sin(s) * cx);
}
float override = 0;

void mousePressed() {
  override();
}

void mouseDragged() {
  override();
}

void override() {
  if (mode == 2) {
    override = dist(width/2, height/2, mouseX, mouseY)*2;
  } else if (mode == 3) {
    int cx = width/2;
    int cy = height/2;
    int dy = mouseY - cy;
    int dx = mouseX - cx;
    
    float slope = 0;
    if (dx != 0) { slope = float(dy) / float(dx); }
    
    override = atan(slope);
    // make the negative side of the circle work
    if (dx < 0) { override = override + 3; }
  }
}

int ringCount = 0;
void drawRing() {
  stroke(255);
  strokeWeight(4);
  if (ringCount++ > height) ringCount = 0;
  float size = float(ringCount);
  if (override > 0) { size = override; }
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

