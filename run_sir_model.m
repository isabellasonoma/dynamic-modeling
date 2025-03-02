% ------------------------------------------------------------
% run_SIR_with_parameters.m
% ------------------------------------------------------------
% This script shows how to:
%   1) Assign new values to a, b, s0, i0, r0
%   2) Run the DiscreteTimeSIRModel_FixedK model
%   3) Retrieve the simulation outputs (s, i, r)
%   4) Plot the results

% Close open models
bdclose('all');

% Define parameters and initial conditions
a = 1/3;   % Recovery rate
b = 1.3;   % Infection rate
N = 7.9e6; % Total population
S0 = 7.89999e6;
I0 = 10;
R0 = 0;

% Convert to fractions for the model
s0 = S0/N;
i0 = I0/N;
r0 = R0/N;

% Assign variables to the base workspace
assignin('base','a',a);
assignin('base','b',b);
assignin('base','s0',s0);
assignin('base','i0',i0);
assignin('base','r0',r0);

% Load or open the existing model (make sure the .slx file is on your path)
load_system('DiscreteTimeSIRModel_FixedK');

% Optionally adjust solver step size or stop time
set_param('DiscreteTimeSIRModel_FixedK','FixedStep','1');  % 1 day
set_param('DiscreteTimeSIRModel_FixedK','StopTime','150'); % 150 days

% Run the simulation
simOut = sim('DiscreteTimeSIRModel_FixedK');

% Extract simulation results
sData = simOut.get('s');   % structure with time, signals.values
iData = simOut.get('i');
rData = simOut.get('r');

time = sData.time;
s    = sData.signals.values;
iVar = iData.signals.values;
r    = rData.signals.values;

% Plot results
figure('Name','Discrete-Time SIR Model','NumberTitle','off');
plot(time, s, 'b','LineWidth',2); hold on;
plot(time, iVar, 'r','LineWidth',2);
plot(time, r, 'g','LineWidth',2);
xlabel('Time (days)');
ylabel('Fraction of Population');
legend({'Susceptible','Infected','Recovered'}, 'Location','best');
title(sprintf('Discrete-Time SIR Model (a=%.3f, b=%.3f)', a, b));
grid on;
