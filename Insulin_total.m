% Find the optimal amount of insulin produced in a week by testing
% different harvest rates

clc

% Set plot bounds
t0 = 0;
tfinal = 100000;
tspan = [t0:10:tfinal];
y0 = [10^2; 0];  

% Insulin data
Y3 = ode45(@h,tspan,y0);


%plot(T, Y3(:,1),'DisplayName','Insulin Model for F3','LineWidth',3,'Color',[0.5,0,0.5,0.75]); % purple

% Initialize variables
n = zeros(1,100);
number = zeros(1,100);
g = zeros(1,100); % total amount of insulin produced in a week

% Calculate total amount of insulin produced at each harvest rate
for i = 1:100
    n(i) = i; % number of chunks
    number(i) = 60 * 24 * 7 / i; % time of each chunk

    g(i) = i*deval(Y3,number(i),2);
end

[amount_opt, no_of_chunks_opt] = max(g)

% Mamimum time to harvest
time_optimal = 60*24*7/no_of_chunks_opt

% Plot all harvest rates against the total insulin produced in a week
plot(n,g,LineWidth=2)
ax = gca;
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
xlabel('Number of harvests in a week',FontSize=22)
ylabel('Total insulin produced in a week (mg/mL)',FontSize=20)
title('Optimal Harvests in a Week (d = 1.75)',FontSize=22)
hold on

% Label optimal havest time and amount on plot
plot(no_of_chunks_opt,amount_opt,'k*',MarkerSize=10,LineWidth=1.5)
maxi_label = sprintf('Optimal harvest time = \n 44 segments of a week \n (229 minutes)');
text((no_of_chunks_opt+8),(amount_opt+0.02),maxi_label,FontSize=13)

hold off




% Bacteria #3
function dydt = h(t,y)
gN = 0.035*y(1)*(1 - y(1)/(10000)); % bact 3: k = 10^4
dI = 1.75*y(1)*y(2);
pI = 5e-8;

dydt = [(gN-dI); % bacteria
        (pI*y(1))]; % insulin
end
