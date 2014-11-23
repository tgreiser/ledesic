Table table;

// The total dimensions are originally
// 1200 x 1200

// Going to run
// x = x + 10
// y = -y + 1200

// adjusted / 2.666667 to
// 450 x 450
void setup() {
  
  table = loadTable("bars.csv", "header");

  println(table.getRowCount() + " total rows in table"); 

  for (TableRow row : table.rows()) {
    
    int id = row.getInt("index");
    String section = row.getString("section");
    String bar = row.getString("bar");
    int x1 = int(float(row.getInt("x1")+10) / 2.666667);
    int x2 = int(float(row.getInt("x2")+10) / 2.666667);
    
    float ty1 = float(row.getInt("y1")*-1);
    ty1 += 1200;
    
    int y1 = int(ty1 / 2.666667);
    
    float ty2 = float(row.getInt("y2")*-1);
    ty2 += 1200;
    
    int y2 = int(ty2 / 2.666667);
    
    int num_leds = 4;
    float[] xs = interpolate(x1, x2, num_leds);
    float[] ys = interpolate(y1, y2, num_leds); 
    
    //println(section + "." + bar + " " + x1 + "x"+ y1 + " to " + x2 + "x" + y2);
    //println(xs);
    //println(ys);
    
    for (int iX = 0; iX < num_leds; iX++) {
      println("opc.led(" + (id+iX) + ", " + int(xs[iX]) + ", " + int(ys[iX]) + ");");
    }
    
  }
  
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
