//
//             Spout Receiver
//
//      Sharing image frames between applications
//      by Opengl/directx texture or memory map sharing
//
//      Demonstrates receiving an image from a Spout sender
//      The sender can be any of the Spout example senders.
//
//      See Spout.pde for function details
//

// DECLARE A SPOUT OBJECT HERE
Spout spout;

PImage img;

OPC opc;

void setup() {
  
  size(450, 450, P2D);
  frame.setResizable(false); // to adapt to sender frame size
  background(0);

  // Create an image to receive the data.
  // RGB, ARGB, image size or frame size do not matter
  // because the received image and the frame adapt if
  // the incomimg texture size changes
  img = createImage(width, height, RGB);
  
  // CREATE A NEW SPOUT OBJECT HERE
  spout = new Spout();
  
  // INITIALIZE A SPOUT RECEIVER HERE
  // Give it the name of the sender you want to connect to
  // Otherwise it will connect to the active sender
  // img will be updated to the sender size
  spout.initReceiver("led", img);
 
  // Alternative for memoryshare only 
  // spout.initReceiver();
  frameRate(60);
  
  opc = new OPC(this, "192.168.0.12", 7890);
  section1(opc);
} 

void draw() {
  
  // RECEIVE A SHARED TEXTURE HERE
  img = spout.receiveTexture(img);
  
  // Draw the result
  image(img, 0, 0, width, height);
  println(frameRate);
  println(img.width);
}


// RH click to select a sender
void mousePressed() {
  
  // SELECT A SPOUT SENDER HERE
  if (mouseButton == RIGHT) {
    // Bring up a dialog to select a sender from
    // the list of all senders running.
    JSpout.SenderDialog();
  }
  
}

// over-ride exit to release sharing
void exit() {
  // CLOSE THE SPOUT RECEIVER HERE
  spout.closeReceiver();
  super.exit(); // necessary
} 






