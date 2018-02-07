% This Function solves for a sex consumption matrix
% Imputs:   Income (y)
%           Implicit sex consumption matrix(l)
%           Price 
%           Interest rate(r)
function [aux2]=general_eq(y,l,price,r)
[sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits,M_unedu,M_edu,F_unedu,F_edu,kapa] = parameters(1);

aux2 = zeros(nbk,nbk);

[ag1,ag2]=meshgrid(agrid);

aux2 = y.*(1-(l.^(1./alpha)))+(1+r).*ag1+price.*l-ag2 -((kapa.*(1-(l.^(1/alpha))).^(-sigma).*(l.^((1/alpha)-1)./alpha))./((-y.*(l.^((1/alpha)-1)))./(alpha)+price)).^(1/-sigma);

end