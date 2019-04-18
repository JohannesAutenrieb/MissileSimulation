%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name : Missile_Trim_Main.m                                          %
%                                                                         %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Matlab Initialize 

    clc ;           close all ;             clear all ; 
    
%.. Global Variables

    global      Alt_Trim            Speed_Trim          Mach_Trim
    global      Theta_dot_Trim      Turn_dot_Trim       
    global      G_Turn              Gamma_Trim
    global      Init_Cnstr1         Init_Cnstr2         Init_Cnstr3
    
%.. Load Sim Parameters and Missile Data

    Sim_Parameters ;
    Missile_Data;

%.. Initial Values of Additional Constraints for Trim     

    Init_Cnstr1         =       0.0 ;                                       % Initial State for Constraint1 (Speed)
    Init_Cnstr2         =       0.0 ;                                       % Initial State for Constraint2 (Pull-up)
    Init_Cnstr3         =       0.0 ;                                       % Initial State for Constraint3 (Turn)
    
%.. Trim Conditions initilsation 

    Alt_Trim            =        0.0;                                       % Initilisation of Variable for Operating Altitude  
    Mach_Trim          =         0.0;                                       % Initilisation of Variable for Mach trim 
    Speed_Trim          =        0.0;                                       % Initilisation of Variable for Operating Speed

%.. Pull-up Constraint for Trim Calculation

    Theta_dot_Trim      =       0.0 * UNIT_DEG2RAD ;                     	% Default = 0.0 
    
%.. Coordinate Turn Constraint (CTC) for Trim Calculation

    Turn_dot_Trim       =       0.0 * UNIT_DEG2RAD ;                        % Default = 0.0
    G_Turn              =       Turn_dot_Trim * Speed_Trim / UNIT_GRAV ;   
    
%.. Rate of Climb Constraint (ROC) for Trim Calculation

    Gamma_Trim          =       0.0 * UNIT_DEG2RAD ;                        % Default = 0.0                   

%.. Find names and ordering of states from Simulink model   

    [ sizes, x0, names] = Missile_Trim    
    
    disp('///////////////////////////////////////////////')
    disp('          Check order of state variables')
    disp('///////////////////////////////////////////////')
    names{:}

    %------------- Code Section for the first Trim Question --------------%
    % Flight Conidtion:
    % Mach_Trim = 0.7
    % Altitude_Trimm = 0 m
    %---------------------------------------------------------------------%
    
    %.. Seeting variables for first calculation part
    Alt_Trim            =        0.0;                                       % Trimming Altitude of Missile  
    Mach_Trim          =         0.7;                                       %Trimming Mach number of Misslile
    Speed_Trim          =       Mach_Trim*interp1(ALT,SOS_Table,Alt_Trim);  % Operating Speed calculated out of given trim conditions
    
