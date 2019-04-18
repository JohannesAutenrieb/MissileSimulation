% This is the Code for the use-case example of the flight dynamic class

    %.. Matlab Initialize 

    clc ;           close all ;             clear all ; 
    
    
    
    %Step 1: Loading needed files

     Sim_Parameters;
     Missile_Data;
     

     %Step 3: Loading simulink model
     missile_model = 'UAS_Lin';
     load_system(missile_model)
     
     
     
     [t,x,y] = sim(missile_model); 
     
     plot(x);
    

  
%   ---------------------------------------------------------------

%.. Trim Conditions initilsation 

    Alt_Trim            =        0.0;                                       % Initilisation of Variable for Operating Altitude  


    
  
  

% --------- END OF CODE -------------------------------------------------