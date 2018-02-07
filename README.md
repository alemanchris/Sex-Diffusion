# Sex-Diffusion
**************************************************************************
**************************************************************************
1.PRE_EPICEMIC_PHASE
**************************************************************************
**************************************************************************
The codes in the folder "Codes_mat" solve the Pre_epidemic phase of the model.

The main figures generared by the codes are stored in "figures" folder. 

The main file is "Pre_epidemic.m" which makes use of auxiliary functions:

"parameters."				Loads the parameters of the model
"partial_buyers.m"			Calculates partial equilibrium for males
"partial_sellers.m"			Calculates partial equilibrium for Females
"general_eq_manual.m" &"general_eq2_manual.m"		Solves for Matrix and Vector sex consumption
"asset.m"					Explicitly solves excess asset demand
"sex.m"						Explicitly solves excess sex demand
"rates.m"					Implicitly solves excess asset demand
"prices.m"					Implicitly solves excess sex demand

To generate the figures just run the main file. 
To see alternative specifications, just modify the parameters in "parameters.m"
