maxi=10000;
best_iteration=0;
peniaze = 10000000;
maxIteration=10;
pocGen=5;
populacia=70;
numgen=2000;
matica=[ 0, 0, 0, 0, 0; peniaze, peniaze, peniaze, peniaze, peniaze];
alfa=0.9;
rate=0.4;
Amp=100.0*ones(1,pocGen);
for iteration=1:maxIteration
    Pop = zeros(populacia,5);
    while i:1:populacia
    Pop(i,:)= genpop(peniaze);
    end
for gen=1:numgen
    fitness=Fit(Pop,peniaze,populacia);
    graf(iteration,gen)= min(fitness);
    vyber=selbest(Pop,fitness,[1 1 1 1 1]);
    nevybrany=selbest(Pop,fitness,[0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1]);
    nahodny=selrand(Pop,fitness,10);
    turnajovy=seltourn(Pop,fitness,8);
    koleso=selsus(Pop,fitness,populacia-size(vyber,1)-size(nahodny,1)-size(turnajovy,1)-size(nevybrany,1));
    
    
    
    nahodny=around(nahodny,0,alfa,matica);
    nahodny=muta(nahodny,rate,Amp,matica);
    nahodny=shake(nahodny,rate);
    koleso=mutx(koleso,rate,matica);
    koleso=around(koleso,0,alfa,matica);
    koleso=shake(koleso,rate);
    turnajovy=around(turnajovy,0,alfa,matica);
    nevybrany=around(nevybrany,0,alfa,matica);
    turnajovy=muta(turnajovy,rate,Amp,matica);
    nevybrany=muta(nevybrany,rate,Amp,matica);
    nevybrany=shake(nevybrany,rate);
    turnajovy=shake(turnajovy,rate);
    vyber = muta(vyber,rate,Amp,matica);
    Pop=[vyber;nevybrany;nahodny;koleso;turnajovy];
end 
    
    if maxi > graf(iteration,end);
        maxi = graf(iteration,end);
        best_iteration = iteration;
    end
najlepsi(iteration,:)=selbest(Pop,fitness,1);

hold on;

plot(-graf(iteration,:));
end

najlepsi=najlepsi(end,:)
best_iteration
-maxi


function fitness = Fit(Pop, maxMoney, populacia)
    fitness = zeros(populacia, 1);

    for index = 1:populacia
        profit = 0;
        profit = profit + Pop(index, 1) * 0.04 + Pop(index, 2) * 0.07 + Pop(index, 3) * 0.11 + Pop(index, 4) * 0.06 + Pop(index, 5) * 0.05;
        budget = Pop(index, 1) + Pop(index, 2) + Pop(index, 3) + Pop(index, 4) + Pop(index, 5);

        if budget > maxMoney
            profit = 0;
            fitness(index) = 0;
            continue;
        end
        p4 = -0.5 * Pop(index, 1) - 0.5 * Pop(index, 2) + 0.5 * Pop(index, 3) + 0.5 * Pop(index, 4) - 0.5 * Pop(index, 5);

        if p4 > 0
            profit = 0;
            fitness(index) = 0;
            continue;
        end


        if  Pop(index, 1) + Pop(index, 2) > maxMoney / 4
            profit = profit - ((Pop(index, 1) + Pop(index, 2)) - maxMoney / 4)*2;
        end

        if Pop(index, 4) < Pop(index, 5)
            profit = profit - (Pop(index, 5) - Pop(index, 4));
        end


        fitness(index) = -profit;
    end
end

function [x1, x2, x3, x4, x5] = genpop(totalNumber)
        x1 = randi([0, totalNumber]);
        x2 = randi([0, totalNumber]);
        x3 = randi([0, totalNumber]);
        x4 = randi([0, totalNumber]);
        x5 = randi([0, totalNumber]);
end