%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'hayashi_withadjustment';
M_.dynare_version = '4.5.6';
oo_.dynare_version = '4.5.6';
options_.dynare_version = '4.5.6';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('hayashi_withadjustment.log');
M_.exo_names = 'eps';
M_.exo_names_tex = 'eps';
M_.exo_names_long = 'eps';
M_.endo_names = 'k';
M_.endo_names_tex = 'k';
M_.endo_names_long = 'k';
M_.endo_names = char(M_.endo_names, 'q');
M_.endo_names_tex = char(M_.endo_names_tex, 'q');
M_.endo_names_long = char(M_.endo_names_long, 'q');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'm');
M_.endo_names_tex = char(M_.endo_names_tex, 'm');
M_.endo_names_long = char(M_.endo_names_long, 'm');
M_.endo_partitions = struct();
M_.param_names = 'theta';
M_.param_names_tex = 'theta';
M_.param_names_long = 'theta';
M_.param_names = char(M_.param_names, 'r');
M_.param_names_tex = char(M_.param_names_tex, 'r');
M_.param_names_long = char(M_.param_names_long, 'r');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'psi_0');
M_.param_names_tex = char(M_.param_names_tex, 'psi\_0');
M_.param_names_long = char(M_.param_names_long, 'psi_0');
M_.param_names = char(M_.param_names, 'rho_z');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_z');
M_.param_names_long = char(M_.param_names_long, 'rho_z');
M_.param_names = char(M_.param_names, 'rho_c');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_c');
M_.param_names_long = char(M_.param_names_long, 'rho_c');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'gamma');
M_.param_names_tex = char(M_.param_names_tex, 'gamma');
M_.param_names_long = char(M_.param_names_long, 'gamma');
M_.param_names = char(M_.param_names, 'ita');
M_.param_names_tex = char(M_.param_names_tex, 'ita');
M_.param_names_long = char(M_.param_names_long, 'ita');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 6;
M_.param_nbr = 9;
M_.orig_endo_nbr = 6;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('hayashi_withadjustment_static');
erase_compiled_function('hayashi_withadjustment_dynamic');
M_.orig_eq_nbr = 6;
M_.eq_nbr = 6;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 4 0;
 0 5 10;
 2 6 11;
 0 7 12;
 3 8 0;
 0 9 13;]';
M_.nstatic = 0;
M_.nfwrd   = 3;
M_.npred   = 2;
M_.nboth   = 1;
M_.nsfwrd   = 4;
M_.nspred   = 3;
M_.ndynamic   = 6;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(6, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(9, 1);
M_.NNZDerivatives = [22; -1; -1];
M_.params( 1 ) = 0.7;
theta = M_.params( 1 );
M_.params( 2 ) = 0.04;
r = M_.params( 2 );
M_.params( 3 ) = 0.15;
delta = M_.params( 3 );
M_.params( 5 ) = 0.7;
rho_z = M_.params( 5 );
M_.params( 6 ) = 0.2;
rho_c = M_.params( 6 );
M_.params( 7 ) = 0.15;
sigma = M_.params( 7 );
M_.params( 4 ) = 0.01;
psi_0 = M_.params( 4 );
M_.params( 9 ) = 0.5;
ita = M_.params( 9 );
M_.params( 8 ) = 2;
gamma = M_.params( 8 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = 1;
oo_.steady_state( 2 ) = 1;
oo_.steady_state( 1 ) = ((M_.params(2)+M_.params(3))/M_.params(1))^(1/(M_.params(1)-1));
oo_.steady_state( 4 ) = M_.params(3)*oo_.steady_state(1);
oo_.steady_state( 6 ) = 1/(1+M_.params(2));
oo_.steady_state( 5 ) = oo_.steady_state(1)^M_.params(1)-M_.params(3)*oo_.steady_state(1);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
resid(1);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (M_.params(7))^2;
steady;
oo_.dr.eigval = check(M_,options_,oo_);
options_.drop = 200;
options_.irf = 40;
options_.order = 1;
options_.periods = 20000;
var_list_ = char();
info = stoch_simul(var_list_);
save('hayashi_withadjustment_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('hayashi_withadjustment_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('hayashi_withadjustment_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('hayashi_withadjustment_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('hayashi_withadjustment_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('hayashi_withadjustment_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('hayashi_withadjustment_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
