ArrayList<Integer> leftlx=new ArrayList<Integer>(), leftly = new ArrayList<Integer>();
ArrayList<Integer> rightlx=new ArrayList<Integer>(), rightly = new ArrayList<Integer>();
ArrayList<Integer> Tx=new ArrayList<Integer>(), Ty = new ArrayList<Integer>();
ArrayList<Integer> Ix=new ArrayList<Integer>(), Iy = new ArrayList<Integer>();
ArrayList<Integer> Ox=new ArrayList<Integer>(), Oy = new ArrayList<Integer>();
ArrayList<Integer> Zx=new ArrayList<Integer>(), Zy = new ArrayList<Integer>();
ArrayList<Integer> Sx=new ArrayList<Integer>(), Sy = new ArrayList<Integer>();

ArrayList<ArrayList<Integer>> shapesx = new ArrayList<ArrayList<Integer>>(); 
ArrayList<ArrayList<Integer>> shapesy = new ArrayList<ArrayList<Integer>>();

ArrayList<ArrayList<Integer>> pile = new ArrayList<ArrayList<Integer>>(); 

ArrayList<Integer> currentx;
ArrayList<Integer> currenty;
int w = 30, h = 30, bs=20;
boolean rotationvalid=true;

ArrayList<Integer>arraycopy(ArrayList<Integer> ar)
{
  ArrayList<Integer> newar = new ArrayList<Integer>();
  
  for(int i = 0;i < ar.size();i++) {
    newar.add(i, ar.get(i));
  }
  return newar;
}

boolean hitbottom(ArrayList<Integer> x, ArrayList<Integer> y)
{
    boolean hit = false;

    // Check if we hit the bottom or another shape at
    // the bottom
    for (int i = 0; i < y.size() && !hit;i++) {
      if (y.get(i) > h - 1) {
        hit = true;
        break;
      } else {
        ArrayList<Integer> har = pile.get(y.get(i));
        for (int j = 0;j < w;j++) {
          if (har.get(j) == 1 && x.get(i) == j) {
            hit = true;
            break;
          }
        }
      }
    }
    return hit;
}

void drawshape(ArrayList<Integer> x, ArrayList<Integer> y)
{
  fill(random(255), random(255), random(255));
  for (int i = 0; i < x.size();i++) {
    rect(x.get(i) * bs, y.get(i) * bs, bs, bs);
  }
}

void drawpile()
{
  // Save current shape values in pilex and piley
  fill(random(255), random(255), random(255));
  for(int i = 0;i < h;i++) {
    ArrayList<Integer> har = pile.get(i);
    for (int j = 0;j < w;j++) {
      if (har.get(j) == 1) {
        rect(j * bs, i * bs, bs, bs);
      }
    }
  }
}

void moveleft(ArrayList<Integer> x, ArrayList<Integer> y)
{
   if (hitbottom(x, y)) {
     return;
   }
   int lowestx = 35;
   for (int i = 0; i < x.size();i++) {
      if (lowestx > x.get(i)) {
        lowestx = x.get(i);
      }
    }
   if (lowestx > 0) {
      for (int i = 0; i < x.size();i++) {
        int var = x.get(i);
        x.remove(i);
        x.add(i, var-1);
      }
   }
   return;
}

void moveright(ArrayList<Integer> x, ArrayList<Integer> y)
{
    if (hitbottom(x, y)) {
      return;
    }
    int highestx = 0;
    for (int i = 0; i < x.size();i++) {
      if (highestx < x.get(i)) {
        highestx = x.get(i);
      }
    }
    if(highestx < w-1) {
      for (int i = 0; i < x.size();i++) {
        int var = x.get(i);
        x.remove(i);
        x.add(i, var+1);
      }
    }
    return;
}

void movedown(ArrayList<Integer> x, ArrayList<Integer> y )
{
    if (!hitbottom(x, y)) {
      for (int i = 0; i < y.size();i++) {
        y.add(i, y.remove(i) + 1);
      }
    }
    return;
}

void rotate(ArrayList<Integer> shapex, ArrayList<Integer> shapey )
{
    if (hitbottom(shapex, shapey)) {
      return;
    }
    
    // Translate
    int pointx = shapex.get(1);
    int pointy = shapey.get(1);
    
    for (int i = 0;i < 4;i++) {
      shapex.add(i, shapex.remove(i)-pointx);
      shapey.add(i, shapey.remove(i)-pointy);
    }
    
    // Rotate
    for (int i=0; i < shapex.size();i++) {
      int x = shapex.remove(i);
      int y = shapey.remove(i);
      if (y < 0) {
        int tmp = x;
        x=-1 * y;
        y=tmp;
      } else if (x > 0) {
        int tmp = y;
        y=x;
        x=-1*tmp;
      } else if (y > 0) {
        int tmp = x;
        x = -1 * y;
        y=tmp;
      } else if (x < 0) {
        int tmp = y;
        y=x;
        x=-1*tmp;
      }
      shapex.add(i, x);
      shapey.add(i, y);
    }
    
    // Translate
    for (int i = 0;i < 4;i++) {
      shapex.add(i, shapex.remove(i)+pointx);
      shapey.add(i, shapey.remove(i)+pointy);
    }
}

