import codeanticode.syphon.*;

PGraphics canvas;
SyphonClient client;
OPC opc;

void setup() {
  
  size(450, 450, P3D);
  frame.setResizable(false); // to adapt to sender frame size
  background(0);
  
  println("Available Syphon servers:");
  println(SyphonClient.listServers());
  
  client = new SyphonClient(this);
  
  // possibly use SyphonClient(this, "", "led")

  // Alternative for memoryshare only 
  // spout.initReceiver();
  frameRate(60);
  
  opc = new OPC(this, "192.168.0.12", 7890);
  section1(opc);
} 

void draw() {
  if (client.available()) {
    canvas = client.getGraphics(canvas);  
  
    // Draw the result
    image(canvas, 0, 0, width, height);
  }
}


// RH click to output server name
void mousePressed() {
  println(client.getServerName());
  
}

// over-ride exit to release sharing
void exit() {
  client.stop();
  super.exit(); // necessary
} 






