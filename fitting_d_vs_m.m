% Finding a power rule function that fits the plot of bacteria death rate d 
% vs maximum insulin produced m
% 
% plot(deathrate,amount_optimal,'+r'), hold on
% p = polyfit(log(deathrate),log(amount_optimal),1); 
% m = p(1);
% b = exp(p(2));
% ezplot(@(deathrate) b*deathrate.^m,[deathrate(2) deathrate(end)])

clc 

x = deathrate + 0.01;
y = amount_optimal;

coeff = nlinfit(x,y,@fun,[-0.12; log(y(1))])

plot(x,y)
hold on
%plot(x,exp(0.3499)*(x+0.01).^(-0.4186))
%plot(x, exp(0.8665)*(x+0.01).^(-0.2147) - 0.95)

plot(x, exp(coeff(2))*(x).^(coeff(1)) - 0.95);


function [y]=fun(beta,x)
a = beta(1);
b = beta(2);
y = b*x.^(a);
end
