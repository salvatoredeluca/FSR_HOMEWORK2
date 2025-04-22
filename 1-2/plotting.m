close all
if ~exist('plots', 'dir')
    mkdir('plots');
end

%%PLANNED PATH
figure(1)
plot(x_s, y_s, 'LineWidth', 1.2, 'Color', "b")
grid on
hold on

x_max_v = x_s(index_v_max);
y_max_v = y_s(index_v_max);
x_max_omega = x_s(index_omega_max);
y_max_omega = y_s(index_omega_max);

plot(x_max_v, y_max_v, 'ro', 'MarkerFaceColor', 'r');
plot(x_max_omega, y_max_omega, 'mo', 'MarkerFaceColor', 'm');

xlabel('x [m]', 'Interpreter', 'latex')
ylabel('y [m]', 'Interpreter', 'latex')
title(sprintf('Planned Path (duration : %.2f s)', T), 'Interpreter', 'latex')
legend('Path'...
       ,sprintf('$v_{max}$ = %.2f m/s', v_max), ...
       sprintf('$\\omega_{max}$ = %.2f rad/s', omega_max), ...
       'Interpreter', 'latex', 'Location', 'best', 'FontSize', 11);


exportgraphics(gcf, 'plots/cubic_polynomial.pdf', 'ContentType', 'vector')

% % Figura 2
% figure(2)
% plot(t, s, 'LineWidth', 1.2, 'Color', 'r');
% title('Arc Length $s(t)$', 'Interpreter', 'latex')
% ylabel('$[m]$', 'Interpreter', 'latex')
% xlabel('Time [s]', 'Interpreter', 'latex')
% grid on
% 
% exportgraphics(gcf, 'plots/s.pdf', 'ContentType', 'vector')
% 
% % Figura 3
% figure(3)
% plot(t, sdot, 'LineWidth', 1.2, 'Color', 'k');
% title('Time derivative of the Arc Length $\dot{s}(t)$', 'Interpreter', 'latex')
% ylabel('$[m/s]$', 'Interpreter', 'latex')
% ylim([0, max(sdot)+0.02]);
% xlabel('Time [s]', 'Interpreter', 'latex')
% grid on
% 
% exportgraphics(gcf, 'plots/sdot.pdf', 'ContentType', 'vector')

%%EXECUTED PATH
% Figure
figure(4)
plot(out.x.Data(:), out.y.Data(:), 'r', 'LineWidth', 1.2);
hold on
plot(x_s(:), y_s(:), '--b', 'LineWidth', 1);


% Plot details
title('Executed Path', 'Interpreter', 'latex')
legend('Executed Path','Reference','Location','best','Interpreter', 'latex');
xlabel('$x\,[m]$', 'Interpreter', 'latex');
ylabel('$y\,[m]$', 'Interpreter', 'latex');
grid on;


exportgraphics(gcf, 'plots/executed_path.pdf', 'ContentType', 'vector')

%%ERRORS
%Figura 5
figure(5)

e_x=timeseries(out.e1.Data(:)-b.*cos(out.theta.Data(:))+b.*cos(theta_s(:)),t);
e_y=timeseries(out.e2.Data(:)-b.*sin(out.theta.Data(:))+b.*sin(theta_s(:)),t);
e_theta=timeseries(out.theta.Data(:)-theta_s_t.Data(:),t);
subplot(3,1,1)

plot(e_x.Time(:),e_x.Data(:),'LineWidth', 1.2, 'Color', 'r');
title('error on x-coordinate', 'Interpreter', 'latex')
ylabel('$e_{x} [m]$', 'Interpreter', 'latex')
xlabel('$t [s] $', 'Interpreter', 'latex')
xlim([0,T]);
ylim([min(e_x.Data(:))+0.75*min(e_x.Data(:)), max(e_x.Data(:)+0.75*max(e_x.Data(:)))])

grid on
subplot(3,1,2)
plot(e_y.Time(:),e_y.Data(:),'LineWidth', 1.2, 'Color', 'm');
title('error on y-coordinate', 'Interpreter', 'latex')
ylabel('$e_{y} [m]$', 'Interpreter', 'latex')
xlabel('$t [s] $', 'Interpreter', 'latex')
grid on;
xlim([0,T]);
ylim([min(e_y.Data(:))+0.75*min(e_y.Data(:)), max(e_y.Data(:)+0.75*max(e_y.Data(:)))])

