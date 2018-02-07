% This function implicitly calculates excess demand of sex
% Imputs: 		Interest rate(zero_rate)
% 				Prices
% Outout: 		Implicit solution for excess demand
% 

function aux=prices(price,zero_rate)
[~,~,~,x,dr]     = partial_buyers(price,zero_rate);
[~,~,~,x_s,dr_s] = partial_sellers(price,zero_rate);
  ex_goods = sex(x,x_s,dr,dr_s); 
aux = ex_goods;


end