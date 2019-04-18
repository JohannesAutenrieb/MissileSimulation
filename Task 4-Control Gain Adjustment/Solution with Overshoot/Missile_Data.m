%/////////////////////////////////////////////////////////////////////////%
%                                                                         %
%   - Name: Missile_Data.m                                                %
%   - Missile Parameters are defined                                      %
%                                                                         %
%                           - Created by Dr. C. H. Lee, 26/10/2018        %
%                                                                         %
%/////////////////////////////////////////////////////////////////////////%

%.. Global Variables

    global      D               l               S               Mass
    global      I_xx            I_yy            I_zz            I_TENSOR
    global      XCG             XREF            ETA
    
    global      Tbl_ALPHAT      Tbl_MACH
    global      Tbl_CX_0        Tbl_CX_ALPHAT   Tbl_CX_DEL_EFF
    global      Tbl_CY_PHIT     Tbl_CY_DEL_Y
    global      Tbl_CZ_0        Tbl_CZ_PHIT     Tbl_CZ_DEL_P
    global      Tbl_CL_ALPHAT   Tbl_CL_P        Tbl_CL_DEL_R
    global      Tbl_CM_0        Tbl_CM_PHIT     Tbl_CM_Q        Tbl_CM_DEL_P
    global      Tbl_CN_PHIT     Tbl_CN_R        Tbl_CN_DEL_Y
    
    global      Wn_Act          Zeta_Act
    
    global      K_phi           K_p             
    global      K_DC            K_A
    global      Omega_i         K_R

%.. Missile Configuration Data

    D           =   0.150 ;                                                 % Missile diameter          (m)
    l           =   1.618 ;                                                 % Missile length            (m)
    S           =   ( pi / 4 ) * D^2 ;                                      % Missile area              (m^2)
    Mass        =   30.0 ;                                                  % Mass                      (kg)
    
    I_xx        =   0.5 * Mass * ( D / 2 )^2 ;                              % Ixx Moment of Inertia     (kg*m^2)
    I_yy        =   Mass * ( ( 1 / 12 ) * l^2 + ( 1 / 4 ) * ( D / 2 )^2 ) ; % Iyy moment of inertia     (kg*m^2)
    I_zz        =   I_yy ;                                                  % Izz moment of inertia     (kg*m^2)
    
    I_TENSOR    =   [ I_xx,  0.0,  0.0 ;                                    % Moment of Inertia Tensor
        
                       0.0, I_yy,  0.0 ; 
                       0.0,  0.0, I_zz ] ; 
    ETA         =   1;                                                      % Self defined Propulsion Efficiency
    
    
    XCG         =   0.809 ;                                                 % Missile C.G. Point 
    XREF        =   0.809 ;                                                 % Missile Moment Reference Point
    
%.. Actuator Parameters

    Wn_Act      =   25.0 * 2 * pi ;                                         % Natural Frequency         (rad) 
    Zeta_Act    =   0.707 ;                                                 % Damping Ratio             
    
%.. Control Gains


    K_phi       =   20.0 ; 
    K_p         =   0.01 ; 
    K_DC        =   0.957 ;
    K_A         =   0.15 ;
    Omega_i     =   -0.83 ; 
    K_R         =   0.0254 ;
    
