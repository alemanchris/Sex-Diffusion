% This calculates the utility of males
% Imputs 		Consumption (c)
%				Sex Consumption (x)
% Output: 		Utility(u)
function u=utility(c,x)
[sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits] = parameters(1);
 %u = (c.^(1-sigma)-1)./(1-sigma)+(x.^(1-sigma)-1)./(1-sigma);
 u = (c.^(1-sigma))./(1-sigma)+(x.^(1-sigma))./(1-sigma);
end
