Table table;
StringList data;

// The total dimensions are originally
// 1200 x 1200

// Going to run
// x = x + 10
// y = -y + 1200

// adjusted / 2.666667 to
// 450 x 450
void setup() {
  
  table = loadTable("bars-fullsize.csv", "header");

  data = new StringList();
  data.append("public void LED_config(OPC opc) {");
  for (TableRow row : table.rows()) {
    
    int id = row.getInt("index");
    String section = row.getString("Section");
    String bar = row.getString("Bar");
    int x1 = 0;
    int x2 = 0;
    int y1 = 0;
    int y2 = 0;
    if (row.getString("reverse") == "1") {
      x1 = row.getInt("x2");
      x2 = row.getInt("x1");
      y1 = row.getInt("y2");
      y2 = row.getInt("y1");
    } else {
      x1 = row.getInt("x1");
      x2 = row.getInt("x2");
      y1 = row.getInt("y1");
      y2 = row.getInt("y2");
    }
    x1 = int(float(x1+10) / 2.666667);
    x2 = int(float(x2+10) / 2.666667);
    
    float ty1 = float(y1*-1);
    ty1 += 1200;
    
    y1 = int(ty1 / 2.666667);
    
    float ty2 = float(y2*-1);
    ty2 += 1200;
    
    y2 = int(ty2 / 2.666667);
    
    int num_leds = 30;
    float[] xs = interpolate(x1, x2, num_leds);
    float[] ys = interpolate(y1, y2, num_leds); 
    
    //println(section + "." + bar + " " + x1 + "x"+ y1 + " to " + x2 + "x" + y2);
    //println(xs);
    //println(ys);
    
    for (int iX = 0; iX < num_leds; iX++) {
      data.append("\topc.led(" + (id+iX) + ", " + int(xs[iX]) + ", " + int(ys[iX]) + ");");
    }
    
  }
  data.append("}");
  
  // write out file
  saveStrings("data/LED_config.pde", data.array());
  println("Generated LED_config.pde");
}

float[] interpolate(int p1, int p2, int times) {
  float[] ret = new float [times];
  times++;
  for (int iX = 1; iX < times; iX++) {
    float mult = float(iX) / float(times);
    float inv = 1.0 - mult;
    ret[iX-1] = (float(p1) * mult + float(p2) * inv);
  }
  return ret; 
}
