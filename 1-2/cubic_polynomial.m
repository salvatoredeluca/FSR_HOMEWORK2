close all
clear
clc

R=0.2; %unicycle's radius [m]
b=0.1; %point B distance [m]
Ts=0.01; %sampling time [s]

k1=2;
k2=2;

qi=[0,0,0]'; %initial configuration 


 qf=[0.028 0.67 0.73]';


% qf=rand(1,3)';
qf=qf/norm(qf); %final configuration


xi=qi(1);yi=qi(2);thetai=qi(3);
xf=qf(1);yf=qf(2);thetaf=qf(3);

i=0;
l=1; %path's lenght

%Iterate the loop by increasing the duration until the speed limit values are met
while true
    
    
    T=2+i; %duration [s]

    t=0:Ts:T;

    %compute arc lenght s(t) as a cubi polynomial function of time
    a2=3*l/T^2;
    a3=-2*l/T^3;
    s=a3.*power(t,3)+a2.*power(t,2); 
    sdot=3*a3.*power(t,2)+2*a2.*t;
    
    k=1;
    
    alphax=k*cos(thetaf)-3*xf;
    alphay=k*sin(thetaf)-3*yf;
    betax=k*cos(thetai)+3*xi;
    betay=k*sin(thetai)+3*yi;

    %compute the path express via the arc lenght s(t) and its firs and second
    %derivative with respect to s

    x_s=power(s,3).*xf-power(s-1,3).*xi+alphax.*power(s,2).*(s-1)+betax.*s.*power(s-1,2);
    y_s=power(s,3).*yf-power(s-1,3).*yi+alphay.*power(s,2).*(s-1)+betay.*s.*power(s-1,2);
    
    x_prime_s=3*xf.*power(s,2)-3.*power(s-1,2).*xi+alphax.*power(s,2)+2*alphax.*s.*(s-1)+betax.*power(s-1,2)+2*betax.*s.*(s-1);
    y_prime_s=3*yf.*power(s,2)-3.*power(s-1,2).*yi+alphay.*power(s,2)+2*alphay.*s.*(s-1)+betay.*power(s-1,2)+2*betay.*s.*(s-1);
    
    x_dprime_s=6*(xf-xi+alphax+betax).*s+6*xi-2*alphax-4*betax;
    y_dprime_s=6*(yf-yi+alphay+betay).*s+6*yi-2*alphay-4*betay;
    
    %compute geometric velocities v(s) omega(s)
    v_tilde=sqrt(power(x_prime_s,2)+power(y_prime_s,2));
    omega_tilde=(y_dprime_s.*x_prime_s-x_dprime_s.*y_prime_s)./power(v_tilde,2);
    
    %compute actual velocities v(t) omega(t)
    v=v_tilde.*sdot;
    omega=omega_tilde.*sdot;
    if i==0
        v_initial=v;
        omega_initial=omega;
    end
    %retrieve the maximum value
    [v_max,index_v_max]=max(abs(v));
    [omega_max,index_omega_max]=max(abs(omega));

    if omega_max<=2 && v_max<=0.5
        break;
    end
    i=i+0.5;
   

end

%point B path
theta_s=atan2(y_prime_s,x_prime_s);

y_1d=b.*cos(theta_s)+x_s;
y_2d=b.*sin(theta_s)+y_s;

y_1d=timeseries(y_1d,t);
y_2d=timeseries(y_2d,t);




y_1d_dot=timeseries(gradient(y_1d.Data(:),Ts),t);
y_2d_dot=timeseries(gradient(y_2d.Data(:),Ts),t);


theta_s_t=timeseries(theta_s,t);



