% Mona Parisi
% February 6, 2024
% Creating figure using GM bacteria with insulin 
% Only plots High Feeding Rate data F3

clc

load data_with_insulin.txt

time = data_with_insulin(:,1);

% LOW FEEDING RATE F1
% Get bacteria values and error
bact1_values = data_with_insulin(:,2);
bact1_err = data_with_insulin(:,3);
% Get insulin values and error
insul1_values = data_with_insulin(:,4);
insul1_err = data_with_insulin(:,5);

% MEDIUM FEEDING RATE F2
% Get bacteria values and error
bact2_values = data_with_insulin(:,6);
bact2_err = data_with_insulin(:,7);
% Get insulin values and error
insul2_values = data_with_insulin(:,8);
insul2_err = data_with_insulin(:,9);

% HIGH FEEDING RATE F3
% Get bacteria values and error
bact3_values = data_with_insulin(:,10);
bact3_err = data_with_insulin(:,11);
% Get insulin values and error
insul3_values = data_with_insulin(:,12);
insul3_err = data_with_insulin(:,13);



% Solve ODE to create bacteria-insulin population model

t0 = 0;
tfinal = time(end);
tspan = [t0:10:tfinal];
y0 = [10^2; 0];  

[T,Y3] = ode45(@h,tspan,y0);



% Plot bacteria values and error
errorbar(time,bact3_values,bact3_err,'DisplayName','Bacteria Experimental Data','LineWidth',1.5)
hold on

% Plot bacteria model
plot(T, Y3(:,1),'DisplayName','Bacteria Model','LineWidth',3,'Color',[0,0,1,0.5]); % purple

yscale log
title('Bacteria Model',FontSize=16)
xlabel('Time t (min)',FontSize=16)
ylabel('Bacteria population (millions per mL)',FontSize=16)
legend(FontSize=12)

hold off


figure
% Plot insulin values and error
errorbar(time,insul3_values,insul3_err,'DisplayName','Insulin Experimental Data','LineWidth',1.5)
hold on

% Plot insulin model
plot(T, Y3(:,2),'DisplayName','Insulin Model','LineWidth',3,'Color',[0,1,0,0.5]); % purple

yscale log
title('Insulin Model',FontSize=16)
xlabel('Time t (min)',FontSize=16)
ylabel('Insulin concentration (mg per mL)',FontSize=16) 
legend('location','se',FontSize=12)

hold off



% Bacteria #1
function dydt = f(t,y)
gN = 0.035*y(1)*(1 - y(1)/(100)); % bact 1: k = 10^2
dI = 1.75*y(1)*y(2);
pI = 5e-8;

dydt = [(gN-dI); % bacteria
        (pI*y(1))]; % insulin
end

% Bacteria #2
function dydt = g(t,y)
gN = 0.035*y(1)*(1 - y(1)/(1000)); % bact 2: k = 10^3
dI = 1.75*y(1)*y(2);
pI = 5e-8;

dydt = [(gN-dI); % bacteria
        (pI*y(1))]; % insulin
end

% Bacteria #3
function dydt = h(t,y)
gN = 0.035*y(1)*(1 - y(1)/(10000)); % bact 3: k = 10^4
dI = 1.75*y(1)*y(2);
pI = 5e-8;

dydt = [(gN-dI); % bacteria
        (pI*y(1))]; % insulin
end