%.. Initial Guess for Trim Conditions

    X0(1)           =   Speed_Trim ;                                     
    X0(2)           =   0.0 ;                                            
    X0(3)           =   0.0 ;                                          
    X0(4)           =   0.0 * UNIT_DEG2RAD ;                          
    X0(5)           =   0.0 * UNIT_DEG2RAD ;                         
    X0(6)           =   0.0 * UNIT_DEG2RAD ;                      
    X0(7)           =   0.0 * UNIT_DEG2RAD ;                            
    X0(8)           =   0.0 * UNIT_DEG2RAD ;                          
    X0(9)           =   0.0 * UNIT_DEG2RAD ;                               
    X0(10)          =   0.0 ;                                          
    X0(11)          =   0.0 ;                                          
    X0(12)          =   0.0 ;                                         
    
    U0(1)           =   0.0 ;                                           
    U0(2)           =   0.0 * UNIT_DEG2RAD ;                            
    U0(3)           =   0.0 * UNIT_DEG2RAD ;                              
    U0(4)           =   0.0 * UNIT_DEG2RAD ;                            
    %---------------------------------------------------------------------%
    
    %.. Trim Calculation 
    [ x_trim, u_trim, y_trim, xd_trim ] = trim('Missile_Trim',X0',U0') 
    
    %.. Save Solution 
    save( 'Trim_Solution_a.mat', 'x_trim', 'u_trim', 'y_trim', 'xd_trim', 'Mach_Trim', 'Alt_Trim' ) ;
    xd_trim
    
    
    disp('///////////////////////////////////////////////')
    disp('                Trim Flight Conditions                ')
    disp('///////////////////////////////////////////////')  
    fprintf(' \n ') ;
    fprintf(' Mach   = %3.1f m/s\n ', Mach_Trim     ) ;
    fprintf(' Altitude   = %3.1f m/s\n ', Alt_Trim  ) ;
    
    disp('///////////////////////////////////////////////')
    disp('          Trim State and Trim Input            ')
    disp('///////////////////////////////////////////////')
    
    fprintf(' \n ') ;
    fprintf(' U      = %3.4f m/s\n ', x_trim(1)     ) ;
    fprintf(' V      = %3.4f m/s\n ', x_trim(2)     ) ;
    fprintf(' W      = %3.4f m/s\n ', x_trim(3)     ) ;
    fprintf(' P      = %3.4f deg/s\n ', x_trim(4)* UNIT_RAD2DEG     ) ;
    fprintf(' Q      = %3.4f deg/s\n ',x_trim(5)* UNIT_RAD2DEG      ) ;
    fprintf(' R      = %3.4f deg/s\n ',x_trim(6) * UNIT_RAD2DEG     ) ;   
    fprintf(' PHI    = %3.4f deg/s\n ', x_trim(7) * UNIT_RAD2DEG    ) ;
    fprintf(' THETA  = %3.4f deg/s\n ',x_trim(8) * UNIT_RAD2DEG     ) ;
    fprintf(' PSI    = %3.4f deg/s\n ', x_trim(9)* UNIT_RAD2DEG     ) ;      
    fprintf(' ALPHA  = %3.4f deg\n ', y_trim(10)* UNIT_RAD2DEG     ) ;
    fprintf(' BETA   = %3.4f deg\n ', y_trim(11)* UNIT_RAD2DEG     ) ;
    fprintf(' VT     = %3.4f m/s\n ', y_trim(12)     ) ;
    fprintf(' \n ') ;
    fprintf(' del_T  = %3.4f N\n ',    u_trim(1) ) ;
    fprintf(' del_r  = %3.4f deg\n ',   u_trim(2) * UNIT_RAD2DEG ) ;
    fprintf(' del_p  = %3.4f deg\n ',   u_trim(3) * UNIT_RAD2DEG ) ;
    fprintf(' del_y  = %3.4f deg\n ',   u_trim(4) * UNIT_RAD2DEG ) ;
    %---------------------------------------------------------------------%
    
    %------------- Code Section for the second Trim Question -------------%
    % Flight Condition:
    % Mach_Trim = [0.3 0.5 0.7 0.9 1.1];
    % Altitude_Trimm = 0;
    %---------------------------------------------------------------------%
    
    %.. Clearing reused variables and arrays
    X0 = [];
    U0 = [];
    
    %.. Creating loop variables to store the results
    x_trim_matrix = [];
    u_trim_matrix = [];
    y_trim_matrix = [];
    xd_trim_matrix = [];
    Mach_Trim_matrix = [];
    Alt_Trim_matrix = [];
    
    %.. Seeting trim conditions calculation
    Alt_Trim            =        0.0;                                       % Trimming Altitude of Missile  
    Mach_Trim          =         [0.3 0.5 0.7 0.9 1.1];                     %Trimming Mach number of Misslile
    
    for i=1:length(Mach_Trim);
        
        %.. Clearing reused variables and arrays
        X0 = [];
        U0 = [];
        
        Speed_Trim = Mach_Trim(i)*interp1(ALT,SOS_Table,Alt_Trim);          % Operating Speed calculated out of given trim conditions

        %.. Initial Guess for Trim Conditions

        X0(1)           =   Speed_Trim ;                                     
        X0(2)           =   0.0 ;                                            
        X0(3)           =   0.0 ;                                          
        X0(4)           =   0.0 * UNIT_DEG2RAD ;                          
        X0(5)           =   0.0 * UNIT_DEG2RAD ;                         
        X0(6)           =   0.0 * UNIT_DEG2RAD ;                      
        X0(7)           =   0.0 * UNIT_DEG2RAD ;                            
        X0(8)           =   0.0 * UNIT_DEG2RAD ;                          
        X0(9)           =   0.0 * UNIT_DEG2RAD ;                               
        X0(10)          =   0.0 ;                                          
        X0(11)          =   0.0 ;                                          
        X0(12)          =   0.0 ;                                         

        U0(1)           =   0.0 ;                                           
        U0(2)           =   0.0 * UNIT_DEG2RAD ;                            
        U0(3)           =   0.0 * UNIT_DEG2RAD ;                              
        U0(4)           =   0.0 * UNIT_DEG2RAD ;                            
        %---------------------------------------------------------------------%

         %.. Trim Calculation 

        [ x_trim, u_trim, y_trim, xd_trim ] = trim('Missile_Trim',X0',U0') 
         xd_trim
        
        disp('///////////////////////////////////////////////')
        disp('                Trim Flight Conditions                ')
        disp('///////////////////////////////////////////////')  
        fprintf(' \n ') ;
        fprintf(' Mach   = %3.1f m/s\n ', Mach_Trim(i)  ) ;
        fprintf(' Altitude   = %3.1f m/s\n ', Alt_Trim  ) ;
        
        disp('///////////////////////////////////////////////')
        disp('          Trim State and Trim Input            ')
        disp('///////////////////////////////////////////////')

        fprintf(' \n ') ;
        fprintf(' U      = %3.4f m/s\n ', x_trim(1)     ) ;
        fprintf(' V      = %3.4f m/s\n ', x_trim(2)     ) ;
        fprintf(' W      = %3.4f m/s\n ', x_trim(3)     ) ;
        fprintf(' P      = %3.4f deg/s\n ', x_trim(4)* UNIT_RAD2DEG     ) ;
        fprintf(' Q      = %3.4f deg/s\n ',x_trim(5)* UNIT_RAD2DEG      ) ;
        fprintf(' R      = %3.4f deg/s\n ',x_trim(6) * UNIT_RAD2DEG     ) ;   
        fprintf(' PHI    = %3.4f deg/s\n ', x_trim(7) * UNIT_RAD2DEG    ) ;
        fprintf(' THETA  = %3.4f deg/s\n ',x_trim(8) * UNIT_RAD2DEG     ) ;
        fprintf(' PSI    = %3.4f deg/s\n ', x_trim(9)* UNIT_RAD2DEG     ) ;      
        fprintf(' ALPHA  = %3.4f deg\n ', y_trim(10)* UNIT_RAD2DEG     ) ;
        fprintf(' BETA   = %3.4f deg\n ', y_trim(11)* UNIT_RAD2DEG     ) ;
        fprintf(' VT     = %3.4f m/s\n ', y_trim(12)     ) ;
        fprintf(' \n ') ;
        fprintf(' del_T  = %3.4f N\n ',    u_trim(1) ) ;
        fprintf(' del_r  = %3.4f deg\n ',   u_trim(2) * UNIT_RAD2DEG ) ;
        fprintf(' del_p  = %3.4f deg\n ',   u_trim(3) * UNIT_RAD2DEG ) ;
        fprintf(' del_y  = %3.4f deg\n ',   u_trim(4) * UNIT_RAD2DEG ) ;
        
        
        % Safe and Add triming data to matrix
        x_trim_matrix = [x_trim_matrix x_trim];
        u_trim_matrix = [u_trim_matrix u_trim];
        y_trim_matrix = [y_trim_matrix y_trim];
        xd_trim_matrix = [xd_trim_matrix xd_trim];
        Mach_Trim_matrix = [Mach_Trim_matrix Mach_Trim(i)];
        Alt_Trim_matrix = [Alt_Trim_matrix Alt_Trim];
 
    end
    %.. Safe all results in  the Solution File  
    save( 'Trim_Solution_b.mat', 'x_trim_matrix', 'u_trim_matrix', 'y_trim_matrix', 'xd_trim_matrix', 'Mach_Trim_matrix', 'Alt_Trim_matrix' ) ;
    %---------------------------------------------------------------------%
    
    
    %------------- Code Section for the third Trim Question --------------%
    % Flight Condition:
    % Mach_Trim = [0.3 0.5 0.7 0.9 1.1];
    % Altitude_Trimm = 0;
    %---------------------------------------------------------------------%
    
    %.. Clearing reused variables and arrays
    X0 = [];
    U0 = [];
    clear x_trim u_trim y_trim xd_trim; 
    
    %.. Creating loop variables to store the results
    x_trim_matrix = [];
    u_trim_matrix = [];
    y_trim_matrix = [];
    xd_trim_matrix = [];
    Mach_Trim_matrix = [];
    Alt_Trim_matrix = [];
    
    %.. Seeting trim conditions calculation
    
    altitude_range      =[0 1000 2000 3000 4000];                           % Trimming Altitude of Missile  
    Mach_Trim           =          0.7;                                     %Trimming Mach number of Misslile
    
    for i=1:length(altitude_range);
        
        %.. Clearing reused variables and arrays
        X0 = [];
        U0 = [];
        
        Alt_Trim   = altitude_range(i);   
        Speed_Trim = Mach_Trim*interp1(ALT,SOS_Table,Alt_Trim);             % Operating Speed calculated out of given trim conditions

        %.. Initial Guess for Trim Conditions

        X0(1)           =   Speed_Trim ;                                     
        X0(2)           =   0.0 ;                                            
        X0(3)           =   0.0 ;                                          
        X0(4)           =   0.0 * UNIT_DEG2RAD ;                          
        X0(5)           =   0.0 * UNIT_DEG2RAD ;                         
        X0(6)           =   0.0 * UNIT_DEG2RAD ;                      
        X0(7)           =   0.0 * UNIT_DEG2RAD ;                            
        X0(8)           =   0.0 * UNIT_DEG2RAD ;                          
        X0(9)           =   0.0 * UNIT_DEG2RAD ;                               
        X0(10)          =   0.0 ;                                          
        X0(11)          =   0.0 ;                                          
        X0(12)          =   0.0 ;                                         

        U0(1)           =   0.0 ;                                           
        U0(2)           =   0.0 * UNIT_DEG2RAD ;                            
        U0(3)           =   0.0 * UNIT_DEG2RAD ;                              
        U0(4)           =   0.0 * UNIT_DEG2RAD ;                            
        %-----------------------------------------------------------------%

         %.. Trim Calculation 

        
        [ x_trim, u_trim, y_trim, xd_trim ] = trim('Missile_Trim',X0',U0'); 
       
         xd_trim
       
        disp('///////////////////////////////////////////////')
        disp('                Trim Flight Conditions                ')
        disp('///////////////////////////////////////////////')  
        fprintf(' \n ') ;
        fprintf(' Mach   = %3.1f m/s\n ', Mach_Trim  ) ;
        fprintf(' Altitude   = %3.1f m/s\n ', Alt_Trim  ) ;
        
        disp('///////////////////////////////////////////////')
        disp('          Trim State and Trim Input            ')
        disp('///////////////////////////////////////////////')

        fprintf(' \n ') ;
        fprintf(' U      = %3.4f m/s\n ', x_trim(1)     ) ;
        fprintf(' V      = %3.4f m/s\n ', x_trim(2)     ) ;
        fprintf(' W      = %3.4f m/s\n ', x_trim(3)     ) ;
        fprintf(' P      = %3.4f deg/s\n ', x_trim(4)* UNIT_RAD2DEG     ) ;
        fprintf(' Q      = %3.4f deg/s\n ',x_trim(5)* UNIT_RAD2DEG      ) ;
        fprintf(' R      = %3.4f deg/s\n ',x_trim(6) * UNIT_RAD2DEG     ) ;   
        fprintf(' PHI    = %3.4f deg/s\n ', x_trim(7) * UNIT_RAD2DEG    ) ;
        fprintf(' THETA  = %3.4f deg/s\n ',x_trim(8) * UNIT_RAD2DEG     ) ;
        fprintf(' PSI    = %3.4f deg/s\n ', x_trim(9)* UNIT_RAD2DEG     ) ;      
        fprintf(' ALPHA  = %3.4f deg\n ', y_trim(10)* UNIT_RAD2DEG     ) ;
        fprintf(' BETA   = %3.4f deg\n ', y_trim(11)* UNIT_RAD2DEG     ) ;
        fprintf(' VT     = %3.4f m/s\n ', y_trim(12)     ) ;
        fprintf(' \n ') ;
        fprintf(' del_T  = %3.4f N\n ',    u_trim(1) ) ;
        fprintf(' del_r  = %3.4f deg\n ',   u_trim(2) * UNIT_RAD2DEG ) ;
        fprintf(' del_p  = %3.4f deg\n ',   u_trim(3) * UNIT_RAD2DEG ) ;
        fprintf(' del_y  = %3.4f deg\n ',   u_trim(4) * UNIT_RAD2DEG ) ;
        %-----------------------------------------------------------------%  
        
        % Safe and Add triming data to matrix
        x_trim_matrix = [x_trim_matrix x_trim];
        u_trim_matrix = [u_trim_matrix u_trim];
        y_trim_matrix = [y_trim_matrix y_trim];
        xd_trim_matrix = [xd_trim_matrix xd_trim];
        Mach_Trim_matrix = [Mach_Trim_matrix Mach_Trim];
        Alt_Trim_matrix = [Alt_Trim_matrix Alt_Trim];
 
    end
    %.. Safe all results in  the Solution File  
    save( 'Trim_Solution_c.mat', 'x_trim_matrix', 'u_trim_matrix', 'y_trim_matrix', 'xd_trim_matrix', 'Mach_Trim_matrix', 'Alt_Trim_matrix' ) ;