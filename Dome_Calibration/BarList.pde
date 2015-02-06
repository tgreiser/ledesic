int HANDLE_SIZE = 6;

class BarList {
  ListBox pts;
  Textfield section;
  Textfield bar;
  Textfield count;
  Textfield index;
  Textfield name;
  
  Bar[] bars;
  int selected = -1;
  Handle h1;
  Handle h2;
  
  int spacer = 10;
  int top = 225+spacer;
  color colForm = color(255);
  color colButton = cp3;
  
  BarList(int align) {
    pts = c5.addListBox("bars")
      .setPosition(align+spacer, 15+top)
      .setSize(230, 205);
    customize(pts, "BARS");
    
    int left = align+spacer*2+230;
    c5.addButton("Import Bars")
      .setPosition(left, top)
      .setColorBackground(colButton)
      .setSize(55, 19);    
    
    c5.addButton("Export Bars")
      .setPosition(left+spacer+55, top)
      .setColorBackground(colButton)
      .setSize(57, 19);
      
    // form
    section = c5.addTextfield("section")
      .setPosition(left, top+30)
      .setSize(55, 19)
      .setColor(colForm);
      
    bar =c5.addTextfield("bar")
      .setPosition(left+spacer+55, top+30)
      .setSize(55, 19)
      .setColor(colForm);
      
    count = c5.addTextfield("count")
      .setPosition(left, top+70)
      .setSize(55, 19)
      .setColor(colForm);
      
    index = c5.addTextfield("index")
      .setPosition(left+spacer+55, top+70)
      .setSize(55, 19)
      .setColor(colForm);
      
    name = c5.addTextfield("name")
      .setPosition(left, top+110)
      .setSize(110+spacer, 19)
      .setColor(colForm);
      
    c5.addButton("Reset")
      .setPosition(left, 420)
      .setColorBackground(colButton)
      .setSize(55, 19);  
    
    c5.addButton("Apply")
      .setColorBackground(colButton)
      .setPosition(left+spacer+55, 420)
      .setSize(55, 19);
  }
  
  boolean isFocus() {
    return section.isFocus() || bar.isFocus() || count.isFocus() || index.isFocus() || name.isFocus();
  }
  
  void leds(OPC opc, int section) {
    for (Bar b : bars) {
      if (b.section == section) {
        b.leds(opc);
      }
    }
  }
  
  // save values to bar, de-select
  void apply() {
    if (selected < 0) { return; }
    saveTextfields();
    
    updateConfig();
    getList(pts);
    
    deselect();
  }
  
  void saveTextfields() {
    bars[selected].section = int(section.getText());
    bars[selected].bar = int(bar.getText());
    bars[selected].count = int(count.getText());
    bars[selected].index = int(index.getText());
    bars[selected].name = name.getText();
  }
  
  // de-select everything, null the handles, trigger revert on the bar.
  void reset() {
    if (selected < 0) { return; }
    bars[selected].revert();
    deselect();
  }
  
  void deselect() {
    unset(selected);
    section.setValue("");
    bar.setValue("");
    count.setValue("");
    index.setValue("");
    name.setValue("");
    selected = -1;
    h1 = null;
    h2 = null;
  }
  
  void importBrowse() {
    deselect();
    selectInput("What config would you like to load?", "loadCallback", new File(sketchPath+"/data/bars.csv"));
  }
  
  void load(String filename) {
    Table table = loadTable(filename, "header");
    
    bars = new Bar[table.getRowCount()];
    int iX = 0;
    for (TableRow row : table.rows()) {
      bars[iX++] = new Bar(row.getString("name"), row.getInt("section"), row.getInt("bar"), row.getInt("index"), row.getInt("count"),
        row.getFloat("x1"), row.getFloat("y1"),
        row.getFloat("x2"), row.getFloat("y2")
        );
    }
    
    getList(pts);
    updateConfig();
  }
  
  void save() {
    apply();
    println("Running selectOutput..");
    selectOutput("Where would you like to save your config?", "saveCallback", new File(sketchPath+"/data/export.csv"));
  }
  
  void saveCallback(File selection) {
    if (selection == null) { return; }
    String fn = selection.getAbsolutePath();
    println("Saving " + fn);
    String[] data = new String[bars.length+1];
    int iX = 1;
    data[0] = "section,bar,x1,y1,x2,y2,index,count,name";
    for (Bar b : bars) {
      data[iX++] = str(b.section)+","+str(b.bar)+","+str(b.x1)+","+str(b.y1)+","+str(b.x2)+","+
        str(b.y2)+","+str(b.index)+","+str(b.count)+","+b.name;
    } // finish CSV TODO
    
    saveStrings(fn, data);
    updateConfig();
  }
  
  void getList(ListBox ddl) {
    ddl.clear();
    for (int iX = 0; iX < bars.length; iX++) {
      ddl.addItem(bars[iX].getListName(), iX);
    }
  }
  
  void selected(int sel) {
    if (sel >= bars.length) { return; }
    
    println("Selecting " + bars[sel].getListName());
    if (selected >=0) {
      // set the old pick back to bg
      unset(selected);
      // we are doing auto-apply here
      saveTextfields();
    }
    selected = sel;
    pts.getItem(selected).setColorBackground(cg2);
    
    bars[sel].backupLocations();
    h1 = new Handle(bars[sel], true, float(HANDLE_SIZE));
    h2 = new Handle(bars[sel], false, float(HANDLE_SIZE));
    
    section.setValue(str(bars[sel].section));
    bar.setValue(str(bars[sel].bar));
    count.setValue(str(bars[sel].count));
    index.setValue(str(bars[sel].index));
    name.setValue(bars[sel].name);
  }
  
  void unset(int index) {
    if (index < 0) { return; }
    ListBoxItem item = pts.getItem(index);
    item.setColorBackground(cb3);
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
  ddl.captionLabel().setColor(0xffff0000);
  ddl.valueLabel().style().marginTop = 3;
  
  //ddl.scroll(0);
  ddl.setColorBackground(color(60));
  ddl.setColorActive(color(255, 128));
}
