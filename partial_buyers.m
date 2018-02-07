% This function gives the partial equilibrium results for sex buyers:
% Imputs: Price and Interest Rate
% Outputs:  Value Function (v)
%           Asset Policy function (ap)
%           Consumption Policy function (c)
%           Sex Consumption Policy Function (x)
%           Desition rure (dr)
function [v,ap,c,x,dr]=partial_buyers(price,r)


[sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits] = parameters(1);

iter	= 1;
iter2   = 1;
crit2   = 1;
crit	= 1;
v1		= zeros(nbk,1);
v2		= zeros(nbk,1);
v		= zeros(nbk,nba);
%% Replace Negatives
%beta = 1/(1+r);

[ag1,ag2]=meshgrid(agrid);

c1 = (Y(1)+(1+r).*ag1-ag2)/(1+price^(1/-sigma));
c2 = (Y(2)+(1+r).*ag1-ag2)/(1+price^(1/-sigma));
x1 = c1.*price.^(1/-sigma); 
x2 = c2.*price.^(1/-sigma); 

c1(c1<=0) = NaN;
c2(c2<=0) = NaN;
x1(x1<=0) = NaN;
x2(x2<=0) = NaN;
util1 = utility(c1,x1);
util2 = utility(c2,x2);
util1(c1<=0) = -inf;
%util1(x1<=0) = -inf;
util2(c2<=0) = -inf;
%util2(x2<=0) = -inf;

%% Value function iteration
while crit>1e-7 && iter<100000
%for i=1:maxits
  [tv1,tdecis1]=max(util1 + beta*repmat(surv.*v(:,1),1,nbk));
  [tv2,tdecis2]=max(util2 + beta*repmat(surv.*v(:,2),1,nbk));
  
  tdecis=[tdecis1' tdecis2'];
  tv=[tv1' tv2'];
  
  crit=max(max(abs((tv-v)./tv)));
  v=tv;
  dr=tdecis;
iter = iter+1;
end
%}
% Recovering asset policy function 

ap		= agrid(dr);

% Recovering consumption policy functions
 for j=1:nba
    c(:,j)	= (Y(j)+(1+r).*agrid-ap(:,j))/(1+price^(1/-sigma));
    x(:,j)	= c(:,j).*price^(1/-sigma);
 end
 %}
 end