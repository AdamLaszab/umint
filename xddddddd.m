function [x1,x2,x3,x4,x5] = genpop(totalNumber)
while true
    randomNumbers = rand(1, 4);

    scalingFactors = randomNumbers / sum(randomNumbers);

    x1 = round(scalingFactors(1) * totalNumber);
    x2 = round(scalingFactors(2) * totalNumber);
    x3 = round(scalingFactors(3) * totalNumber);

    x4 = randi([1, totalNumber - x1 - x2 - x3 - 1]);
    x5 = totalNumber - (x1 + x2 + x3 + x4);

    
    if x4 > x5 && x1+x2<2500000 && x3+x4<5000000
        break;  
    end
end
end
function fitness = fitnessFunction(pop)
    for i = 1:popCount
        fitness(:)= 0.04*pop(i,1)+0.07*pop(i,2)+0.11*pop(i,3)+0.06*pop(i,4)+0.05*pop(i,5);
    end
end