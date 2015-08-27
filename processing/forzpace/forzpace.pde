/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/36961*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
//forzpace////Ale González////60rpm.tv///////////Pubic Domain////
//A refix of my #10 drawing machine, in order to generate odd////
//spatial structures, guided by particles influenced by, say,////
//force-fields////////////Inspired by Marius Watz work///////////
/////////////////////////////////////////////////////////////////

import peasy.*;

PeasyCam cam;
B bunch;                //Group of particles
PVector[] a;            //Group of attractors

int 
NA=75,                  //Number of attractors
maxDist=150;            //Maximum distance of force influence      
boolean 
zzz=false;              //Sleeping boolean to toggle the loop
color
BG=#FFFFFF;


void setup(){
  //general settings
  size(900,450,P3D); 
  background(BG);
  smooth();
  fill(#FFFF00);
  frameRate(25);
  noStroke();
  //object settings, we instantiate the particles with the dimensiones of the grid, 
  //and a factor to shift the forces acting on them
  bunch=new B(5,5,8);   
  a=new PVector[NA];
  for (int i=0;i<NA;i++){      
    a[i]=new PVector(random(width),random(height),random(-maxDist*.5,maxDist*.5)); 
  }
  //library settings
  cam = new PeasyCam(this,width/2,height/2,0,500);
  cam.setMinimumDistance(maxDist);
  cam.setMaximumDistance(3000);
}

void draw(){
  if(!zzz){
    background(BG);
    lights();
    bunch.update(a,maxDist);
    bunch.display();
  }
}


void keyPressed(){
  switch(key){
   case('s'):
     setup();
     break; 
   case('z'):
     zzz=!zzz;
     break;
  }
}



