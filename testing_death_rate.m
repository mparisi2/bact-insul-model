% Mona Parisi
% February 6, 2024
% Test different values of bacteria death rate d to find the optimal value
% which maximizes insulin production

clc


% Solve ODE to create bacteria-insulin population model

t0 = 0;
tfinal = 10800;
tspan = [t0:10:tfinal];
y0 = [10^2; 0];  



% [T,Y1] = ode45(@(t,y) f(t,y,100,d),tspan,y0);
% [T,Y2] = ode45(@(t,y) f(t,y,1000,d),tspan,y0);
% [T,Y3] = ode45(@(t,y) f(t,y,10000,d),tspan,y0);

d = 0;

Y3 = ode45(@(t,y) f(t,y,10000,d),tspan,y0);



j = 1;
deathrate = zeros(1,j);
time_optimal = zeros(1,j);
amount_optimal = zeros(1,j);
for d = 0.0:0.01:2 
    deathrate(j) = d;
    Y3 = ode45(@(t,y) f(t,y,10000,d),tspan,y0);

    number = zeros(1,100);
    y = zeros(1,100);
    n = zeros(1,100);
    for i = 1:100
        n(i) = i; % number of chunks
        number(i) = 60 * 24 * 7 / i; % time of each chunk
    
        y(i) = i*deval(Y3,number(i),2); % insulin after 1 week for i time chunks
    end

    [amount_opt, no_of_chunks_opt] = max(y); % optimal amount of insulin produced per week and asssociated number of chunks
    
    time_optimal(j) = 60*24*7/no_of_chunks_opt; 
    amount_optimal(j) = amount_opt;
    j = j+1;
end


% plot(deathrate,time_optimal)
% title('d vs optimal time')


% Plot d vs max insulin
figure
plot(deathrate,amount_optimal,LineWidth=2,Color=[1,0,0])
ax = gca;
ax.XAxis.FontSize = 16;
ax.YAxis.FontSize = 16;
title('Bacteria Death Rate vs. Maximum Insulin Produced',Interpreter='Latex',FontSize=20)
xlabel('Bacteria death rate $d ~(\mathrm{minute^{-1}*(\frac{mg~insulin}{mL})^{-1}})$',Interpreter='Latex',FontSize=18)
ylabel('Maximum insulin produced $I_{max}$ (mg/mL) per week',Interpreter='Latex',FontSize=16)
% xticks(fontsize=14)
% yticks(fontsize=14)
hold on
d = deathrate;
guess = 4.85*(d+0.01).^(-0.12)-3.4;
% guess = 5*exp(-2*d);
guess2 = exp(0.3412)*(d+0.01).^(-0.4186);
guess3 = 2.3786*(d).^(-0.2147)-0.97;
% plot(d, guess3,LineWidth=3,Color=[1,0,0,0.4])
% legend('Actual Solution',Interpreter='Latex',FontSize=20)
% legend('Actual Solution','Fitted Equation $max\_I$',Interpreter='Latex',FontSize=16)
hold off


% figure
% dinsulin = [diff(amount_optimal) -0.00539613324661759]
% plot(deathrate,dinsulin)
% title('Deriv of d vs maxI')

% figure
% d2insulin = [diff(dinsulin) 0]
% plot(deathrate,d2insulin)
% title('Second deriv of d vs maxI')



% Bacteria #1
function dydt = f(t,y,k,d)
gN = 0.035*y(1)*(1 - y(1)/k); % bact 1: k = 10^2
dI = d*y(1)*y(2);
pI = 5e-8;

dydt = [(gN-dI); % bacteria
        (pI*y(1))]; % insulin
end
