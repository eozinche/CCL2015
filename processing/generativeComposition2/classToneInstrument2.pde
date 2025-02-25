/* 
Code by Kryštof Pešek (Kof) and minim
http://openprocessing.org/user/3942/

*/

class ToneInstrument2 implements Instrument
{
  // create all variables that must be used throughout the class
  Oscil toneOsc;
  ADSR adsr;
  AudioOutput out;
  Delay myDelay1;
  Damp  damp;
   
  BitCrush bitCrush;
  Line crushLine;
   
  // constructors for this intsrument
  ToneInstrument2( String note, float amplitude, Waveform wave, AudioOutput output )
  {
    // equate class variables to constructor variables as necessary
    out = output;
     
    bitCrush = new BitCrush(random(0,10.0));
    crushLine = new Line(0.1, random(0.1,50.0), random(0.01,40));
    crushLine.patch(bitCrush.bitRes);
     
    // make any calculations necessary for the new UGen objects
    // this turns a note name into a frequency
    float frequency = Frequency.ofPitch( note ).asHz();
     
    // create new instances of any UGen objects as necessary
    toneOsc = new Oscil( frequency, amplitude, wave );
    adsr = new ADSR( 1.0, 0.8, 0.01, 1.0, 0.1 );
    damp = new Damp( random(0.0001,1.0), random(0.001,2.0) );
     
    myDelay1 = new Delay( random(0.0,10.0), random(0.0,10.0), true, false );
     
     
    Summer sum = new Summer();
  
     toneOsc.patch(bitCrush).patch( sum ).patch(myDelay1).patch(damp);
    // patch everything together up to the final output
    toneOsc.patch( adsr );
  }
   
  // every instrument must have a noteOn( float ) method
  void noteOn( float dur )
  {
    // turn on the adsr
    adsr.noteOn();
    // patch the adsr into the output
    adsr.patch(bitCrush);
     
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
