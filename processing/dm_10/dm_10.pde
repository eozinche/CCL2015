/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/34320*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
//drawing machine #10////Ale González////a(en)60rpm.tv/////Pubic Domain//
//A bunch of discipled particles marching through a force field,/////////
//Inspired by Marius Watz work///////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////

Bunch bunch;            //Group of particles
Attractor[] attractors; //Group of attractors
int 
NA=200,                 //Number of attractors
CR=360,                 //colormode range 
A=CR/10;                //alpha of stroke
boolean 
zzz=false,              //Sleeping boolean to toggle the loop
displayingPoints=true,
thereAreLimits=true;



void setup(){
  //general settings
  size(900,450,P2D);   //P2D for a better performance (althoug the rendering is worse)
  colorMode(HSB,CR);
  background(#ffffff);
  smooth();
  stroke(#000000,A);
  strokeWeight(1.1);   //for a better rendering on P2D
  noFill(); 
  //object settings, we instantiate the particles with the dimensiones of the grid, 
  //and a factor to shift the forces acting on them
  bunch=new Bunch(5,5,20);   
  attractors=new Attractor[NA];
  for (int i=0;i<NA;i++){      
    attractors[i]=new Attractor(); 
  }
}

void draw(){
  if(!zzz){
    if(thereAreLimits){
      bunch.update(attractors,150);
    }else{
      bunch.update(attractors);
    }
  bunch.displayPoints();
  }
}

void mousePressed(){
  zzz=!zzz; 
}

void keyPressed(){
  switch(key){
   case('1'):
     thereAreLimits=true;
     setup();
     break; 
   case('2'):
     thereAreLimits=false;
     setup();
     break;
  }
}



