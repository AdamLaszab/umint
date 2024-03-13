clear  
x=2;
    d=0.5;
fun = @(x) 0.2*x.^4 + 0.2*x.^3 - 4*x.^2 + 10;

    x_values = linspace(-6, 6, 100);
    y_values = fun(x_values);

    plot(x_values, y_values, 'LineWidth', 2);
    hold on;

    answer = [x, fun(x)];
    while true
        y = fun(x);
        xL = x - d;
        xP = x + d;
        yL = fun(xL);
        yP = fun(xP);

        if (yL >= y && yP >= y)
            answer = [x, y];
            break;
        end

        if (yL < y)
            x = xL;
        end

        if (yP < y)
            x = xP;
        end
    end

    plot(answer(1), answer(2), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
    


    hold off;