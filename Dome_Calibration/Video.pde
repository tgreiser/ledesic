import processing.video.*;

Movie movie;

ListBox d1;
boolean playing;

void setupVideo() {
  background(0);

  d1 = cp5.addListBox("myList-d1")
    .setPosition(w+50, 0)
    .setSize(200,200);
  
  customize(d1);
  
  movie = new Movie(this, "aeDomeDesign_1.mov");
  movie.loop();
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

void videoEvent(ControlEvent theEvent) {
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

void drawVideo()
{
  image(movie, 0, 0, w, h);
}

void keyPressedVideo() {
  println(key);
  if (key == 32) {
    if (playing == true) {
      movie.pause();
      playing = false;
    } else {
      movie.play();
      playing = true;
    }
  }
  if (key >= 48 && key <= 57) {
    String file = "";
    try {
      file = d1.getItem(key-48).getText();
      
      println("Loading " + file);
      movie = new Movie(this, file);
      movie.loop();
    } catch (java.lang.IndexOutOfBoundsException e) {
      // no need to complain
    }  
  }
  
  if (key == CODED) {
    
  }
}

void movieEvent(Movie m) {
  m.read();
}
