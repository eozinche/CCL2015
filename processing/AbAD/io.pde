void keyPressed ()
{
    if (key == 'd')
    {
      displayMode++;
      if (displayMode > 2) displayMode = 0;
    }
     
    if (key == '1') initSetup (150);
    if (key == '2') initSetup (125);
    if (key == '3') initSetup (100);
    if (key == '4') initSetup (80);
    if (key == '5') initSetup (60);
    if (key == '6') initSetup (40);
    if (key == '7') initSetup (30);
    if (key == '8') initSetup (20);
    if (key == '9') initSetup (10);
    
    if (key == ' ')  initSetup (RES);
    
    if (key == 'r') drawBase = !drawBase; 
    if (key == 't') drawOrigins = !drawOrigins; 
    if (key == 'z') drawTriangle = !drawTriangle;
    
}
