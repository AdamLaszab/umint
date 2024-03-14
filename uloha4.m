clear
maxi=10000;
best_iteration=0;
peniaze = 10000000;
maxIteration=10;
pocGen=5;
populacia=80;
numgen=2000;
matica=[ 0, 0, 0, 0, 0; peniaze, peniaze, peniaze, peniaze, peniaze];
rate=0.7;
Amp=100000.0*ones(1,pocGen);
for iteration=1:maxIteration
    Pop = zeros(populacia,5);
    for i = 1:populacia
    Pop(i,:) = genpop(peniaze);
    end
for gen=1:numgen
    fitness=FitIbaMrtve(Pop,peniaze,populacia);
    graf(iteration,gen)= min(fitness);
    top=selbest(Pop,fitness,[1]);
    vyber=selbest(Pop,fitness,[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]);
    nahodny=selrand(Pop,fitness,10);
    turnajovy=seltourn(Pop,fitness,20);
    koleso=selsus(Pop,fitness,populacia-size(vyber,1)-size(nahodny,1)-size(turnajovy,1));
    
    nahodny=crossov(nahodny,3,0);
    turnajovy=crossov(turnajovy,3,0);
    nahodny=muta(nahodny,rate,Amp,matica);
    koleso=mutx(koleso,rate,matica);
    koleso=crossov(koleso,3,0);
    turnajovy=muta(turnajovy,rate,Amp,matica);
    vyber = muta(vyber,rate,Amp,matica);
    vyber = crossov(vyber,3,0);
    Pop=[vyber;nahodny;koleso;turnajovy];
end 
    
    if maxi > graf(iteration,end);
        maxi = graf(iteration,end);
        best_iteration = iteration;
    end
najlepsi(iteration,:)=top;

hold on;

plot(-graf(iteration,:));
end

najlepsi=najlepsi(best_iteration,:)
best_iteration
-maxi


function fitness = FitKombinovane(Pop, maxMoney, populacia)
    fitness = zeros(populacia, 1);

    for index = 1:populacia
        profit = 0;
        profit = profit + Pop(index, 1) * 0.04 + Pop(index, 2) * 0.07 + Pop(index, 3) * 0.11 + Pop(index, 4) * 0.06 + Pop(index, 5) * 0.05;
        budget = Pop(index, 1) + Pop(index, 2) + Pop(index, 3) + Pop(index, 4) + Pop(index, 5);
        
        
        %mrtve pokuty
        if budget > maxMoney
            profit = 0;
            fitness(index) = 0;
            continue;
        end

        if -0.5 * Pop(index, 1) - 0.5 * Pop(index, 2) + 0.5 * Pop(index, 3) + 0.5 * Pop(index, 4) - 0.5 * Pop(index, 5) > 0
            profit = 0;
            fitness(index) = 0;
            continue;
        end
        
        %pokuta umerna miere porusenia obmedzeni
        if Pop(index, 4) < Pop(index, 5)
            profit = profit - (Pop(index, 5) - Pop(index, 4));
        end
        
        if  Pop(index, 1) + Pop(index, 2) > 2500000
             profit = profit - ((Pop(index, 1) + Pop(index, 2)) - 2500000);
        end
        


        fitness(index) = -profit;
    end
end
function fitness = FitIbaMrtve(Pop, maxMoney, populacia)
    fitness = zeros(populacia, 1);

    for index = 1:populacia
        profit = 0;
        profit = profit + Pop(index, 1) * 0.04 + Pop(index, 2) * 0.07 + Pop(index, 3) * 0.11 + Pop(index, 4) * 0.06 + Pop(index, 5) * 0.05;
        budget = Pop(index, 1) + Pop(index, 2) + Pop(index, 3) + Pop(index, 4) + Pop(index, 5);
        
        
        %mrtve pokuty
        if budget > maxMoney
            profit = 0;
            fitness(index) = 0;
            continue;
        end

        if -0.5 * Pop(index, 1) - 0.5 * Pop(index, 2) + 0.5 * Pop(index, 3) + 0.5 * Pop(index, 4) - 0.5 * Pop(index, 5) > 0
            profit = 0;
            fitness(index) = 0;
            continue;
        end

        if Pop(index, 4) < Pop(index, 5)
            profit = 0;
            fitness(index) = 0;
            continue;
        end

        if  Pop(index, 1) + Pop(index, 2) > 2500000
            profit = 0;
            fitness(index) = 0;
            continue;
        end
        


        fitness(index) = -profit;
    end
end
function fitness = FitIbaUmiernene(Pop, maxMoney, populacia)
    fitness = zeros(populacia, 1);

    for index = 1:populacia
        profit = 0;
        profit = profit + Pop(index, 1) * 0.04 + Pop(index, 2) * 0.07 + Pop(index, 3) * 0.11 + Pop(index, 4) * 0.06 + Pop(index, 5) * 0.05;
        budget = Pop(index, 1) + Pop(index, 2) + Pop(index, 3) + Pop(index, 4) + Pop(index, 5);
        
        
        if budget > maxMoney
            profit = profit-(budget-maxMoney);
        end

        if -0.5 * Pop(index, 1) - 0.5 * Pop(index, 2) + 0.5 * Pop(index, 3) + 0.5 * Pop(index, 4) - 0.5 * Pop(index, 5) > 0
            profit = profit -(-0.5 * Pop(index, 1) - 0.5 * Pop(index, 2) + 0.5 * Pop(index, 3) + 0.5 * Pop(index, 4) - 0.5 * Pop(index, 5));
        end

       if Pop(index, 4) < Pop(index, 5)
            profit = profit - (Pop(index, 5) - Pop(index, 4));
        end

        if  Pop(index, 1) + Pop(index, 2) > 2500000
            profit = profit - ((Pop(index,2)+Pop(index,1))-2500000);
        end
        
        

        fitness(index) = -profit;
    end
end
function fitness = FitIbaStupnovite(Pop, maxMoney, populacia)
    fitness = zeros(populacia, 1);

    for index = 1:populacia
        profit = 0;
        profit = profit + Pop(index, 1) * 0.04 + Pop(index, 2) * 0.07 + Pop(index, 3) * 0.11 + Pop(index, 4) * 0.06 + Pop(index, 5) * 0.05;
        budget = Pop(index, 1) + Pop(index, 2) + Pop(index, 3) + Pop(index, 4) + Pop(index, 5);
        pocetObmedzeni=0;
        
        if budget > maxMoney
           pocetObmedzeni=pocetObmedzeni+1;
        end

        if -0.5 * Pop(index, 1) - 0.5 * Pop(index, 2) + 0.5 * Pop(index, 3) + 0.5 * Pop(index, 4) - 0.5 * Pop(index, 5) > 0
            pocetObmedzeni=pocetObmedzeni+1;
        end

       if Pop(index, 4) < Pop(index, 5)
            pocetObmedzeni=pocetObmedzeni+1;
        end

        if  Pop(index, 1) + Pop(index, 2) > 2500000
           pocetObmedzeni=pocetObmedzeni+1;
        end
        
        

        fitness(index) = -(profit-(10000000*pocetObmedzeni));
    end
end
function [x1, x2, x3, x4, x5] = genpop(totalNumber)
        x1 = randi([0, totalNumber]);
        x2 = randi([0, totalNumber]);
        x3 = randi([0, totalNumber]);
        x4 = randi([0, totalNumber]);
        x5 = randi([0, totalNumber]);
end