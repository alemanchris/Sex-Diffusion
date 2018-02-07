% This function gives the partial equilibrium results for sex sellers:
% Imputs: Price and Interest Rate
% Outputs:  Value Function (v_s)
%           Asset Policy function (ap_s)
%           Consumption Policy function (c_s)
%           Sex Consumption Policy Function (x_s)
%           Desition rure (dr_s)
function [v_s,ap_s,c_s,x_s,dr_s]=partial_sellers(price,r)

[sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits,M_unedu,M_edu,F_unedu,F_edu,kapa] = parameters(1);


% Initialize variables 
%beta = 1/(1+r);
c_s		= zeros(nbk,nba);
x_s     = zeros(nbk,nba);
v_s		= zeros(nbk,nba);
totv_s	= zeros(nbk,nba);
dr_s   	= zeros(nbk,nba);
iter_s	= 1;
crit_s	= 1;
pres	= 1e-6;
initial_guess = zeros(nbk,nbk)+0.01;


%% Replacing Negatives
options = optimset('Display','off');


x_s1 = fsolve(@(x1) [real(general_eq(Y(1),x1,price,r)),imag(general_eq(Y(1),x1,price,r))],initial_guess,options);
c_s1 = ((kapa.*(1-x_s1.^(1/alpha)).^(-sigma).*(x_s1.^((1/alpha)-1)./alpha))./((-Y(1).*x_s1.^((1/alpha)-1))./(alpha)+price)).^(1/-sigma);
options = optimset('Display','off');

x_s2 = fsolve(@(x2) [real(general_eq(Y(2),x2,price,r)),imag(general_eq(Y(2),x2,price,r))],initial_guess,options);
c_s2 = ((kapa.*(1-x_s2.^(1/alpha)).^(-sigma).*(x_s2.^((1/alpha)-1)./alpha))./((-Y(2).*x_s2.^((1/alpha)-1))./(alpha)+price)).^(1/-sigma);

c_s1(c_s1<=0)=NaN;
x_s1(x_s1<=0)=NaN;
c_s2(c_s2<=0)=NaN;
x_s2(x_s2<=0)=NaN;

util_s1=utility_sell(c_s1,x_s1);
util_s2=utility_sell(c_s2,x_s2);

util_s1(c_s1<=0) = -inf;
%util_s1(x_s1<=0) = -inf;
util_s2(c_s2<=0) = -inf;
%util_s2(x_s2<=0) = -inf;
% 
while crit_s>1e-7 && iter_s<100000
   % for j=1:nba
	  % eval(['[vtmp_s,drtmp_s]	= max(util_s' int2str(j) '+beta*repmat(surv.*v_s(:,j),1,nbk));']);
      % totv_s(:,j)=vtmp_s';
      % dr_s(:,j)=drtmp_s';
   % end
  [tv1_s,tdecis1_s]=max(util_s1 + beta*repmat(surv.*v_s(:,1),1,nbk));
  [tv2_s,tdecis2_s]=max(util_s2 + beta*repmat(surv.*v_s(:,2),1,nbk));
  
  tdecis_s=[tdecis1_s' tdecis2_s'];
  totv_s=[tv1_s' tv2_s'];
   crit_s	= max(max(abs((totv_s-v_s)./totv_s)));
   v_s    = totv_s;
   dr_s   = tdecis_s;
   iter_s	= iter_s+1;
end



% Recover asset policy function
ap_s = agrid(dr_s);

% Recovering Policy functions
init_guess_2 = zeros(nbk,1)+0.01;
options = optimset('Display','off');
for j=1:nba

x_s(:,j) = fsolve(@(l) [real(general_eq2(Y(j),l,ap_s,price,r)),imag(general_eq2(Y(j),l,ap_s,price,r))],init_guess_2,options);
c_s(:,j) = ((kapa.*(1-(x_s(:,j).^(1/alpha))).^(-sigma).*(x_s(:,j).^((1/alpha)-1)./alpha))./((-Y(j).*(x_s(:,j).^((1/alpha)-1)))./(alpha)+price)).^(1/-sigma);
end

end
