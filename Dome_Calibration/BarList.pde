int HANDLE_SIZE = 6;

class BarList {
  ListBox pts;
  Bar[] bars;
  int selected = -1;
  Handle h1;
  Handle h2;
  
  BarList(int align) {
      pts = cp5.addListBox("bars")
        .setPosition(align+50, 100);
      customizePts(pts);
  }
  
  void leds(OPC opc, int section) {
    for (Bar b : bars) {
      if (b.section == section) {
        b.leds(opc);
      }
    }
  }
  
  void load(String filename) {
    Table table = loadTable("bars.csv", "header");
    
    bars = new Bar[table.getRowCount()];
    int iX = 0;
    for (TableRow row : table.rows()) {
      bars[iX++] = new Bar(row.getString("name"), row.getInt("section"), row.getInt("bar"), row.getInt("index"), row.getInt("count"),
        row.getFloat("x1"), row.getFloat("y1"),
        row.getFloat("x2"), row.getFloat("y2")
        );
    }
    
    getList(pts);
  }
  
  void save(String filename) {
    String[] data = new String[bars.length+1];
    int iX = 1;
    data[0] = "section,bar,x1,y1,x2,y2,index,count,name";
    for (Bar b : bars) {
      data[iX++] = str(b.section)+","+str(b.bar)+","+str(b.x1)+","+str(b.y1)+","+str(b.x2)+","+
        str(b.y2)+","+str(b.index)+","+str(b.count)+","+b.name;
    } // finish CSV TODO
    saveStrings("data/"+filename, data);
    updateConfig();
  }
  
  void getList(ListBox ddl) {
    for (int iX = 0; iX < bars.length; iX++) {
      ddl.addItem(bars[iX].getListName(), iX);
    }
  }
  
  void selected(int sel) {
    if (sel >= bars.length) { return; }
    
    println("Selecting " + bars[sel].getListName());
    if (selected >=0) {
    }
    selected = sel;
    h1 = new Handle(bars[sel], true, float(HANDLE_SIZE));
    h2 = new Handle(bars[sel], false, float(HANDLE_SIZE));
  }
  
  // if a bar is selected, draw the handles
  void draw() {
    if (selected > -1 && selected < bars.length) {
      //println("Drawing points for bar " + bars[selected].getListName());
      h1.draw();
      h1.arrowAt(h2);
      h2.draw();
    }
  }
  
  void clicked(float x, float y) {
    if (h1 != null) h1.clicked(x, y);
    if (h2 != null) h2.clicked(x, y);
  }
  
  void stopDragging() {
    if (h1 != null) h1.stopDragging();
    if (h2 != null) h2.stopDragging();
  }
}

void customizePts(ListBox ddl) {
  // a convenience function to customize a DropdownList
  ddl.setBackgroundColor(color(190));
  ddl.setItemHeight(20);
  ddl.setBarHeight(15);
  ddl.captionLabel().set("Bars");
  ddl.captionLabel().style().marginTop = 3;
  ddl.captionLabel().style().marginLeft = 3;
  ddl.valueLabel().style().marginTop = 3;
  
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
