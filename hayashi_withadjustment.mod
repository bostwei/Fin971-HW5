// This code solves Hayashi's investment model with adjustment cost.
// Written by Shiyan Wei
//12/10/2018

var k, q, z, i, c, m; // Even though z is exogenous shock, it is determined by z'=(1-rho) + rho z + eps, so it is determined inside the model and we should include z in this section.

varexo eps;


parameters
	theta r delta psi_0 rho_z rho_c sigma gamma ita;

// set parameter values

theta = 0.7;    // curvature of profit function
r     = 0.04;   // discount rate
delta = 0.15;   // depreciation rate
rho_z   = 0.7;    // persistency of productivity shock
rho_c = 0.2;			// persistency of consumption growth
sigma = 0.15;   // std(eps)
psi_0 = 0.01;   // adjustment cost
ita = 0.5;			//corr btw c growth shock and z shocks
gamma = 2 ;			// CRRA coefficient.



// Start describing the model.
model;

    // NOTE: in dynare notation, k = k_{t+1}, and k(-1) = k_t.

    // 1. FOC wrt I_t
    q = 1 + psi_0 * (i - delta *k(-1))/(k(-1));

    // 2. FOC wrt k_{t+1}

    q = (m(+1) * ( z(+1) * k^(theta-1) + (- 4 * delta * psi_0 * (z(+1)- delta * k) * k - 2 * psi_0 * (i(+1) - delta*(k)) ^2)/(4*k^2) + q(+1) * (1-delta)));

    // 3. Law of motion for capital
    i = k - (1- delta) * k(-1);

		// 4. consumption
		c = z * k(-1)^(theta) - psi_0 * (i - delta * k(-1))^2/(2*k(-1)) - i;

		// 5. law of motion for z
    z= rho_z * z(-1)+ (1-rho_z) + eps;

		// 6. The discount factor growth
		m = (1/(1+r)) * (c/c(-1))^(-gamma);

end;

// This section gives dynare the initial value to solve for the steady state.
initval;
	z = 1;
	q = 1;
	k = ((r + delta)/theta)^(1/(theta-1));
	i = delta * k;
	m = 1/(1+r);
	c = k^(theta) - delta * k;
end;

// Check if the initial value given above satisfies the steady state condition.
resid(1);

// Determine the size of shock. Here I set sigma as a standard error of eps.
shocks;
    var eps; stderr sigma;
end;

// use Dynare capabilities to generate TeX-files of the dynamic and static model
write_latex_static_model;
write_latex_dynamic_model;

// solve for steady state and use it as an initial value to compute the impulse reponse.
// the steady state values are stored in oo_.steady_state.
steady;

// check if the Blanchard-Kahn condition is satisfied or not.
check;

// compute the impulse reponse with linear approximation (order = 1) for 40 periods (irf = 40). The result is stored in oo_.irf.
// Also simulate the model to generate simulated data for 20000 periods (periods = 20000). Drop first 200 periods to avoid the effect of initial condition.
// The graph dynare produces is in terms of the deviation of steady state, x_t - x_{ss}, not the percentage deviation (x_t-x_{ss})/x_{ss}. So you have to divide irf by its steady state.
stoch_simul(order=1,irf=40, periods = 20000, drop = 200);
