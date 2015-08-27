class Grid
{
  PVector position;
  int xRes, yRes, frameCounter = 0, col;
  float xSpace, ySpace, factor;
  ArrayList elements;
  boolean dir = false;

  Grid (int xRes_, int yRes_, float xSpace_, float ySpace_, PVector position_)
  {
    xRes = xRes_;
    yRes = yRes_;
    xSpace = xSpace_;
    ySpace = ySpace_;
    position = position_;
    factor = 0.9;
    col = 1;
    elements = new ArrayList();

    for (int i = 0; i < yRes; i++)
    {
      elements.add (new Element (0));
    }
  }

  Grid (int xRes_, int yRes_, float xSpace_, float ySpace_)
  {
    xRes = xRes_;
    yRes = yRes_;
    xSpace = xSpace_;
    ySpace = ySpace_;
    factor = 0.9;
    col = 1;
    position = new PVector (0, 0, 0); 
    elements = new ArrayList ();

    for (int i = 0; i < yRes; i++)
    {
      elements.add (new Element (0));
    }
  }

  void setDir (boolean dir)
  {
    this.dir = dir;
  }

  boolean getDir ()
  {
    return dir;
  } 

  void setFrameCounter (int frameCounter_)
  {
    frameCounter = frameCounter_;
  }

  void addFFT ()
  {
    float [] oldfft = new float [yRes];

    // erste reihe in oldfft speichern
    for (int i = 0; i < yRes; i++)
    {
      Element t = (Element) elements.get (i);
      oldfft [i] = t.getData() * 0.9;
    }

    float [] fft = music.getFFT (frameCounter);
    float z = 0;

    for (int i = 0; i < yRes; i++)
    { //i >>

      z = (fft [i]+oldfft[i]) * factor;
      elements.add (i, new Element((double) z));
    }
  }

  void copyFFT ()
  {
    float [] fft = new float [yRes];

    // erste reihe in fft speichern
    for (int i = 0; i < yRes; i++)
    {
      Element t = (Element) elements.get (i);
      fft [i] = t.getData() * 0.9;
    }

    //neue erste reihe erstellen
    for (int i = 0; i < yRes; i++)
    {
      elements.add (i, new Element(fft [i] ));
    }
  }

  void removeFFT ()
  {
    for (int i = 0; i < elements.size(); i++)
    {
      Element t = (Element) elements.get (i);
      int id = t.getID();

      if (id > yRes) 
      {
        elements.remove (i);
      }
      else {
        id++;
        t.setID (id);
      }
    }
  }

  int getColor ()
  {
    return col;
  }

  void setColor (int col)
  {
    this.col = col;
    if (this.col > 2) this.col = 0;
  }

  void beat ()
  {

    if (music.getBeat(frameCounter) >= 1) addFFT ();
    else {
      copyFFT ();
      removeFFT ();
    }
  }

  void displayColor (float data, float maxData)
  {
    switch (col)
    {
    case 0:
      float h = map (data, 1, maxData, 0, 360);
      noStroke();
      fill (h, 90, 90, 60);
      break;

    case 1:
      float b = map (data, 1, maxData, 70, 30);
      noStroke();
      fill (0, 0, b, 255);
      break;

    case 2:
      noFill ();
      strokeWeight (0.75);
      stroke (5, 60);
      break;

    default:
      h = map (data, 1, maxData, 0, 360);
      noStroke();
      fill (h, 90, 90, 60);
      break;
    }
  }

  void display ()
  { 

    noStroke();

    float sphereSize = music.getFFTTotalAverage() * 10.0;

    for (int i = 0; i < yRes; i++)
    { 

      beginShape(TRIANGLE_STRIP);

      for (int j = 0; j < xRes; j++)
      {

        int index =  i * xRes + j, index2 = (i+1) * xRes + j;

        index = constrain (index, 0, elements.size()-1);
        Element t = (Element) elements.get(index);
        Element t2 = null;
        if (i+1 < yRes) t2 = (Element) elements.get(constrain (index2, 0, elements.size()-1));
        else t2 = (Element) elements.get(j);


        PVector pos1 = new PVector (position.x+(sphereSize+t.getData()) * sin (radians (i*360/yRes)) * cos (radians (j*360/xRes)), position.y+(sphereSize+t.getData()) * sin (radians (i*360/yRes)) * sin (radians (j*360/xRes)), position.z+(sphereSize+t.getData()) * cos (radians (i*360/yRes)));
        PVector pos2 = new PVector (position.x+(sphereSize+t2.getData()) * sin (radians ((i+1)*360/yRes)) * cos (radians ((j)*360/xRes)), position.y+(sphereSize+t2.getData()) * sin (radians ((i+1)*360/yRes)) * sin (radians ((j)*360/xRes)), position.z+(sphereSize+t2.getData()) * cos (radians ((i+1)*360/yRes)));

        if (dir)
        {
          pos1 = new PVector (position.x+(sphereSize+t.getData()) * sin (radians (j*360/yRes)) * cos (radians (i*360/xRes)), position.y+(sphereSize+t.getData()) * sin (radians (j*360/yRes)) * sin (radians (i*360/xRes)), position.z+(sphereSize+t.getData()) * cos (radians (j*360/yRes)));
          pos2 = new PVector (position.x+(sphereSize+t2.getData()) * sin (radians ((j)*360/yRes)) * cos (radians ((i+1)*360/xRes)), position.y+(sphereSize+t2.getData()) * sin (radians ((j)*360/yRes)) * sin (radians ((i+1)*360/xRes)), position.z+(sphereSize+t2.getData()) * cos (radians ((j)*360/yRes)));
        }


        displayColor (t.getData()/factor, music.getFFTMax ());


        vertex (pos1.x, pos1.y, pos1.z);
        vertex (pos2.x, pos2.y, pos2.z);
      } 
      endShape();
    }
  }
}

class Element 
{
  double data;

  int id;

  Element (double data)
  {
    this.data=data;
    setID (0);
  }

  Element (double data, int id)
  {
    this.data=data;
    this.id = id;
  }

  float getData ()
  {
    return (float) data;
  }

  void setData (float f)
  {
    data *= f;
  }
  int getID ()
  {
    return id;
  }

  void setID (int id_)
  {
    id = id_;
  }
}

