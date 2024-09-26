
% Bacteria-insulin population model

t0 = 0;
tfinal = 10;
y0 = [2; 0];   

[T,Y] = ode45(@f,[t0 tfinal],y0);

plot(T,Y,LineWidth=3)
title('Bacteria-Insulin Model, g(N) = 1.5, d(I) = 0.0, P(I) = 0.4, N_0 = 2 million')
xlabel('Time t (min)')
ylabel('Population (millions)')
legend('Bacteria','Insulin','Location','North')
fontsize(scale=2)


function dydt = f(t,y)
alpha = 100*exp();
beta = 0.5;
gamma = 0.4;

dydt = [(alpha - beta*y(2))*y(1); % bacteria
        (gamma*y(1))]; % insulin
end



