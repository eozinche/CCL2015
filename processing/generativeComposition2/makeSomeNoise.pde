void addNotesNow() 
{
  setNotes();
  makeScale();

  pitchLow = (int)random(1, 3);
  pitchMid = (int)random(3, 6);

  pitchHigh = (int)random(6, 8);
  
  float dice = (int) random (10);
  
  if (dice < 30) dur = 2;
  else if (dice >= 30 && dice < 40) dur = 3;
  else if (dice >= 40 && dice < 50) dur = 4;
  else if (dice >= 50 && dice < 70) dur = 5;
  else if (dice >= 70 && dice < 75) dur = 6;
  else if (dice >= 75 && dice < 80) dur = 7;
  else if (dice >= 80 && dice < 85) dur = 9;
  else if (dice >= 85 && dice < 95) dur = 10;
  else dur = 15;

 // dur = (int) random (1, 10);
  out.setVolume(random (-1, 1));
  num = (int) random (10);


  float [] rDur = { 
    random (0.5, 1), random (0.5, 1), random (0.5, 1)
  };

  for (int i = 0 ; i < notes.length ; i++ ) 
  {
    dice = (int) random (3);
    
    if (dice == 0)
    {
     out.playNote( i*(dur*rDur [0]/(notes.length+0.0))+random(-1.0, 1.0), (dur*rDur [0]/(notes.length+0.0)+random(0.0, 1.0)), new ToneInstrument( notesLow[i]+" ", amp, disWave, out ) );
    out.playNote( i*(dur*rDur [1]/(notes.length+0.0))+random(-1.0, 1.0), (dur*rDur [1]/(notes.length+0.0)+random(0.0, 1.0)), new ToneInstrument (notesMid[i]+" ", amp, disWave, out ) );
    out.playNote( i*(dur*rDur [2]/(notes.length+0.0))+random(-1.0, 1.0), (dur*rDur [1]/(notes.length+0.0)+random(0.0, 1.0)), new ToneInstrument( notesHigh[i]+" ", amp, disWave, out ) ); 
    }
    else 
    {
    out.playNote( i*(dur*rDur [0]/(notes.length+0.0))+random(-1.0, 1.0), (dur*rDur [0]/(notes.length+0.0)+random(0.0, 1.0)), new ToneInstrument2( notesLow[i]+" ", amp, disWave, out ) );
    out.playNote( i*(dur*rDur [1]/(notes.length+0.0))+random(-1.0, 1.0), (dur*rDur [1]/(notes.length+0.0)+random(0.0, 1.0)), new ToneInstrument2( notesMid[i]+" ", amp, disWave, out ) );
    out.playNote( i*(dur*rDur [2]/(notes.length+0.0))+random(-1.0, 1.0), (dur*rDur [1]/(notes.length+0.0)+random(0.0, 1.0)), new ToneInstrument2( notesHigh[i]+" ", amp, disWave, out ) );
    }
  }


  out.setDurationFactor(random (0.1, 2));


  cnt++;

  if (cnt%2==0)melody++;

  String s;
  int n1, n2, pos = melody%notes.length;

  char c = notes [pos].charAt (0);

  switch(c) 
  {

  case 'c':
  case 'C':
    s = "C";
    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;

  case 'D':
  case 'd':

    s = "D";
    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;

  case 'E':
  case 'e':

    s = "E";
    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;

  case 'F':
  case 'f':

    s = "F";
    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;


  case 'g':
  case 'G':

    s = "G";

    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;

  case 'a':
  case 'A':

    s = "A";
    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;

  case 'h':
  case 'H':

    s = "H";
    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;


  default:

    s = "C";
    n1 = (int) random (3);
    n2 = (int) random (n1, 7);

    out.playNote( 1.f, 4.4f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n1)).asHz(), 0.1, out ) );
    out.playNote( 1.2f, 1.2f, new WaveShaperInstrument( Frequency.ofPitch(s + str (n2)).asHz(), 0.1, out ) );
    break;
  }
}

void setNotes ()
{
  noiseSeed (year() + month() + day() + hour() + minute());
  noiseDetail (10, 0.5);
  int notesLength = 1 + (int) noise (frameCount / 50) * 7;
  notes = new String [notesLength];

  float noiseVal;
  float noiseScale = random (20, 100);
  noiseDetail ((int) random (10), random (0.4, 0.6));

  for (int i = 0; i < notes.length; i++)
  {
    noiseVal = noise (frameCount /noiseScale + i / noiseScale);
    noiseVal = map (noiseVal, 0, 1, 0, notes.length);

    notes [i] = getNoteByValue ((int) noiseVal);
  }
}

String getNoteByValue (int val)
{
  if (val == 0) return "C";
  else if (val == 1) return "D";
  else if (val == 2) return "E";
  else if (val == 3) return "F";
  else if (val == 4) return "G";
  else if (val == 5) return "A";
  else if (val == 6) return "H";
  else return "C";
}

void makeScale() {

  if (random(50)<40) {
    disWave = Waves.SINE;
  }
  else {
    disWave = Waves.TRIANGLE;
  }

  notesLow = new String[notes.length];
  notesMid = new String[notes.length];

  notesHigh = new String[notes.length];

  for (int i = 0 ; i < notes.length;i++) {
    notesLow[i] = notes[i]+""+pitchLow;
    notesMid[i] = notes[i]+""+pitchMid;

    notesHigh[i] = notes[i]+""+pitchHigh;
  }
}

void stop()
{

  out.close();
  minim.stop();
  super.stop();
}

