x = [1, 5, 10, 15, 25, 50];
y = [1.634, 1.5875, 1.565, 1.495, 1.385, 1.022];


coefficients = polyfit(x,y,2);
yfit = polyval(coefficients, x);


scatter(x,y);
title("Frequency (rad/s) vs Gain");
xlabel("Frequency (rad/s)");
ylabel("Gain");

hold on
plot(x, yfit, 'r-', 'LineWidth', 2);
equationString = sprintf('y = %.5x^2x + %.5x + %.5f', coefficients(1), coefficients(2), coefficients(3));

text(25, 1.5, equationString, 'FontSize', 12, 'Color', 'red', 'FontWeight', 'bold');

grid on
hold off

