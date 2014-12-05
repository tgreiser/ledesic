import processing.video.*;
import controlP5.*;

Movie movie;
OPC opc;
ControlP5 cp5;
ListBox d1;
int size = 450;


void setup()
{
  size(size+450, size, P3D);
  background(0);
  
  cp5 = new ControlP5(this);
  d1 = cp5.addListBox("myList-d1")
    .setPosition(size+50, 0)
    .setSize(200,200);
  
  customize(d1);
  
  movie = new Movie(this, "aeDomeDesign_1.mov");
  movie.loop();
  
  // Connect to the local instance of fcserver. You can change this line to connect to another computer's fcserver
  opc = new OPC(this, "72.174.70.90", 7890);
  LED_config(opc);
  
}

void customize(ListBox ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("dropdown");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  File[] files = new File(sketchPath+"/data").listFiles();
  for (int i=0;i<files.length;i++) {
    String name = files[i].getName();
    if (name.toLowerCase().endsWith(".mov") == false) { continue; }
    ddl.addItem(files[i].getName(), i);
  }
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    int sel = int(theEvent.getGroup().getValue());
    String file = d1.getItem(sel).getText();
    println("event from group : "+file+" from "+theEvent.getGroup());
    movie = new Movie(this, file);
    movie.loop();
  } 
  else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());
  }
}

void draw()
{
  image(movie, 0, 0, size, size);
}

void keyPressed() {
  println(key);
  if (key == CODED) {
    
  }
}

void movieEvent(Movie m) {
  m.read();
}