void setup() {
  background(255);
  size(600, 600);
  
  // Left L
  leftlx.add(0);leftlx.add(0);leftlx.add(1);leftlx.add(2);
  leftly.add(0);leftly.add(1);leftly.add(1);leftly.add(1);
  
  //Right L
  rightly.add(0);rightly.add(1);rightly.add(1);rightly.add(1);
  rightlx.add(2);rightlx.add(2);rightlx.add(1);rightlx.add(0);
  
  // T
  Ty.add(0);Ty.add(0);Ty.add(1);Ty.add(0);
  Tx.add(0);Tx.add(1);Tx.add(1);Tx.add(2);
  
  //I
  Iy.add(0);Iy.add(0);Iy.add(0);Iy.add(0);
  Ix.add(0);Ix.add(1);Ix.add(2);Ix.add(3);
  
  //O
  Oy.add(0);Oy.add(0);Oy.add(1);Oy.add(1);
  Ox.add(0);Ox.add(1);Ox.add(0);Ox.add(1);
  
  //Z
  Zy.add(0);Zy.add(0);Zy.add(1);Zy.add(1);
  Zx.add(0);Zx.add(1);Zx.add(2);Zx.add(1);
  
  //S
  Sy.add(0);Sy.add(1);Sy.add(0);Sy.add(1);
  Sx.add(1);Sx.add(0);Sx.add(2);Sx.add(1);
  
  shapesx.add(leftlx);shapesx.add(rightlx);shapesx.add(Tx);shapesx.add(Ix);shapesx.add(Ox);shapesx.add(Zx);shapesx.add(Sx);
  shapesy.add(leftly);shapesy.add(rightly);shapesy.add(Ty);shapesy.add(Iy);shapesy.add(Oy);shapesy.add(Zy);shapesy.add(Sy);
  
        
  for (int i = 0;i < h;i++) {
    ArrayList<Integer> har = new ArrayList<Integer>();
    pile.add(i, har);
    for (int j = 0; j < w;j++) {
      har.add(j, 0);
    }
  }
  int index = (int)random(7);
  
  currentx = arraycopy(shapesx.get(index));
  currenty = arraycopy(shapesy.get(index));
  
  //rotationvalid = false;
}

void draw() 
{
  if(frameCount%15==0) {
    movedown(currentx, currenty);
    background(255); 
    drawpile();
    for (int i = 0; i < w; i++) 
      line (i * bs, 0, i * bs, height);
    for (int i = 0; i < h; i++) 
      line (0, i * bs, width, i * bs);


    if (hitbottom(currentx, currenty)) {
      // Save current shape values in pilex and piley
      for(int i = 0;i < currenty.size();i++) {
        if (currenty.get(i) != 0) {
          ArrayList<Integer> har = pile.get(currenty.get(i)-1);
          har.set(currentx.get(i), 1);
        } else {
          // Game over
          fill(0);
          textSize(30);
          text("GAME OVER. Press space", width/4, height/2); 
          return;
        }
      }
      
      //Clear any rows that are complete
      for(int i = 0;i < currenty.size();i++) {
        ArrayList<Integer> har = pile.get(currenty.get(i)-1);
        boolean rowfull = true;
        for(int j = 0;j < w;j++) {
          if (har.get(j) == 0) {
            rowfull = false;
            break;
          }
        }
        if (rowfull) {
          pile.remove(currenty.get(i)-1);
          ArrayList<Integer> newhar = new ArrayList<Integer>();
          pile.add(i, har);
          for (int j = 0; j < w;j++) {
            har.add(j, 0);
          }
        }
      }
      
      int index = (int)random(7);
      currentx = arraycopy(shapesx.get(index));
      currenty = arraycopy(shapesy.get(index));
    } else {
      // Draw current shape
      drawshape(currentx, currenty);
    }
  }
}

void keyPressed() {
  if (keyCode==LEFT) {
    moveleft(currentx, currenty);
  } else if (keyCode==RIGHT) {
    moveright(currentx, currenty);
  } else if(keyCode ==DOWN) {
    movedown(currentx, currenty);
  } else if(keyCode == UP && rotationvalid) {
    rotate(currentx, currenty);
  }
}

