% Mona Parisi
% February 6, 2024
% Creating figure using GM bacteria with insulin 

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

[T,Y1] = ode45(@f,tspan,y0);
[T,Y2] = ode45(@g,tspan,y0);
[T,Y3] = ode45(@h,tspan,y0);



% Plot bacteria values and error
% errorbar(time,bact1_values,bact1_err,'DisplayName','Bacteria Data for F1','LineWidth',1.5)
% hold on
% errorbar(time,bact2_values,bact2_err,'DisplayName','Bacteria Data for F2','LineWidth',1.5)
errorbar(time,bact3_values,bact3_err,'DisplayName','Bacteria Experimental Data','LineWidth',1.5)
hold on

% Plot bacteria model
% plot(T, Y1(:,1),'DisplayName','Bacteria Model for F1','LineWidth',3,'Color',[1,0.5,0,0.75]); % orange
% plot(T, Y2(:,1),'DisplayName','Bacteria Model for F2','LineWidth',3,'Color',[0,0.7,0,0.75]); % green
plot(T, Y3(:,1),'DisplayName','Bacteria Model','LineWidth',3,'Color',[0,0,1,0.5]); % purple
ax = gca;
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
title('Bacteria Model',FontSize=22,Interpreter='latex')
% title('Bacteria Model, $d$ = 0.0',FontSize=22,Interpreter='latex')
xlabel('Time $t$ (min)',FontSize=22,Interpreter='latex')
ylabel('Bacteria population $N$ (millions per mL)',FontSize=22,Interpreter='latex')
legend('location','ne',FontSize=18,Interpreter='latex')

hold off


figure
% Plot insulin values and error
% errorbar(time,insul1_values,insul1_err,'DisplayName','Insulin Data for F1','LineWidth',1.5)
% hold on
% errorbar(time,insul2_values,insul2_err,'DisplayName','Insulin Data for F2','LineWidth',1.5)
errorbar(time,insul3_values,insul3_err,'DisplayName','Insulin Experimental Data','LineWidth',1.5)
hold on

% Plot insulin model
% plot(T, Y1(:,2),'DisplayName','Insulin Model for F1','LineWidth',3,'Color',[1,0.5,0,0.75]); % orange
% plot(T, Y2(:,2),'DisplayName','Insulin Model for F2','LineWidth',3,'Color',[0, 0.7,0,0.75]); % green
plot(T, Y3(:,2),'DisplayName','Insulin Model','LineWidth',3,'Color',[0,1,0,0.5]); % purple
ax = gca
ax.XAxis.FontSize = 20;
ax.YAxis.FontSize = 20;
title('Insulin Model',FontSize=22,Interpreter='latex')
% title('Insulin Model, $d$ = 0.0',FontSize=22,Interpreter='latex')
xlabel('Time $t$ (min)',FontSize=22,Interpreter='latex')
ylabel('Insulin concentration $I$ (mg per mL)',FontSize=22,Interpreter='latex') 
legend('location','se',FontSize=18,Interpreter='latex')

hold off

% Find maximum error
b1_maxerr = norm(bact1_values - Y1(:,1),Inf)
b2_maxerr = norm(bact2_values - Y2(:,1),Inf)
b3_maxerr = norm(bact3_values - Y3(:,1),Inf)
i1_maxerr = norm(insul1_values - Y1(:,2),Inf)
i2_maxerr = norm(insul2_values - Y2(:,2),Inf)
i3_maxerr = sprintf('%10e',norm(insul3_values - Y3(:,2),Inf))


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
% dI = 0;
dI = 1.75*y(1)*y(2);
pI = 5e-8;

dydt = [(gN-dI); % bacteria
        (pI*y(1))]; % insulin
end
