% This function loads the parameters of the model:
% Input: 1
% Output: Parametes
function [sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits,M_unedu,M_edu,F_unedu,F_edu,kapa] = parameters(param)
if param==1
    sigma  = 1.5; 				% CRRA Parameter
    alpha  = 0.5;				% Cobb-Douglas Parameter
    surv   = 1; 				% Survival Probability, supposed to depend on education
    beta   = 0.97;              % Discount Factor
    kapa   = 1;
    Y    =[65,120/0.1]; 
    nba = size(Y,2);    % Number of states
    nbk  = 10;          % Number of Grid points 
    % Asset grid
    a_min   = -35;
    a_max   =82; %me gusta
    agrid	= linspace(a_min,a_max,nbk)';
    maxits = 100;
    % Education Proportions
    M_unedu  = 0.45;            % Proportion of uneducated males
    M_edu    = 0.55;            % Prop of Edu Males
    F_unedu  = 0.6;             % Prop of Unedu Females
    F_edu    = 0.4;  
    % Alternative
     Y    =[1,2.1]; 
    a_min   =-0.6;
    a_max   =0.6; %me gusta
    agrid	= linspace(a_min,a_max,nbk)';


else
    
end
