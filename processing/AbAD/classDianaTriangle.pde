class DianaTriangle
{
  PVector [] t;
  color c, cc;

  int mode = 0;

  DianaTriangle (PVector p1, PVector p2, PVector p3)
  {
    this (p1, p2, p3, color(random (0, 120)));
    //println (mode);
  }

  DianaTriangle (PVector p1, PVector p2, PVector p3, color c)
  {
    this.c = c;
    cc = c;
    int dir = (int) random (3);
    if (dir == 0) mode = 0;
    else mode = 1;
    initVectors (p1, p2, p3);
  }

  void initVectors (PVector p1, PVector p2, PVector p3)
  {
    t = new PVector [4];
    for (int i = 0; i < t.length; i++) t [i] = new PVector (0, 0);
    t [0].x = p1.x;
    t [0].y = p1.y;
    t [0].z = 0;

    t [1].x = p2.x;
    t [1].y = p2.y;
    t [1].z = 0;

    t [2].x = p3.x;
    t [2].y = p3.y;
    t [2].z = 0;

    t [3].x = t[getLeft()].x + (abs (t[getRight()].x - t[getLeft()].x)*0.5);
    t [3].y = t[getTop()].y + (abs(t[getBottom()].y - t[getTop()].y)*0.5);
    t [3].z = 0;
  }

  private int getLeft ()
  {
    if (t[0].x <= t[1].x && t[0].x <= t[2].x) return 0;
    if (t[1].x <= t[0].x && t[1].x <= t[2].x) return 1;
    if (t[2].x <= t[0].x && t[2].x <= t[1].x) return 2;
    return 0;
  }

  private int getRight ()
  {
    if (t[0].x >= t[1].x && t[0].x >= t[2].x) return 0;
    if (t[1].x >= t[0].x && t[1].x >= t[2].x) return 1;
    if (t[2].x >= t[0].x && t[2].x >= t[1].x) return 2;
    return 0;
  }

  private int getTop ()
  {
    if (t[0].y <= t[1].y && t[0].y <= t[2].y) return 0;
    if (t[1].y <= t[0].y && t[1].y <= t[2].y) return 1;
    if (t[2].y <= t[0].y && t[2].y <= t[1].y) return 2;
    return 0;
  }

  private int getBottom ()
  {
    if (t[0].y >= t[1].y && t[0].y >= t[2].y) return 0;
    if (t[1].y >= t[0].y && t[1].y >= t[2].y) return 1;
    if (t[2].y >= t[0].y && t[2].y >= t[1].y) return 2;
    return 0;
  }

  void setColor (color c)
  {
    this.c = c;
    cc = c;
  }

  void setColor ()
  {
    c = cc;
  }

  void setZ (float z1, float z2, float z3)
  {
    t[0].z = z1;
    t[1].z = z2;
    t[2].z = z3;
  }

  void lerpTheColor (color c)
  {
    colorMode (HSB);
    this.c = color (hue (c), saturation (c), brightness (cc));
    colorMode (RGB);
  }

  PVector getCendoid ()
  {
    return t[3];
  }

  PVector getP1 ()
  {
    return t[0];
  }

  PVector getP2 ()
  {
    return t[1];
  }

  PVector getP3 ()
  {
    return t[2];
  }

  boolean checkLimit (float minX, float maxX, float minY, float maxY)
  {
    for (int i = 0; i < t.length; i++)
    {

      if (t[i].x < minX) return true;
      if (t[i].x > maxX) return true;

      if (t[i].y < minY) return true;
      if (t[i].y > maxY) return true;
    }
    return false;
  }

  void doLimit (float minX, float maxX, float minY, float maxY)
  {
    for (int i = 0; i < t.length; i++)
    {

      if (t[i].x < minX) t[i].x = minX;
      if (t[i].x > maxX) t[i].x = maxX;

      if (t[i].y < minY) t[i].y = minY;
      if (t[i].y > maxY) t[i].y = maxY;
    }
  }

  void drawOrigin ()
  {
    stroke (0, 20);
    line (t[0].x, t[0].y, 0, t[0].x, t[0].y, t[0].z);
    line (t[1].x, t[1].y, 0, t[1].x, t[1].y, t[1].z);
    line (t[2].x, t[2].y, 0, t[2].x, t[2].y, t[2].z);
  }

  void drawVertex (int MODE)
  {

    if (MODE == 0)
    {
      noStroke ();
      fill (c);
    }
    else if (MODE == 1)
    {
      if (mode == 0)
      {
        noFill();
        stroke (c, 120);
        
      }
      else
      {
        stroke (c, 120);
        fill (c, 120);
      }
    }
    else
    {
      noFill();

      float maxDis = dist (0, 0, W, H);
      float dis = dist (0, 0, t[1].x, t[1].y);

      stroke (0, map (dis, 0, maxDis, 10, 120));
    }
    beginShape();
    for (int i = 0; i < t.length-1; i++)
    {
      vertex (t[i].x, t[i].y, t[i].z);
    }
    endShape(CLOSE);
  }

  void drawBASE()
  {

    noFill();
    stroke (0, 10);


    vertex (t[0].x, t[0].y, 0);
    vertex (t[1].x, t[1].y, 0);
  }
}

