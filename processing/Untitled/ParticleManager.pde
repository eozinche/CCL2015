/*
  ParticleManager
  Color Palette "nth hour" from AdobeKuler, by ushanair04 --> Thanks for sharing!
*/


class ParticleManager {
  
  int [] palette = {0x007e0000, 0x00be0000, 0x00e1d5c1, 0x00f5ecd7, 0x00fdfdfd};
 
  PVector O;
  int minRad, maxRad, sqMaxRad; 
 
  Particle [] particles;  
  
  PVector [] trigLUT;
  
  final int 
    //auraColor = 0x25ff9900,
    auraColor = 0x111111,
    trigRes = 360;
  final float
    trigStep = TWO_PI / trigRes,  
    rF = .05,
    gF = 5e-5,  
    c_rad = .3; 
 
  
  /*
   Contructor
  */
  
  ParticleManager (int n, int minRad, int maxRad, int x, int y, int z) {
    O = new PVector (x,y,z);
    this.minRad= minRad;
    this.maxRad= maxRad;
    trigLUT = new PVector [trigRes];
    for (int i=0; i<trigRes; i++) { 
      float angle = i * trigStep;
      trigLUT[i] = new PVector (cos(angle), sin(angle));
      trigLUT[i].mult (minRad);
    }    
    particles = new Particle [n];
    for (int i=0; i<n; i++){
      particles[i] = new Particle();
      resetParticle (particles[i]);
      setParticleColor (particles[i]);
    }
  }
  
  /*
    Methods
  */
  
  void resetParticle (Particle p){
    int alfa = (int) random(trigRes);
    float zF = random (-1,1);
    p.l = new PVector ( O.x + trigLUT[alfa].x, O.y + trigLUT[alfa].y, O.z + minRad*zF);
    p.s = new PVector(random(-1,1),random(-1,1),random(-1,1));
    p.a = new PVector(0,0,0);
    p.setDiameters ( c_rad, 1.25 );
  }
  
  void setParticleColor (Particle p){
    int k = (int) (norm (PVector.dist (p.l, O), maxRad, 0) * 100);
    int i = (int) random (palette.length);
    p.h   = (palette[i] | k<<24);
  }
  
  void display (){
    fill (auraColor);
    for (int i=0; i<particles.length; i++) particles[i].displayAura();
    for (int i=0; i<particles.length; i++) particles[i].display();     
  }

  void update (){
    PVector totalRotation = new PVector(), gravity = new PVector();     
    for (int i=0; i<particles.length; i++) {
      for (int j=0; j<particles.length; j++) {
        totalRotation.add ( particles[i].s.cross (PVector.sub (particles[j].l, particles[i].l)) );
      }
      totalRotation.normalize ();
      totalRotation.mult (rF);
      gravity = PVector.sub (O, particles[i].l);
      gravity.normalize();
      gravity.mult (gF);
      particles[i].update (PVector.add (gravity,totalRotation));
      particles[i].setDiameters ( c_rad, 1.25 );
      if (PVector.dist (particles[i].l,O)>=maxRad) resetParticle (particles[i]); 
    }
  }    
}    
 
