% This function calculates Excess demand of sex
% Imputs: 		Desition Rules (dr, dr_s)
% 				Sex consumption policy function (x, x_s)
% Outputs: 		Excess Deman (ex_goods)

function [ex_goods] = sex(x,x_s,dr,dr_s)
[~,~,~,~,~,~,nbk,~,~,M_unedu,M_edu,F_unedu,F_edu] = parameters(1);

   g2 = zeros(nbk,nbk);
   g1 = zeros(nbk,nbk);
   %%%%
   for i=1:nbk
       g1(i,dr(i,1))=1;
       g2(i,dr(i,2))=1;
   end
  
   trans1 = g1';
   probst1 = (1/(nbk))*ones(nbk,1); %initial distribution of assets, it doesnt matter what I put, cuz in steady state the initial disitribution will converge
   t1 = 1;
   while t1 > 10^(-8)
       prob_new1 = trans1*probst1;
       t1 = max(abs(prob_new1-probst1));
       probst1 = prob_new1;
   end 
   %%%%%%
    trans2 = g2';
   probst2 = (1/(nbk))*ones(nbk,1); %initial distribution of assets, it doesnt matter what I put, cuz in steady state the initial disitribution will converge
   t2 = 1;
   while t2 > 10^(-8)
       prob_new2 = trans2*probst2;
       t2 = max(abs(prob_new2-probst2));
       probst2 = prob_new2;
   end 
   
   %%%%%%%
   % Sellers
   g2_s = zeros(nbk,nbk);
   g1_s = zeros(nbk,nbk);
   %%%%
   for i=1:nbk
       g1_s(i,dr_s(i,1))=1;
       g2_s(i,dr_s(i,2))=1;
   end
   
   trans1_s = g1_s';
   probst1_s = (1/(nbk))*ones(nbk,1); %initial distribution of assets, it doesnt matter what I put, cuz in steady state the initial disitribution will converge
   t1_s = 1;
   while t1_s > 10^(-8)
       prob_new1_s = trans1_s*probst1_s;
       t1_s = max(abs(prob_new1_s-probst1_s));
       probst1_s = prob_new1_s;
   end 
   
   trans2_s = g2_s';
   probst2_s = (1/(nbk))*ones(nbk,1); %initial distribution of assets, it doesnt matter what I put, cuz in steady state the initial disitribution will converge
   t2_s = 1;
   while t2_s > 10^(-8)
       prob_new2_s = trans2_s*probst2_s;
       t2_s = max(abs(prob_new2_s-probst2_s));
       probst2_s = prob_new2_s;
   end 
  % 
    %% The sex market
%% Excess demand of sex buyers (Males)
demand = M_unedu*(probst1'*x(:,1))+M_edu*(probst2'*x(:,2));
%% Excess demand of sex sellers (Females)
supply = F_unedu*(probst1_s'*x_s(:,1))+F_edu*(probst2_s'*x_s(:,2));
%% Total excess demand
ex_goods  = demand - supply;
end