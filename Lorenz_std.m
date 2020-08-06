clc; clear all; close all;
% Standard constants for the Lorenz Attractor
sigma = 10;
rho = 28;
beta = 8/3;

% The lorenz strange attractor
lorenz1 = @(t,x)[sigma*(x(2)-x(1)); x(1)*(rho-x(3))-x(2); x(1)*x(2)-beta*x(3)];
tspan = 0:0.005:100;
a=5:0.1:25;
for k = 1:numel(a)
    [t,x{k}]=ode45(@lorenz,tspan,[a(k) 5 15 ]);
end
ym = cell2mat(x);

%%
Ts = mean(diff(tspan));                             % Sampling Interval
Fs = 1/Ts;                                          % Sampling Frequency
Fn = Fs/2;                                          % Nyquist Frequency
L = numel(tspan);                                   % Signal Length
FTvdp1 = fft(ym(:,1:2:size(ym,2)))/L;               % Fourier Trasnsform
Fv = linspace(0, 1, fix(L/2)+1)*Fn;                 % Frequency Vector
Iv = 1:numel(Fv);                                   % Index Vector

figure
plot(Fv, abs(FTvdp1(Iv,:)))
grid
xlabel('Frequency')
title('Frequency Domain Plot')
xlim([0 Fs/2])