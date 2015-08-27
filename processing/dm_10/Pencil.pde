//Pencil class//////////////Almost simplest particle class

class Pencil {
  
  PVector l;  //location
  int p_hue;  //hue
 
  //CONSTRUCTOR
  Pencil (PVector l){this.l=l;}
 
  //METHODS 
  void display(){
    point(l.x,l.y);
  }
  
  //Main updating method 
  //Very straight-forward -- we calculate the vector that links force and particle and we scale it with
  //the inverse of the distance to make that force less powerful as the p goes further
  void update (PVector f,float sc){  
    PVector toF=PVector.sub(l,f);  //this is the vector that expulses the particle far from the force
    float dF=toF.mag();            //this is the magnitude of that vector: the distance 
    toF.normalize();               //we normalize force
    toF.mult(sc/dF);               //and scale it with an arbitrary factor plus the inverse of the distance
    l.add(toF);                    //we add it to location
  }
  
  //get&set
  PVector getL(){return l;}
  int getH(){return p_hue;}
  void setH(int hue_to_set){p_hue=hue_to_set;}
  
}