subplot(3,1,3)
plot(e_theta.Time(:),e_theta.Data(:),'LineWidth', 1.2, 'Color', 'k');
title('orientation error', 'Interpreter', 'latex')
ylabel('$e_{\theta} [rad]$', 'Interpreter', 'latex')
xlabel('$t [s] $', 'Interpreter', 'latex')
xlim([0,T]);
ylim([min(e_theta.Data(:))+0.75*min(e_theta.Data(:)), max(e_theta.Data(:)+0.75*max(e_theta.Data(:)))])
grid on;



exportgraphics(gcf, 'plots/errors.pdf', 'ContentType', 'vector')

%%EXECUTED VELOCITIES
%Figura 6
figure(6)
subplot(2,1,1)
plot(out.v.Time(:),out.v.Data(:),'LineWidth', 1.2, 'Color', 'b');
title('Heading Velocity', 'Interpreter', 'latex')
ylabel('$v [m/s]$', 'Interpreter', 'latex')
xlabel('$t [s] $', 'Interpreter', 'latex')
grid on;
ylim([min(out.v.Data(:))-0.01, max(out.v.Data(:)+0.01)])

subplot(2,1,2)
plot(out.omega.Time(:),out.omega.Data(:),'LineWidth', 1.2, 'Color', 'r');

title('Angular Velocity', 'Interpreter', 'latex')
ylabel('$\omega [rad/s]$', 'Interpreter', 'latex')
xlabel('$t [s] $', 'Interpreter', 'latex')
grid on;

exportgraphics(gcf, 'plots/vomega.pdf', 'ContentType', 'vector')


%%EVOLUTION OF THE COORDINATES


figure(8)
subplot(3, 1, 1);  % Primo subplot (2 righe, 1 colonna, posizione 1)
plot(t, x_s,'LineWidth',1.2,'Color','b');
ylabel('x[m]','Interpreter','latex')
xlabel('t[s]','Interpreter','latex')
ylim([min(x_s)-0.02,max(x_s)+0.1]);
xlim([0,T]);
grid on


subplot(3, 1, 2);  % Secondo subplot (posizione 2)
plot(t, y_s,'LineWidth',1.2,'Color','r');
ylabel('y[m]','Interpreter','latex')
xlabel('t[s]','Interpreter','latex')
ylim([min(y_s)-0.01,max(y_s)+0.1]);
xlim([0,T]);
grid on

subplot(3,1,3)
plot(t,theta_s,'LineWidth',1.2,'Color','k');
ylabel('$\theta$[rad]','Interpreter','latex')
xlabel('t[s]','Interpreter','latex')
ylim([min(theta_s)-0.02,max(theta_s)+0.1]);
xlim([0,T]);
grid on
exportgraphics(gcf, 'plots/xytheta.pdf', 'ContentType', 'vector')




%%PLANNE VELOCITIES
figure(10)
t_initial=0:Ts:2;
plot(t_initial,omega_initial,"LineWidth",1.2,"Color",'b');
ylabel('$\omega$ [rad/s]', 'Interpreter', 'latex')
xlabel('$t$ [s]', 'Interpreter', 'latex')
ylim([min(omega_initial)-0.1, max(omega_initial)+0.1]);
xlim([0,T]);
grid on
hold on
plot(t,omega,"LineWidth",1.2,"Color",'m');
[o_max,index_o_max]=max(omega);
plot(t(index_o_max),o_max,'o','MarkerFaceColor','m');

legend('$\omega(t)$','$\omega_{scaled}(t)$',sprintf('$\\omega_{max}$=%.2f [rad/s]',o_max),'Interpreter','latex')
exportgraphics(gcf, 'plots/planned_omega.pdf', 'ContentType', 'vector')
figure(11)
t_initial=0:Ts:2;
plot(t_initial,v_initial,"LineWidth",1.2,"Color",'k');
ylabel('$v$ [m/s]', 'Interpreter', 'latex')
xlabel('$t$ [s]', 'Interpreter', 'latex')
ylim([min(v_initial)-0.1, max(v_initial)+0.1]);
xlim([0,T]);
grid on
hold on
plot(t,v,"LineWidth",1.2,"Color",'r');
[v_max,index_v_max]=max(v);
plot(t(index_v_max),v_max,'o','MarkerFaceColor','r');

legend('$v(t)$','$v_{scaled}(t)$',sprintf('$v_{max}$=%.2f [m/s]',v_max),'Interpreter','latex')
exportgraphics(gcf, 'plots/planned_v.pdf', 'ContentType', 'vector')
