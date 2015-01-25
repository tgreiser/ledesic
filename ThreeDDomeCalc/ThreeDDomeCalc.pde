Table table;
Table map;
Table out;
TableRow row;
TableRow orow;

// The total dimensions are originally
// 1200 x 1200

// Going to run
// x = x + 10
// y = -y + 1200

// adjusted / 2.666667 to
// 450 x 450
void setup() {
  
  table = loadTable("dome.txt", "header, tsv");
  map = loadTable("full_dome_overlay.txt", "header, tsv");
  out = new Table();
  out.addColumn("led");
  out.addColumn("x");
  out.addColumn("y");
  out.addColumn("z");

  println(table.getRowCount() + " total rows in table"); 

  for (TableRow row : map.rows()) {
    
    int id = row.getInt("index");
    int section = row.getInt("section");
    int bar = row.getInt("bar");
    int led = row.getInt("led");
    int num_leds = row.getInt("num_leds");
    
    if (id == 0 && section == 0) {
      for (int iX = 0; iX < num_leds; iX++) { 
        orow = out.addRow();
        orow.setInt("led", led + iX);
        println("Filled: " +(led + iX));
        continue;
      }
      continue;
    }
    
    //String section = row.getString("Section");
    //String bar = row.getString("Bar");
    println(led + " Fetching " + id);
    float x1 = table.getFloat(id, "x1");
    float y1 = table.getFloat(id, "y1");
    float z1 = table.getFloat(id, "z1");
    
    float x2 = table.getFloat(id, "x2");
    float y2 = table.getFloat(id, "y2");
    float z2 = table.getFloat(id, "z2");
        
    
    float[] xs, ys, zs;
    if (row.getInt("reverse") == 1) {
      xs = interpolate(x2, x1, num_leds);
      ys = interpolate(y2, y1, num_leds); 
      zs = interpolate(z2, z1, num_leds);
    } else {
      xs = interpolate(x1, x2, num_leds);
      ys = interpolate(y1, y2, num_leds); 
      zs = interpolate(z1, z2, num_leds);
    }
    
    //println(id + " " + x1 + "x"+ y1 + " to " + x2 + "x" + y2 + " and " + z1 + "x"+ z2);
    //println(xs);
    //println(ys);
    //println(zs);
   
    
    if (section <= 0) { continue; }
    
    for (int iX = 0; iX < num_leds; iX++) {
      orow = out.addRow();
      orow.setInt("led", led + iX);
      orow.setFloat("x", xs[iX]);
      orow.setFloat("y", ys[iX]);
      orow.setFloat("z", zs[iX]);
    //  println("opc.led(" + (id+iX) + ", " + int(xs[iX]) + ", " + int(ys[iX]) + ");");
    }
    
  }
  saveTable(out, "data/points.txt", "tsv");
}

float[] interpolate(float p1, float p2, int times) {
  float[] ret = new float [times];
  times++;
  for (int iX = 1; iX < times; iX++) {
    float mult = float(iX) / float(times);
    float inv = 1.0 - mult;
    ret[iX-1] = (p1 * mult + p2 * inv);
  }
  return ret; 
}
