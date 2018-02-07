clear all
% This code solves the pre-epidemic stage of the model:
% I simultaneosuly solve for market clearing prices and interest rates
% The results are verified by solving for market clearing prices using
% fzero and fsolve.

%% Load Parameters

[sigma,alpha,surv,beta,Y,nba,nbk,agrid,maxits,M_unedu,M_edu,F_unedu,F_edu,kapa] = parameters(1);

%% Auxiliary parameters
price = 10;                 % Initial Price 
%rate  = 0.01;              % Initial Interest rate
liter1   = 1;               % Iteration counter
liter2   = 1;
step1   = 0.009;
step2   = 10000;
flag1   = 1;
flag2   = 1;


%% Alternative One: Iterating manually
%{
% Solve for market clearing interest rates
 while  (flag1 ~= 0) 
     %&& (liter <= maxiter)
        
[v,ap,c,x,dr]           = partial_buyers(price,rate);
[v_s,ap_s,c_s,x_s,dr_s] = partial_sellers(price,rate);

%% The asset market
  passet_excess = asset(dr,dr_s);
   % Iterare on the interest rate
    if liter1 == 1
      A = passet_excess; 
      if passet_excess > 0.0
      %if passet_excess < 0.0
         step1 = -step1;
      end
   end
   if abs(A)>0.00001
       Aold = A;
       Anew = passet_excess;
       if sign(Aold) ~= sign(Anew)
         step1 = -.5*step1;
       end

       disp('   Iter_GE    rate     Excess_asset  Step');
       disp([ liter1 rate passet_excess step1 ]);
       if abs(step1) >= 10e-10
          rate = rate + step1;
       else
          flag1 = 0;
       end
       A     = Anew;
       liter1 = liter1+1;
   else
       flag1 =0;
       zero_rate=rate-step1;
   end
 end 
%}
%{
% Solve for market clearing prices

 while (flag2 ~= 0) %&& (liter2 <= 1000)
    
[v,ap,c,x,dr]           = partial_buyers(price,zero_rate);
[v_s,ap_s,c_s,x_s,dr_s] = partial_sellers(price,zero_rate);
  ex_goods = sex(x,x_s,dr,dr_s); 
%% Iterate on price

       if liter2 == 1
          B = ex_goods;
          if ex_goods < 0
         
             step2 = -step2;
          end
       end
       if abs(B)>0.001
           Bold = B;
           Bnew = ex_goods;
           if sign(Bold) ~= sign(Bnew)
             step2 = -.5*step2;
           end
           disp('   Iter_GE2    PRICE     Excess_sex  Step');
           disp([ liter2 price ex_goods step2 ]);
           if abs(step2) >= 10e-10
              price = price + step2;
           else
              flag2 = 0;
           end
           B = Bnew;
           liter2 = liter2+1;
       else
           flag2 = 0;
           zero_price=price-step2;
       end
      
 end
 %}


%% Alternative Two: Using in built solvers
 %
 tic
 options_1 = optimset('Display','iter','MaxFunEvals',1e2,'MaxIter',1e2,'TolFun',1e-5,'TolX',1e-5);
 options_2 = optimset('Display','iter');
 x0_2 = 100;
 x0_1 = 0.03;
 zero_rate = fzero(@(r) rates(price,r), x0_1,options_1);
 zero_price = fsolve(@(p) prices(p,zero_rate),x0_2, options_2);
 toc
 [v,ap,c,x,dr]           = partial_buyers(zero_price,zero_rate);
 [v_s,ap_s,c_s,x_s,dr_s] = partial_sellers(zero_price,zero_rate);
 
 %}
 
%% Graphs
%
figure(1)
yyaxis left
plot(agrid,v(:,1));
xlabel('a_t','fontname','times','fontsize',15)
ylabel('V','fontname','times','fontsize',15)
title('Value Function Males','fontname','times','fontsize',17)

yyaxis right
plot(agrid,v(:,2));
ylabel('V','fontname','times','fontsize',15)
legend('Less Educated','Educated')

figure(2)
yyaxis left
plot(agrid,ap(:,1));
xlabel('a_t','fontname','times','fontsize',15)
ylabel('a_t+1','fontname','times','fontsize',15)
legend('Less Educated','Educated')
title('Policy function of asset holdings (Males)','fontname','times','fontsize',17)
yyaxis right
plot(agrid,ap(:,2));
ylabel('a_t+1','fontname','times','fontsize',15)
legend('Less Educated','Educated')

figure(3)
yyaxis left
plot(agrid,c(:,1));
xlabel('a_t','fontname','times','fontsize',15)
ylabel('c_t','fontname','times','fontsize',15)
legend('Less Educated','Educated')
title('Policy function of Consumption (Males)','fontname','times','fontsize',17)
yyaxis right
plot(agrid,c(:,2));
ylabel('c_t','fontname','times','fontsize',15)
legend('Less Educated','Educated')


figure(4)
yyaxis left
plot(agrid,x(:,1))
title('Policy function for sex consumption (Males)','fontname','times','fontsize',17)
xlabel('a_t','fontname','times','fontsize',15)
ylabel('x_t','fontname','times','fontsize',15)
legend('Less Educated','Educated')
yyaxis right
plot(agrid,x(:,2));
ylabel('x_t','fontname','times','fontsize',15)
legend('Less Educated','Educated')
%}

figure(5)
yyaxis left
plot(agrid,v_s(:,1));
xlabel('a_t','fontname','times','fontsize',15)
ylabel('V','fontname','times','fontsize',15)
title('Value Function Females','fontname','times','fontsize',17)
legend('Less Educated','Educated')
yyaxis right
plot(agrid,v_s(:,2));
ylabel('V','fontname','times','fontsize',15)
legend('Less Educated','Educated')


figure(6)
plot(agrid,ap_s);
xlabel('a_t','fontname','times','fontsize',15)
ylabel('a_t+1','fontname','times','fontsize',15)
title('Policy function of asset holdings (Females)','fontname','times','fontsize',17)
legend('Less Educated','Educated')


figure(7)
yyaxis left
plot(agrid,c_s(:,1));
xlabel('a_t','fontname','times','fontsize',15)
ylabel('c_t','fontname','times','fontsize',15)
title('Policy function of Consumption (Females)','fontname','times','fontsize',17)
legend('Less Educated','Educated')
yyaxis right
plot(agrid,c_s(:,2));
ylabel('c_t','fontname','times','fontsize',15)
legend('Less Educated','Educated')

figure(8)
yyaxis left
plot(agrid,x_s(:,1))
title('Policy function for sex Production (Females)','fontname','times','fontsize',17)
xlabel('a_t','fontname','times','fontsize',15)
ylabel('x_t','fontname','times','fontsize',15)
legend('Less Educated','Educated')
yyaxis right
plot(agrid,x_s(:,2));
ylabel('x_t','fontname','times','fontsize',15)
legend('Less Educated','Educated')
%}