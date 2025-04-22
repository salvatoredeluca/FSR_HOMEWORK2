close all
if ~exist('plots', 'dir')
    mkdir('plots');
end

% Calcola min/max
xd_min = min(xd.Data);
xd_max = max(xd.Data);
yd_min = min(yd.Data);
yd_max = max(yd.Data);

figure(1)

plot(xd.Data(:), yd.Data(:), 'LineWidth', 1.2, 'Color', 'b');
grid on
hold on
title(' Bernoulli leminscate trajectory ', 'Interpreter', 'latex')
plot(qi(1), qi(2), 'o', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r');
legend('Path', 'Initial position', 'Interpreter', 'latex', 'Location', 'best')

xlabel('x[m]', 'Interpreter', 'latex')
ylabel('y[m]', 'Interpreter', 'latex')
xlim([xd_min-0.8 , xd_max+0.8 ]);
ylim([yd_min-0.8 , yd_max+0.8 ]);

exportgraphics(gcf, 'plots/laminscata.pdf', 'ContentType', 'vector')

% figure(2)
% 
% plot(out.e1.Time(:), out.e1.Data(:), 'LineWidth', 1.2, 'Color', 'b');
% hold on
% grid on
% plot(out.e2.Time(:), out.e2.Data(:), 'LineWidth', 1.2, 'Color', 'm');
% title('Position errors', 'Interpreter', 'latex')
% legend('Error x-coordinate', 'Error y-coordinate', 'Interpreter', 'latex', 'Location', 'best');
% xlabel('t[s]', 'Interpreter', 'latex');
% ylabel('e[m]', 'Interpreter', 'latex');
% exportgraphics(gcf, 'plots/errors3.pdf', 'ContentType', 'vector')
% 
% figure(3)
% 
% plot(out.e3.Time(:), out.e3.Data(:), 'LineWidth', 1.2, 'Color', 'g');
% grid on
% title('Orientation error', 'Interpreter', 'latex')
% xlabel('t[s]', 'Interpreter', 'latex')
% ylabel('$e_{3}$ [rad]', 'Interpreter', 'latex')
% exportgraphics(gcf, 'plots/errors3_theta.pdf', 'ContentType', 'vector')

figure(4)


plot(out.v.Time(:), out.v.Data(:), 'LineWidth', 1.2, 'Color', 'k');
title('Heading Velocity command', 'Interpreter', 'latex')
grid on
xlabel('t[s]', 'Interpreter', 'latex');
ylabel('v [m/s]', 'Interpreter', 'latex');
exportgraphics(gcf, 'plots/v3.pdf', 'ContentType', 'vector')
hold on



figure(5)


plot(out.omega.Time(:), out.omega.Data(:), 'LineWidth', 1.2, 'Color', 'm');
title('Angular velocity command', 'Interpreter', 'latex')
grid on
xlabel('t[s]', 'Interpreter', 'latex');
ylabel('$\omega$ [rad/s]', 'Interpreter', 'latex');
exportgraphics(gcf, 'plots/omega3.pdf', 'ContentType', 'vector')


figure(6)

plot(out.x.Data(:),out.y.Data(:),'LineWidth',1.2,'Color','r');
hold on
grid on
plot(xd.Data(:), yd.Data(:), '--b' );
plot(qi(1), qi(2), 'o', 'MarkerEdgeColor', 'r');

legend('Tracked path','Reference','Initial position','Interpeter','latex','Location','best');
xlabel('x[m]', 'Interpreter', 'latex')
ylabel('y[m]', 'Interpreter', 'latex')
xlim([xd_min-0.8 , xd_max+0.8 ]);
ylim([yd_min-0.8 , yd_max+0.8 ]);



% Labeling and axis settings
xlabel('x[m]', 'Interpreter', 'latex')
ylabel('y[m]', 'Interpreter', 'latex')
xlim([xd_min - 0.8, xd_max + 0.8]);
ylim([yd_min - 0.8, yd_max + 0.8]);



exportgraphics(gcf, 'plots/executed3.pdf', 'ContentType', 'vector')

figure(7)

plot(out.e1.Time(:),sqrt(out.e1.Data(:).^2 + out.e2.Data(:).^2 + out.e3.Data(:).^2),'LineWidth',0.8,'Color','r');
xlabel('t[s]', 'Interpreter', 'latex')
ylabel('$|e(t)|$', 'Interpreter', 'latex')
title('Errors norm','Interpreter', 'latex')
xlim([0,T]);

grid on
exportgraphics(gcf, 'plots/errors_norm.pdf', 'ContentType', 'vector')