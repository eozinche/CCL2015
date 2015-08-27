/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/136851*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/67904*@* */

/*----------------------------------
 
 Copyright by Diana Lange 2014
 Don't use without any permission
 
 mail: kontakt@diana-lange.de
 web: diana-lange.de
 facebook: https://www.facebook.com/DianaLangeDesign
 flickr: http://www.flickr.com/photos/dianalange/collections/
 tumblr: http://dianalange.tumblr.com/
 twitter: http://twitter.com/DianaOnTheRoad
 
 Based on "Melodic Variations" by Kof:
 http://openprocessing.org/sketch/67904
 
 -----------------------------------*/

import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*; // for BandPass

String [] notesLow, notesHigh, notesMid;

int pitchLow = 1;
int pitchMid = 3;
int pitchHigh = 6;

float[][] vals;
int nn = 10;

String [] notes;

int delayCounter = 0;


float amp = 0.1;
int num = 10;
float dur = 10;

Minim minim;
AudioOutput out;
Waveform disWave;

int cnt = 0;
int melody = 0;

int skip = 4;

ArrayList <Mover> m;

boolean doCopy = true;

void setup()
{
  size( 600, 600);
  smooth();

  frameRate (30);


  // initialize the minim and out objects
  minim = new Minim( this );
  out = minim.getLineOut( Minim.STEREO, 1024 );
  vals = new float[nn][out.bufferSize()];

  colorMode (HSB, 360, 100, 100);

  background(47, 82, 24);
  initMover (out.bufferSize());
  addNotesNow();
  makeScale();
}



void draw() 
{
  if (!doCopy) 
  {
    fill (47, 82, 24, 20);
    noStroke();
    rect (0,0,width, height);
  }

  translate (width/2, height/2);
  rotate (radians (frameCount % 360)*0.25);

  /* make music ----------------------- */
  if (delayCounter > 10 && out.mix.level() < 0.04) 
  {
    delayCounter = 0;
    addNotesNow();
  }
  delayCounter++;

  /* show music ----------------------- */

  float x, y, r;
  float a = TWO_PI / out.bufferSize();

  float basicR = map (out.mix.level(), 0, 0.2, 50, 150);
  float amplitude = map (out.mix.level(), 0, 0.2, 50, 150);

  for (int i = 0; i < out.bufferSize(); i++)
  {
    if (frameCount % 4 == 0)
    {
      r = basicR+out.mix.get(i)*amplitude;
      x = cos (a * i) * r;
      y = sin (a * i) * r;

      m.get (i).setTarget (new PVector (x, y));
    }

    m.get(i).move(); 
  }

  if (out.mix.level() >= 0.2)
  {

    fill (47, 13, 90, map (out.mix.level(), 0.2, 0.3, 80, 180));
    noStroke();

    float d = map (out.mix.level(), 0.2, 0.3, skip, 10);

    int steps = (int) map (out.mix.level(), 0.2, 0.3, 5, 11);

    for (int i = 0; i < out.bufferSize(); i+=steps)
    {
      r = basicR+out.mix.get(i)*amplitude + 20;
      x = cos (a * i) * r;
      y = sin (a * i) * r;

      ellipse ( m.get (i).location.x, m.get (i).location.y, d, d);
    }
  }
  else 
  {
    stroke(47, 13, 90, 120);
    strokeWeight (0.75);
    fill (47, 82, 24, 20);
    beginShape();

    for (int i = 0; i < out.bufferSize(); i+=skip)
    {
      r = basicR+out.mix.get(i)*amplitude;
      x = cos (a * i) * r;
      y = sin (a * i) * r;

      vertex ( m.get (i).location.x, m.get (i).location.y);
    }
    endShape(CLOSE);
  }

  if (doCopy) copy (1, 1, width, height, -1, -1, width+3, height+3);
}

void keyPressed ()
{
  if (key == 's') saveFrame ("export/" + timestamp() + ".png");
  else doCopy = !doCopy;
}


void initMover (int n)
{
  float x, y;
  float a = TWO_PI / n;
  m = new ArrayList();
  for (int i = 0; i < n; i++) 
  {
    x = cos (a * i) * 200;
    y = sin (a * i) * 200;
    m.add (new Mover());
    m.get (m.size()-1).setLocation (x, y);
  }
}

String timestamp ()
{
  String s = "";
  s += nf (year(), 4);
  s += nf (month(), 2);
  s += nf (day(), 2);
  s += "_";
  s += nf (hour(), 2);
  s += nf (minute(), 2);
  s += nf (second(), 2);

  return s;
}

