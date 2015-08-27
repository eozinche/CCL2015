class MusicListener 
{
  float [] FFTAverageList;
  float [] [] FFTList;
  int [] beatList;

  float m, b, totalAverageFFT = 0.0;
  int musicLength = 0, FFTLength = 0, beatLength = 0, buffer;

  PVector minMaxFFT = new PVector (1000, 0);


  MusicListener (int buffer)
  {
    this.buffer = buffer;
    b = m = 0.0;
    totalAverageFFT = 0.0;

    loadFFT ();
    loadBeat ();
    setMusicLength ();
  }


  void setMusicLength ()
  {
    if (FFTLength >= beatLength) musicLength = FFTLength;
    else musicLength = beatLength;
  }
  
  int getMusicLength ()
  {
    return musicLength;
  }

  // get values ----------------------------------------------------------------------------
  // ---------------------------------------------------------------------------------------

  float [] getFFT (int frameCounter)
  {
    float [] returnFFTList = new float [buffer];

    frameCounter = constrain (frameCounter, 0, FFTLength-1);


    for (int i = 0; i < returnFFTList.length; i++)
    {
      returnFFTList [i] = FFTList [frameCounter] [i];
    }

    return returnFFTList;
  }


  float getFFTAverage (int frameCounter)
  {

    frameCounter = constrain (frameCounter, 0, FFTLength-1);

    float average = FFTAverageList[frameCounter];
    return average;
  }

  float getFFTAverage (int frameCounter, float min_, float max_)
  {

    frameCounter = constrain (frameCounter, 0, FFTLength-1);

    float average = map (FFTAverageList[frameCounter], minMaxFFT.x, minMaxFFT.y, min_, max_);
    return average;
  }

  float getFFTTotalAverage ()
  {
    return totalAverageFFT;
  }


  float getBeat (int frameCounter)
  {
    float t = 0;

    if (frameCounter < beatLength) {
      if (beatList [frameCounter] == 1) {
        t = b = 1;
      }
      else {
        b *= 0.9;
        t = b;
      }
    }
    else {
      b *= 0.9;
      t = b;
    }

    t = constrain (t, 0, 1);

    return t;
  }

   

  float getFFTMax()
  {
    return minMaxFFT.y;
  }
  
  float getFFTMin()
  {
    return minMaxFFT.x;
  }


  // load all the stuff----------------------------------------------------------------------------------------------------
  // --------------------------------------------------------------------------------------------------------------------------

  void loadFFT ()
  {
    String [] iLines = splitTokens (fftData, ",");
    FFTLength = iLines.length;
    FFTList = new float [FFTLength] [buffer];
    FFTAverageList = new float [FFTLength];

    for (int i = 0; i < iLines.length; i++)
    {
      String [] currentLine = splitTokens (iLines [i], " ");
      float average = 0;
      //println (currentLine.length);
      
      for (int j = 0; j < currentLine.length; j++)
      {
        String data = currentLine [j];
        FFTList [i] [j] = float (data);
        totalAverageFFT += float (data);
        average += float (data);
        
        if (float (data) > minMaxFFT.y) minMaxFFT.y = float (data);
        if (float (data) < minMaxFFT.x) minMaxFFT.x = float (data);
        
      }
      
      average = average / buffer;
      FFTAverageList [i] = average;
    }
    
    totalAverageFFT = totalAverageFFT / FFTLength / buffer;
    
  }

  void loadBeat ()
  {
    String [] iLines = splitTokens (beatData, " ");
    beatLength =  iLines.length;
    beatList = new int [beatLength];
    
    for (int i = 0; i < iLines.length; i++)
    {
      String data = iLines [i];
      beatList [i]= int (data);
    }
  }
}

