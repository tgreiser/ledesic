import controlP5.*;

OPC opc;
PImage dot;
int mode = 1;
ControlP5 cp5;

CheckBox checkbox;
BarList bars;

String server = "127.0.0.1";

int h = 450;
int w = 450;

void setup()
{
  size(900, 450, P3D);
  
  int align = 500;
  frame.setResizable(false);
  
  opc = new OPC(this, server, 7890);
  
  cp5 = new ControlP5(this);
  
  /*
  cp5.addButton("Add Bar")
    .setValue(99)
    .setPosition(align+50, 420)
    .setSize(200, 19);
    */
    
   
  
  checkbox = cp5.addCheckBox("sections")
    .setPosition(align+240, 10)
    ;
    
  bars = new BarList(align);
  bars.load("bars.csv");
  
  customize(checkbox);

  dot = loadImage("dot.png");
  frameRate(60);

  //updateConfig();
  setupVideo();
}

void customize(CheckBox cb) {
  cb.setColorForeground(color(120))
                .setColorActive(color(255))
                .setColorLabel(color(255))
                .setSize(20, 20)
                .setItemsPerRow(5)
                .setSpacingColumn(10)
                .setSpacingRow(20)
                .addItem("1", 1)
                .addItem("2", 2)
                .addItem("3", 3)
                .addItem("4", 4)
                .addItem("5", 5)
                .activateAll()
                ;
}

void draw()
{
  background(0);
  //println(frameRate);

  if (mode == 1) {
    drawVideo();
  } else if (mode == 2) {
    drawRing();
  } else if (mode == 4) {
    drawDot();
  } else {
    drawRadar();
  }
  bars.draw();
}

void updateConfig() {
  float[] vals = checkbox.getArrayValue();

  opc.reset();
  
  if (vals[0] == 1.0) bars.leds(opc, 1);
  if (vals[1] == 1.0) bars.leds(opc, 2);
  if (vals[2] == 1.0) bars.leds(opc, 3);
  if (vals[3] == 1.0) bars.leds(opc, 4);
  if (vals[4] == 1.0) bars.leds(opc, 5);
}

void controlEvent(ControlEvent theEvent) {
  
  if (theEvent.isFrom(checkbox)) {
    print("got an event from "+checkbox.getName()+"\t\n");
    // checkbox uses arrayValue to store the state of 
    // individual checkbox-items. usage:
    //opc.dispose();
    updateConfig();  
  } else if (theEvent.name().equals("videos")) {
    println("Event: "+theEvent.getGroup().getValue()+" from "+ theEvent.getGroup());
    playVideo(int(theEvent.getGroup().getValue()));
  } else if (theEvent.name().equals("bars")) {
    int sel = int(theEvent.getGroup().getValue());
    bars.selected(sel);
  }
  
  if (theEvent.isController()) {
    if (theEvent.isFrom(cp5.getController("Add Bar"))) {
      println(theEvent.getController().getName());
      
      //Bar s1b1 = new Bar();
    } else if (theEvent.isFrom(cp5.getController("Save"))) {
      bars.save();
    }
    println("got a control event from controller with id "+theEvent.getController().getId());
  }

}

void checkBox(float[] a) {
  println(a);
}

void keyPressed() {
  println(bars.isFocus());
  if (bars.isFocus() == true) {
    return;
  }
  
  keyPressedVideo();
  override = 0;
  //mode = key - 48;
  if (key == 46) {
    mode = 2;
  } else if (key == 47) {
    mode = 3;
  } else if (key == 42) {
    mode = 4;
  } else if (key == 10) {
    mode = 5;
  } else if (key > 48 && key < 57) {
    mode = 1 ;
  }
}

int radarCount = 0;
void drawRadar() {
  int m = (millis() / 50 ) % 60;
  float s = map(m, 0, 60, 0, TWO_PI) - HALF_PI;
  if (override != 0) { s = override; } 

  stroke(255);
  strokeWeight(5);
  int cx, cy;
  cx = h/2;
  cy = w/2;
  line(cx, cy, cx + cos(s) * cx, cy + sin(s) * cx);
}
float override = 0;

void mousePressed() {
  override();
  bars.clicked(mouseX, mouseY);
}

void mouseReleased() {
  bars.stopDragging();
}

void mouseDragged() {
  override();
}

void override() {
  if (mode == 2) {
    override = dist(w/2, h/2, mouseX, mouseY)*2;
  } else if (mode == 3) {
    int cx = w/2;
    int cy = h/2;
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
  if (ringCount++ > h) ringCount = 0;
  float size = float(ringCount);
  if (override > 0) { size = override; }
  fill(255);
  ellipse(h/2, w/2, size, size);
  fill(0);
  ellipse(h/2, w/2, size-10, size-10);
}

void drawDot() {
  
  // Change the dot size as a function of time, to make it "throb"
  float dotSize = height * 0.6 * (1.0 + 0.2 * sin(millis() * 0.01));
  
  // Draw it centered at the mouse location
  image(dot, mouseX - dotSize/2, mouseY - dotSize/2, dotSize, dotSize);
}

void stop() {
  stopVideo();
}

