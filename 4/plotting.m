close all


close all
if ~exist('plots', 'dir')
    mkdir('plots');
end

% Calcola min/max
x_min = min(out.x.Data);
x_max = max(out.x.Data);
y_min = min(out.y.Data);
y_max = max(out.y.Data);

figure(1)

plot(out.x.Data(:), out.y.Data(:), 'LineWidth', 1.2, 'Color', 'b');
grid on
hold on
title(' Executed Path ', 'Interpreter', 'latex')
plot(qi(1), qi(2), 'o', 'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'r','MarkerSize',6);
plot(0,0,'o','MarkerFaceColor','m');
legend('Path', 'Initial position', 'Goal position','Interpreter', 'latex', 'Location', 'best')
plot(out.x.Data(end),out.y.Data(end),'o','MarkerFaceColor', 'k','MarkerSize',6)
xlabel('x[m]', 'Interpreter', 'latex')
ylabel('y[m]', 'Interpreter', 'latex')
xlim([x_min-0.05 , x_max+0.05 ]);
ylim([y_min-0.05 , y_max+0.05 ]);
legend('Path', 'Initial position', 'Goal position','Final position','Interpreter', 'latex', 'Location', 'best')

exportgraphics(gcf, 'plots/path_posture_regulator.pdf', 'ContentType', 'vector')

figure(2)

subplot(3,1,1)
plot(out.x.Time(:),out.x.Data(:),'LineWidth',1.2,'Color','r')
title('X-Coordinate','Interpreter','latex')
grid on
xlabel('t[s]','Interpreter','latex')
ylabel('x[m]','Interpreter','latex')
ylim([min(out.x.Data(:))-0.1, max(out.x.Data(:)+0.1)])
subplot(3,1,2)

plot(out.y.Time(:),out.y.Data(:),'LineWidth',1.2,'Color','m')
grid on
title('Y-Coordinate','Interpreter','latex')
xlabel('t[s]','Interpreter','latex')
ylabel('y[m]','Interpreter','latex')
ylim([min(out.y.Data(:))-0.1, max(out.y.Data(:)+0.1)])

subplot(3,1,3)
plot(out.theta.Time(:),out.theta.Data(:),'LineWidth',1.2,'Color','b')
grid on
title('Orientation','Interpreter','latex')
xlabel('t[s]','Interpreter','latex')
ylabel('$\theta$[rad]','Interpreter','latex')
ylim([min(out.theta.Data(:))-0.1, max(out.theta.Data(:)+0.1)])

exportgraphics(gcf, 'plots/coordinates_posture.pdf', 'ContentType', 'vector')

figure(3)

subplot(2,1,1)
plot(out.v.Time(:),out.v.Data(:),'LineWidth',1.2,'Color','r')
title('Heading velocity','Interpreter','latex')
grid on
xlabel('t[s]','Interpreter','latex')
ylabel('v[m/s]','Interpreter','latex')
ylim([min(out.v.Data(:))-1, max(out.v.Data(:)+1)])
%xlim([0,12]);


subplot(2,1,2)
plot(out.omega.Time(:),out.omega.Data(:),'LineWidth',1.2,'Color','b')
title('Angular velocity','Interpreter','latex')
xlabel('t[s]','Interpreter','latex')
ylabel('$\omega$[rad/s]','Interpreter','latex')
ylim([min(out.omega.Data(:))-1, max(out.omega.Data(:)+1)])
%xlim([0,12]);
grid on
exportgraphics(gcf, 'plots/velocities_postures.pdf', 'ContentType', 'vector')
