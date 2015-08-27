void createTriangles (int noiseNum, float noiseScale, int octaves, float falloff)
{
 
  tt = new ArrayList();
  int i, j, index, index2;
  PVector p1, p2, p3;
  

  for (int k= 0; k < dots.size(); k++)
  {
    i = (int) ids.get(k).y;
    j = (int) ids.get(k).x;
 
 
    if (i % 2 == 0) // even rows
    {
      /* first triangle ----------------------------------------------------------------*/
 
      p1 = new PVector (dots.get(k).x, dots.get(k).y);
      index = findIndex (ids, k, j, i+1);
      if (index == -1) continue;
      p2 = new PVector (dots.get(index).x, dots.get(index).y);
      index2 = findIndex (ids, k, j+1, i);
      if (index2 == -1) continue;
      p3 = new PVector (dots.get(index2).x, dots.get(index2).y);
 
      if (j == 0)                                       // first triangle in each row
      {
        tt.add (new DianaTriangle (p1, new PVector (0, p2.y), p2));
      }
      tt.add (new DianaTriangle (p1, p2, p3));          // create triangle
 
      if (p3.x == W)                                   // last triangle in each row
      {
        tt.add (new DianaTriangle (p3, p2, new PVector (W, p2.y)));
      }
 
 
 
      /* second triangle ----------------------------------------------------------------*/
 
      p1 = new PVector (dots.get(k).x, dots.get(k).y);
      index = findIndex (ids, k, j-1, i+1);
      if (index == -1) continue;
      p2 = new PVector (dots.get(index).x, dots.get(index).y);
      index = findIndex (ids, k, j, i+1);
      if (index == -1) continue;
      p3 = new PVector (dots.get(index).x, dots.get(index).y);
      tt.add (new DianaTriangle (p1, p2, p3));         // create triangle
    }
    else // even rows
    {
      /* first triangle ----------------------------------------------------------------*/
 
      p1 = new PVector (dots.get(k).x, dots.get(k).y);
      index = findIndex (ids, k, j, i+1);
      if (index == -1) continue;
      p2 = new PVector (dots.get(index).x, dots.get(index).y);
      index2 = findIndex (ids, k, j+1, i+1);
      if (index2 == -1) continue;
      p3 = new PVector (dots.get(index2).x, dots.get(index2).y);
 
      if (j == 0)                                      // first triangle in each row
      {
        tt.add (new DianaTriangle (p1, new PVector (0, p1.y), new PVector (0, p2.y) ));
      }   
      tt.add (new DianaTriangle (p1, p2, p3));          // create triangle
 
      if (p3.x == W)                                   // last triangle in each row
      {
        tt.add (new DianaTriangle (p1, p3, new PVector (W, p1.y)  ));
      }
 
 
 
      /* second triangle ----------------------------------------------------------------*/
 
      p1 = new PVector (dots.get(k).x, dots.get(k).y);
      index = findIndex (ids, k-1, j-1, i);
      if (index == -1) continue;
      p2 = new PVector (dots.get(index).x, dots.get(index).y);
      index2 = findIndex (ids, k, j, i+1);
      if (index2 == -1) continue;
      p3 = new PVector (dots.get(index2).x, dots.get(index2).y);
      tt.add (new DianaTriangle (p1, p2, p3));
    }
  }
 
  /* colorize triangles ---------------------------------------------------*/
 
   noiseSeed (noiseNum);
  noiseDetail (octaves, falloff);
  float noiseValue;
 
  int count = 0;
  while (count < tt.size ())
  {
    p1 = tt.get (count).getCendoid();
    
    noiseValue = noise (p1.x / noiseScale, p1.y / noiseScale) * 255;
    
    tt.get (count).setColor (color (noiseValue));
    
    count++;
  }
  
  /* Z Values --------------------*/
  
  count = 0;
  float z1, z2, z3;
  
  float lowestValue = DEPTH + NOISEDEPTH, highestValue = 0;
  
  while (count < tt.size ())
  {
    p1 = tt.get (count).getP1();
    p2 = tt.get (count).getP2();
    p3 = tt.get (count).getP3();
    
    noiseValue = noise (p1.x / noiseScale, p1.y / noiseScale) * NOISEDEPTH;
    z1 = noiseValue;
    
    noiseValue = noise (p2.x / noiseScale, p2.y / noiseScale) * NOISEDEPTH;
    z2 = noiseValue;
    
    noiseValue = noise (p3.x / noiseScale, p3.y / noiseScale) * NOISEDEPTH;
    z3 = noiseValue;
    
    tt.get (count).setZ (z1+DEPTH, z2+DEPTH, z3+DEPTH);
    
    if (z1 > highestValue) highestValue = z1;
    if (z2 > highestValue) highestValue = z2;
    if (z3 > highestValue) highestValue = z3;
    
    if (z1 < lowestValue) lowestValue = z1;
    if (z2 < lowestValue) lowestValue = z2;
    if (z3 < lowestValue) lowestValue = z3;
    
    count++;
  }
  
  count = 0;
  float dis;
   float maxDis = dist (0,0,W, H);
  
  while (count < tt.size ())
  {
    p1 = tt.get (count).getP1();
    p2 = tt.get (count).getP2();
    p3 = tt.get (count).getP3();
    
    dis = dist (0, 0, p1.x, p1.y);
    z1 = DEPTH*map (dis, 0, maxDis, 1.5, 0.25) + map (p1.z-DEPTH, lowestValue, highestValue, 0, NOISEDEPTH) ;
    dis = dist (0, 0, p2.x, p2.y);
    z2 = DEPTH*map (dis, 0, maxDis, 1.5, 0.25)+ map (p2.z-DEPTH, lowestValue, highestValue, 0, NOISEDEPTH);
    dis = dist (0, 0, p3.x, p3.y);
    z3 = DEPTH*map (dis, 0, maxDis, 1.5, 0.25)+map (p3.z-DEPTH, lowestValue, highestValue, 0, NOISEDEPTH);
    
    tt.get (count).setZ (z1, z2, z3);
    
    
    count++;
  }
}
 
 
int findIndex (ArrayList <PVector> rev, int startIndex, float lookupX, float lookupY)
{
  PVector p;
  for (int i = startIndex; i < rev.size(); i++)
  {
    p = rev.get(i);
    if (p.y == lookupY && p.x == lookupX) return i;
  }
  return -1;
}
 
 
ArrayList <PVector> createDots (int padd, int w, int h)
{
  ArrayList <PVector> dots = new ArrayList();
  ids = new ArrayList();
 
  int x = 0, idX = 0, idY = 0;
  int index = 0;
 
  for (int i = 0; i < h; i+=padd)
  {
    idX = 0;
    for (int j = 0; j < w; j+=padd)
    {
      x = ((i / padd) % 2 == 0) ? j : j + padd/2;
 
      index = i*w+x;
      if (x < w)
      {
        dots.add (new PVector (x, i));
        ids.add (new PVector (idX, idY));
      }
      W = j;
      idX++;
    }
    H = i;
    idY++;
  }
 
  return dots;
}
