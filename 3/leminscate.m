clear 
close all
clc

alpha=1;
Ts=0.01; %sampling time [s]
T=4*pi/(alpha+1); %duration [s]
t=0:Ts:T;

r=10;
R=0.2;

%trajectory, first and second derivatives
xd=timeseries(r.*cos((alpha+1)*t)./(1+sin((alpha+1)*t).^2),t);
yd=timeseries(r.*cos((alpha+1)*t).*sin((alpha+1)*t)./(1+sin((alpha+1)*t).^2),t);

% xd_dot=timeseries(-(2.*r.*sin(2*t))./(sin(2*t).^2 + 1) - (4.*r.*cos(2*t).^2.*sin(2*t))./(sin(2*t).^2 + 1).^2);
% yd_dot=timeseries((2.*r.*cos(2*t).^2)./(sin(2*t).^2 + 1) - (2.*r.*sin(2*t).^2)/(sin(2*t).^2 + 1) - (4.*r.*cos(2*t).^2.*sin(2*t).^2)/(sin(2*t).^2 + 1).^2,t);
% 
% xd_dotdot=timeseries((4.*r.*cos(2*t).*(10.*cos(2*t).^2 + cos(2*t).^4 - 8))./(cos(2*t).^2 - 2).^3,t);
% yd_dotdot=timeseries((r.*(14.*sin(4*t) + 3.*sin(8*t)))./(cos(2*t).^2 - 2).^3,t);



xd_dot=timeseries(gradient(xd.Data(:),Ts),t);
yd_dot=timeseries(gradient(yd.Data(:),Ts),t);
xd_dotdot=timeseries(gradient(xd_dot.Data(:),Ts),t);
yd_dotdot=timeseries(gradient(yd_dot.Data(:),Ts),t);


vd=timeseries(sqrt(xd_dot.Data.^2+yd_dot.Data.^2),t);
omegad=timeseries((yd_dotdot.Data .* xd_dot.Data - xd_dotdot.Data .* yd_dot.Data)./vd.Data.^2,t);

%corresponding orientation (exploiting differential flateness)
thetad=timeseries(atan2(yd_dot.Data, xd_dot.Data),t);


qi=[0,0,0]';

x0 = xd.Data(1);
y0 = yd.Data(1);


theta = 2 * pi * rand();      
r = 0.5 * sqrt(rand());       
qi(1) = x0 + r * cos(theta);  
qi(2) = y0 + r * sin(theta);  
