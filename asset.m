% This function calculates Excess demand of assets
% Imputs: 	Desition Rules (dr, dr_s)
% Outputs: 	Excess Deman (passet_excess)

function [passet_excess] = asset(dr,dr_s)
%% Load Parameters
[~,~,~,~,~,~,nbk,agrid,~,M_unedu,M_edu,F_unedu,F_edu] = parameters(1);

%% The asset market
   % Buyers
   g2 = zeros(nbk,nbk);
   g1 = zeros(nbk,nbk);
   %%%%
   for i=1:nbk
       g1(i,dr(i,1))=1;
       g2(i,dr(i,2))=1;
   end
   trans1 = g1';
   probst1 = (1/(nbk))*ones(nbk,1); %initial distribution of assets, 
   t1 = 1;
   while t1 > 10^(-8)
       prob_new1 = trans1*probst1;
       t1 = max(abs(prob_new1-probst1));
       probst1 = prob_new1;
   end 
   %%%%%%
    trans2 = g2';
   probst2 = (1/(nbk))*ones(nbk,1); %initial distribution of assets, 
   t2 = 1;
   while t2 > 10^(-8)
       prob_new2 = trans2*probst2;
       t2 = max(abs(prob_new2-probst2));
       probst2 = prob_new2;
   end 
   %
   dr1 = dr(:,1);
   dr2 = dr(:,2);
   aa1    = agrid(dr1);
   aa2    = agrid(dr2);
   passet_excess_buyers = M_unedu*(probst1'*aa1)+M_edu*(probst2'*aa2);
     
   % Sellers
   g2_s = zeros(nbk,nbk);
   g1_s = zeros(nbk,nbk);
   %%%%
   for i=1:nbk
       g1_s(i,dr_s(i,1))=1;
       g2_s(i,dr_s(i,2))=1;
   end
   
   trans1_s = g1_s';
   probst1_s = (1/(nbk))*ones(nbk,1); %initial distribution of assets, 
   t1_s = 1;
   while t1_s > 10^(-8)
       prob_new1_s = trans1_s*probst1_s;
       t1_s = max(abs(prob_new1_s-probst1_s));
       probst1_s = prob_new1_s;
   end 
   %%%%%%
    trans2_s = g2_s';
   probst2_s = (1/(nbk))*ones(nbk,1); %initial distribution of assets, 
   t2_s = 1;
   while t2_s > 10^(-8)
       prob_new2_s = trans2_s*probst2_s;
       t2_s = max(abs(prob_new2_s-probst2_s));
       probst2_s = prob_new2_s;
   end 
   
   %
   dr1_s = dr_s(:,1);
   dr2_s = dr_s(:,2);
   aa1_s    = agrid(dr1_s);
   aa2_s    = agrid(dr2_s);
   passet_excess_sellers = F_unedu*(probst1_s'*aa1_s)+F_edu*(probst2_s'*aa2_s);
   %
   passet_excess = passet_excess_sellers+passet_excess_buyers;
   
end