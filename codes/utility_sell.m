% This calculates the utility of females
% Imputs 		Consumption (c)
%				leasure(1-labor): (1-x.^(1/alpha)
% Output: 		Utility(u)
function u=utility_sell(c,x)
[sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits,M_unedu,M_edu,F_unedu,F_edu,kapa] = parameters(1);
%kapa = 1;
 %u = (c.^(1-sigma)-1)./(1-sigma)+(x.^(1-sigma)-1)./(1-sigma);
 u = (c.^(1-sigma))./(1-sigma)+(kapa.*((1-x.^(1/alpha)).^(1-sigma))./(1-sigma));
end