%.. Missile Aerodynamics Data 

    % Total Angle-of-Attack Table
    Tbl_ALPHAT      =   [ 0     4     8    12    16 ] ;                                         % Size: 1x5, Unit: Deg           
    
    % Mach Table
    Tbl_MACH        =   [ 0.2    0.3    0.4    0.5    0.6    0.7 ] ;                            % Size: 1x6
    
    % Force Coefficent: CX_a  
    Tbl_CX_0        =   [ -0.3840   -0.3670   -0.3550   -0.3460   -0.3390   -0.3410 ] ;         % Size: 1x6 (1 x Mach)
    
    Tbl_CX_ALPHAT   =   [ 0.0788    0.0752    0.0680    0.0573    0.0573    0.0573 ] ;          % Size: 1x6 (1 x Mach), Unit: (1/rad)
    
    Tbl_CX_DEL_EFF  =   [ -16.8080  -17.8585  -18.9090  -19.9595  -20.4847  -23.1110 ] ;        % Size: 1x6 (1 x Mach), Unit: (1/rad^2)
    
    % Force Coefficient: CY_a
    Tbl_CY_PHIT     =   [ 0    0.0070    0.0819    0.2313    0.2992 ;                           % Size: 6x5 (Mach x Alphat)  
                          0   -0.0055   -0.0123    0.0465    0.2165 ; 
                          0   -0.0091   -0.0211   -0.0263    0.0947 ; 
                          0   -0.0095   -0.0256   -0.0380    0.0588 ; 
                          0   -0.0082   -0.0197   -0.0209    0.1315 ; 
                          0   -0.0071   -0.0155    0.0151    0.1986 ] ; 
                      
    Tbl_CY_DEL_Y    =   [ 5.3056    5.7754    6.0504    6.3484    6.6921    7.5745 ] ;          % Size: 1x6 (1 x Mach), Unit: (1/rad)
    
    % Force Coefficient: CZ_a
    Tbl_CZ_0        =   [ 0   -2.0680   -3.9700   -5.4250   -6.6810 ;                           % Size: 6x5 (Mach x Alphat)
                          0   -2.2120   -4.5150   -6.8060   -8.7160 ;
                          0   -2.2980   -4.7050   -7.1210   -9.4680 ;
                          0   -2.3980   -4.8930   -7.4010   -9.7670 ;
                          0   -2.5200   -5.0980   -7.6390   -9.9650 ;
                          0   -2.8400   -5.6970   -8.4430  -10.9750 ] ; 
                      
    Tbl_CZ_PHIT     =   [ 0    0.0089    0.1842    0.3041    0.2039 ;                           % Size: 6x5 (Mach x Alphat)
                          0   -0.0083   -0.0190    0.2455    0.5956 ;
                          0   -0.0128   -0.0227    0.0414    0.5061 ;
                          0   -0.0132   -0.0299   -0.0095    0.4190 ;
                          0   -0.0114   -0.0172    0.0701    0.5930 ;
                          0   -0.0096   -0.0150    0.1713    0.6371 ] ; 
                      
    Tbl_CZ_DEL_P    =   [ -5.3056   -5.7754   -6.0504   -6.3484   -6.6921   -7.5745 ] ;         % Size: 1x6 (1 x Mach), Unit: (1/rad)
    
    % Moment Coefficients: CL_a
    Tbl_CL_ALPHAT   =   [ -0.0988   -0.4859   -0.5870   -0.4802   -0.3334   -0.0210 ] ;         % Size: 1x6 (1 x Mach), Unit: (1/rad^2) 
    
    Tbl_CL_P        =   [ -17.9516  -19.6297  -20.9956  -22.5566  -24.5079  -28.6446 ] ;        % Size: 1x6 (1 x Mach), Unit: (1/rad)
    
    Tbl_CL_DEL_R    =   [ 5.2712    5.7640    6.1650    6.6234    7.1963    8.4110 ] ;          % Size: 1x6 (1 x Mach), Unit: (1/rad)
    
    % Moment Coefficients: CM_a
    Tbl_CM_0        =   [ 0   -2.2250   -3.9280   -4.8580   -5.6940 ;                           % Size: 6x5 (Mach x Alphat)
                          0   -2.4400   -4.8390   -7.1140   -8.8060 ;
                          0   -2.5620   -5.1360   -7.7210  -10.1410 ;
                          0   -2.6960   -5.4180   -8.1510  -10.8370 ;
                          0   -2.8500   -5.6900   -8.5340  -11.0690 ;
                          0   -3.2270   -6.3940   -9.5510  -12.2020 ] ; 
        
    Tbl_CM_PHIT     =   [ 0   -0.0024   -0.0898   -0.2360   -0.3546 ;                           % Size: 6x5 (Mach x Alphat)
                          0    0.0146    0.0788    0.2141   -0.0555 ;
                          0    0.0192    0.0986    0.2398    0.3490 ;
                          0    0.0203    0.0991    0.2130    0.4609 ;
                          0    0.0187    0.0925    0.2269    0.3662 ;
                          0    0.0167    0.0852    0.2257    0.3085 ] ;
    
    Tbl_CM_Q        =   [ -82.9643  -47.4409  -32.7732  -16.7304  -43.2010  -56.1499 ] ;        % Size: 1x6 (1 x Mach), Unit: (1/rad)
    
    Tbl_CM_DEL_P    =   [ -20.7182  -22.5631  -23.6059  -24.7632  -26.1269  -29.5646 ] ;        % Size: 1x6 (1 x Mach), Unit: (1/rad)
    
    % Moment Coefficients: CN_a
    Tbl_CN_PHIT     =   [ 0    0.0040    0.0098    0.1116    0.3049 ;                           % Size: 6x5 (Mach x Alphat)
                          0   -0.0083   -0.0512   -0.1318   -0.0988 ;
                          0   -0.0114   -0.0616   -0.1309   -0.2168 ;
                          0   -0.0118   -0.0628   -0.1283   -0.2441 ;
                          0   -0.0107   -0.0584   -0.1174   -0.2240 ;
                          0   -0.0093   -0.0551   -0.1103   -0.2245 ] ; 
    
    Tbl_CN_R        =   [ -82.9643  -47.4409  -32.7732  -16.7304  -43.2010  -56.1499 ] ;        % Size: 1x6 (1 x Mach), Unit: (1/rad)  
    
    Tbl_CN_DEL_Y    =   [ -0.3616   -0.3938   -0.4120   -0.4322   -0.4560   -0.5160 ] ;         % Size: 1x6 (1 x Mach), Unit: (1/rad)
    