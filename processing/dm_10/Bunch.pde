//Bunch class//a class to pack all pencils together///
//////////////////////////////////////////////////////

class Bunch {

 Pencil[] pencils;
 
 float 
 factor;  
 int 
 cols,    
 rows;    
  
  //CONSTRUCTOR
  Bunch (int xg,int yg,float factor){
    cols=width/xg;
    rows=height/yg;
    pencils=new Pencil[cols*rows];
    for (int i=0;i<pencils.length;i++){  
      pencils[i]=new Pencil(new PVector(i%cols*xg,floor(i/cols)*yg));
    }
    this.factor=factor;
  }
  
  //METHODS
  //update is the method that resolves the forces influence. It has two methods:
    //first one//forces are related to distance but they act on the infinity of cosmic space
  void update(Attractor[] attractors){
    for(int i=0;i<pencils.length;i++){
      for (int j=0;j<attractors.length;j++){
        pencils[i].update(attractors[j].getL(),factor);
      }
    }  
  }  
  
    //second one//forces have a quite straight limit, beyond it the influence ends abruptly  
  void update(Attractor[] attractors,float maxDist){
    for(int i=0;i<pencils.length;i++){
      for (int j=0;j<attractors.length;j++){
        float d=PVector.dist(attractors[j].getL(),pencils[i].getL());
        if(d<maxDist){          
          pencils[i].update(attractors[j].getL(),factor);
        }
      }
    }  
  }  
  
  //display methods//very straight forward/////////////////////////////////////////////////
  void displayPoints(){
    for(int i=0;i<pencils.length;i++){
      pencils[i].display();
    }
  }
  
  void displayLines(){
    for(int i=0;i<rows;i++){
      beginShape();
      for(int j=0;j<cols;j++){
        int pos=(i*cols)+j;
        PVector current=pencils[pos].getL();
        vertex(current.x,current.y);  
      }
      endShape();
    }
  }  
}




