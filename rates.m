% This function implicitly solves for Excess asset demand
% Imput: 			Prices(price)
%					Rate (zero_rate)
% Outut: 			Implicit Excess asset demand (aux)
function aux=rates(price,zero_rate)
[~,~,~,~,dr]           = partial_buyers(price,zero_rate);
[~,~,~,~,dr_s] = partial_sellers(price,zero_rate);
  passet_excess = asset(dr,dr_s); 
aux = passet_excess;


end