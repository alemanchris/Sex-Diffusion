% This Function solves for a sex consumption vector
% Imputs:   Income (y)
%           Implicit sex consumption vector(l)
%           Desition rule (rule)
%           Price 
%           Interest rate(r)
function [aux2]=general_eq2(y,l,rule,price,r)
[sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits,M_unedu,M_edu,F_unedu,F_edu,kapa] = parameters(1);
aux2 = y.*(1-(l.^(1/alpha)))+(1+r).*agrid+price.*l-rule -((kapa.*(1-(l.^(1/alpha))).^(-sigma).*(l.^((1/alpha)-1)./alpha))./((-y.*(l.^((1/alpha)-1)))./(alpha)+price)).^(1/-sigma);

end