/* 
Code by Kryštof Pešek (Kof) and minim
http://openprocessing.org/user/3942/

*/

class ToneInstrument implements Instrument
{
  // create all variables that must be used throughout the class
  Oscil toneOsc;
  ADSR adsr;
  AudioOutput out;
  Delay myDelay1;
  Damp  damp;
  
 // BitCrush bitCrush;
  Line crushLine;
  
  // constructors for this intsrument
  ToneInstrument( String note, float amplitude, Waveform wave, AudioOutput output )
  {
    // equate class variables to constructor variables as necessary
    out = output;
    
    //bitCrush = new BitCrush(random(0,10.0));
   // crushLine = new Line(0.1, random(0.1,50.0), random(0.01,40));
   // crushLine.patch(bitCrush.bitRes);
    
    // make any calculations necessary for the new UGen objects
    // this turns a note name into a frequency
    float frequency = Frequency.ofPitch( note ).asHz();
    
    // create new instances of any UGen objects as necessary
    toneOsc = new Oscil( frequency, amplitude, wave );
    adsr = new ADSR( random (0.5, 1), random (0.8, 1), random (0.001, 0.2), random (0.7, 1.0), random (0.05, 0.15) );
    damp = new Damp( random(0.0001,5.0), random(0.001,10.0) );
    
    myDelay1 = new Delay( random(0.0,100.0), amplitude /*random(0.0,100.0)*/, true, false );
    
    
    Summer sum = new Summer();
 
     toneOsc.patch( sum ).patch(damp).patch(myDelay1);
    // patch everything together up to the final output
    toneOsc.patch( adsr );
  }
  
  // every instrument must have a noteOn( float ) method
  void noteOn( float dur )
  {
    // turn on the adsr
    adsr.noteOn();
    // patch the adsr into the output
    //adsr.patch(bitCrush);
    
    // set the damp time from the duration given to the note
    damp.setDampTimeFromDuration( dur );
    // activate the damp
    damp.activate();
    
    
    adsr.patch( out );
  }
  
  void noteOff()
  {
    // turn off the note in the adsr
    adsr.noteOff();
   // adsr.unpatchAfterRelease(bitCrush);
    // but don't unpatch until the release is through
    
    damp.unpatchAfterDamp( out );
    
    adsr.unpatchAfterRelease( out );
  }
}
