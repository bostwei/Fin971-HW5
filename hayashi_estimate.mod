% Hayashi Investment Model with Endogenous Stochastic Discount Factor, 11/19/2018
% Estimate using model generated data
%

%----------------------------------------------------------------
% 0. Housekeeping
%----------------------------------------------------------------

close all

%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------

// Endogenous Variables
var k, q, i, sdf, c, p, v, qob;

// Exogenous Variables
var z;

// Shocks
varexo epsz epsq;

// Paramters
parameters ttheta rr ddelta ppsi rrhoz ssigmaz ggamma ssigmaq;

%----------------------------------------------------------------
% 2. Calibration
%----------------------------------------------------------------

// Parameters
ttheta = 0.7;    // curvature of profit function
rr     = 0.04;   // discount rate
ddelta = 0.15;   // depreciation rate
ppsi   = 0.01;   // adjustment cost of investment
rrhoz   = 0.7;    // persistency of productivity shock
ssigmaz = 0.1;   // std(eps) of productivity shock
ggamma = 2.0;    // CRRA utility parameter
ssigmaq = 0.01;   // std(eps) of measurement error shock

// Analytic Steady State
z_SS = 1;
q_SS = 1;
k_SS = (ttheta/(rr+ddelta))^(1/(1-ttheta));
i_SS = ddelta*k_SS;
sdf_SS = 1/(1+rr);
c_SS = k_SS^ttheta-i_SS;
v_SS = (1+rr)*c_SS/rr;
p_SS = c_SS/rr;
qob_SS = q_SS;


%----------------------------------------------------------------
% 3. Model
%----------------------------------------------------------------

model;

q = 1+(ppsi/k(-1))*(i-ddelta*k(-1));
q = sdf(+1)*(ttheta*z(+1)*k^(ttheta-1) + (ppsi*ddelta/k)*(i(+1)-ddelta*k) + (ppsi/(2*k^2))*(i(+1)-ddelta*k)^2 + q(+1)*(1-ddelta));
k = i + (1-ddelta)*k(-1);
c = z*k(-1)^ttheta - (ppsi/(2*k(-1)))*(i-ddelta*k(-1)) - i;
sdf = (1/(1+rr))*(c/c(-1))^(-ggamma);
v = c + sdf(+1)*v(+1);
p = v - c;

//z = rrhoz*z(-1) + (1-rrhoz) + ssigmaz*epsz;
z = rrhoz*z(-1) + (1-rrhoz) + epsz;

//qob = q + ssigmaq*epsq;
qob = q + epsq;


end;

%----------------------------------------------------------------
% 4. Computation
%----------------------------------------------------------------

// Steady State
initval;
  k = k_SS;
  q = q_SS;
  i = i_SS;
  sdf = sdf_SS;
  c = c_SS;
  p = p_SS;
  v = v_SS;
	z = z_SS;
	qob = qob_SS;
end;


resid;
check;


// Setting Variances of Shocks
shocks;
    var epsz = 1;
    var epsq = 1;
end;

// Stochastic Simulation
//stoch_simul(order=1,nocorr,nograph);
//stoch_simul(order=1, irf=40, periods = 20000, drop = 200, nograph);

// Bayesian Estimation using Metropolis-Hastings

// Observable variable
varobs k, qob;

// Parameters to be estimated
estimated_params;
ttheta, 0.7, uniform_pdf, , , 0, 1;
ppsi, 0.01, uniform_pdf, , , 0, 1;
//ttheta, uniform_pdf, , , 0, 1;
//ppsi, uniform_pdf, , , 0, 1;
//stderr epsz, inv_gamma_pdf, 0.007 , inf;
//stderr epsq, inv_gamma_pdf, 0.007 , inf;
stderr epsz, 0.1, inv_gamma_pdf, 0.007 , inf;
stderr epsq, 0.01, inv_gamma_pdf, 0.007 , inf;
end;

//estimation(datafile=hayashi_simuldata) k qob;
estimation(datafile=hayashi_simuldata,mh_nblocks=1,mh_replic=1500) k qob;


//estimation(datafile=hayashi_simuldata,mh_jscale=1.8) k qob;
//estimation(datafile=hayashi_simuldata,mh_nblocks=5,mh_replic=10000,mh_jscale=3,mh_init_scale=12) k qob;
//estimation(datafile=hayashi_simuldata,mh_replic=1500,mode_compute=6) k qob;
