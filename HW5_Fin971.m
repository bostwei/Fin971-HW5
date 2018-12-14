%**********************************************
% Fin 971 HW5
% Shiyan wei
% 12/10/2018
%**********************************************

clear all
close all


% Runing Dynare
dynare hayashi_withadjustment.mod

% extract irf
irf_k = oo_.irfs.k_eps';
irf_q = oo_.irfs.q_eps';
irf_z = oo_.irfs.z_eps';
irf_i = oo_.irfs.i_eps';

% extract Steady State 
% Note the sequence of steady state is 
% - ss(1) = k_ss
% - ss(2) = q_ss
% - ss(3) = z_ss
% - ss(4) = i_ss
% - ss(5) = c_ss
% - ss(6) = m_ss
ss = oo_.steady_state;

% Plot the impuls response function for capital and investment
irf_k_pct = irf_k./ss(1);
irf_q_pct = irf_q./ss(2);
irf_z_pct = irf_z./ss(3);
irf_i_pct = irf_i./ss(4);

figure (1)
subplot(2,1,1);
plot(irf_k_pct);
title('Implus Respond function for Capital')

subplot(2,1,2);
plot(irf_i_pct);
title('Implus Respond function for Investment')

clear
close

% Runing Dynare
dynare hayashi_withadjustment_Gamma0.mod

% extract irf
irf_k = oo_.irfs.k_eps';
irf_q = oo_.irfs.q_eps';
irf_z = oo_.irfs.z_eps';
irf_i = oo_.irfs.i_eps';

% extract Steady State 
% Note the sequence of steady state is 
% - ss(1) = k_ss
% - ss(2) = q_ss
% - ss(3) = z_ss
% - ss(4) = i_ss
% - ss(5) = c_ss
% - ss(6) = m_ss
ss = oo_.steady_state;

% Plot the impuls response function for capital and investment
irf_k_pct = irf_k./ss(1);
irf_q_pct = irf_q./ss(2);
irf_z_pct = irf_z./ss(3);
irf_i_pct = irf_i./ss(4);

figure (1)
subplot(2,1,1);
plot(irf_k_pct);
title('Implus Respond function for Capital \gamma = 0')

subplot(2,1,2);
plot(irf_i_pct);
title('Implus Respond function for Investment \gamma = 0')

clear
close

%% Question 3
% Runing Dynare
load hayashi_withadjustment_results.mat

% extract the simulated data
% - simulated(1) = k_simul
% - simulated(2) = q_simul
% - simulated(3) = z_simul
% - simulated(4) = i_simul
% - simulated(5) = c_simul
% - simulated(6) = m_simul
simulated = oo_.endo_simul;
k_simul = simulated(1,:);
q_simul = simulated(2,:);
z_simul = simulated(3,:);
i_simul = simulated(4,:);
c_simul = simulated(5,:);
m_simul = simulated(6,:);

% calculate the production function
theta = 0.7; 
pi_simul = z_simul .* k_simul.^ theta; 

% generate the I to k
i_k = i_simul ./ k_simul;

% generate the pi to k
pi_k = pi_simul ./ k_simul;

% generate the ones
t = length(q_simul);
I = ones(t-1,1);

% preparing data
x = [q_simul(2:length(q_simul))',pi_k(2:length(q_simul))'];
x(imag(x)>0)=0;
y = i_k(1:length(i_k)-1)';

% generate OLS model
mdl = fitlm(x,y);

% extract the coefficient b and its variance
b = mdl.Coefficients;

disp(b);

%% Question 4
%--------------- Bayesian Estimation ----------------------
clear all;
clc

% Run dynare to generate the simulated data.
dynare hayashi_withadjustment.mod

% Obtain simulated results.
k   = oo_.endo_simul(1,:)'; 
q   = oo_.endo_simul(2,:)'; 
i   = oo_.endo_simul(3,:)';
z   = oo_.endo_simul(4,:)';
sdf = oo_.endo_simul(5,:)'; 
c   = oo_.endo_simul(6,:)'; 

% Add measurement error
TW = length(oo_.endo_simul(2,:));
e  = randn(TW,1) * 0.01;
qob = q + e;

% save the data
save('data_mat.mat','k','qob')

% estimate the parameters using the simulated data.
dynare withadjustment_est.mod


