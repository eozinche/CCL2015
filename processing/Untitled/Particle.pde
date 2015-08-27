/*
  Particle
 */

class Particle {

  float  d1, d2;      
  PVector l, s, a;    
  int h;

  Particle () {
    l = new PVector ();
    s = new PVector ();
    a = new PVector ();
  }

  void setDiameters (float diamCoef, float auraSize) {
    d1 = l.z * diamCoef; 
    d2 = d1  * auraSize;
  }

  void displayAura () {
    ellipse (l.x, l.y, d2, d2);
  }

  void display () {
    fill (h);
    ellipse (l.x, l.y, d1, d1);
  }

  void update (PVector newAcceleration) {
    a.add  (newAcceleration);
    s.add  (a);
    l.add  (s);
    a.mult (0);
  }
}

