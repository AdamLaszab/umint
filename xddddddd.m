final_fitnes=0;
best_iteration=0;
max_money = 10000000;
max_iteration=25;
pocet_genov=5;
populacia=60;
numgen=2000;
matica=[ 0, 0, 0, 0, 0; max_money, max_money, max_money, max_money, max_money];
alfa=0.9;
rate=0.4;
Amp=100.0*ones(1,pocet_genov);
Pop = zeros(populacia,5);
for iteration=1:max_iteration
    while i:1:populacia
    Pop(i,:)= genpop(max_money);
    end
for gen=1:numgen
    ucelova_f=Fit(Pop,max_money,populacia);
    fitness_graf(iteration,gen)= min(ucelova_f);   
    vyber=selbest(Pop,ucelova_f,[1 1 1]);
    nevybrany=selbest(Pop,ucelova_f,[0 0 0 1 1 1 1 1 1 1 1 1 1]);
    nahodny=selrand(Pop,ucelova_f,10);
    turnajovy=seltourn(Pop,ucelova_f,8);
    koleso=selsus(Pop,ucelova_f,populacia-size(vyber,1)-size(nahodny,1)-size(turnajovy,1)-size(nevybrany,1));
    
    
    
    nahodny=around(nahodny,0,alfa,matica);
    koleso=crossov(koleso,2,0);
    koleso=mutx(koleso,rate,matica);
    koleso=around(koleso,0,alfa,matica);
    turnajovy=crossov(turnajovy,2,0);
    nevybrany=around(nevybrany,0,alfa,matica);
    nevybrany=muta(nevybrany,rate,Amp,matica);
    
    Pop=[vyber;nevybrany;nahodny;koleso;turnajovy];
end %gen

    if final_fitnes >= fitness_graf(end);
        final_fitnes = fitness_graf(end);
    end
najlepsia_skupina(iteration,:)=selbest(Pop,ucelova_f,1);
fprintf('\n\n%2d spustenie: vysledok optimalneho riesenia: %4.4f \ns hodnotami: ',iteration,fitness_graf(end));
disp(najlepsia_skupina(iteration,:));

hold on;

plot(-fitness_graf(iteration,:));
end
final_najlepsia_skupina=selbest(Pop,ucelova_f,1);
fprintf('\n\n\t\nglobalne [optimalne] riesenie je: %4.4f pri poradi: \n',final_fitnes);
disp(final_najlepsia_skupina);




function Fitness_f = Fit(Pop, maxMoney, populacia)
    Fitness_f = zeros(populacia, 1);

    for index = 1:populacia
        profit = 0;
        profit = profit + Pop(index, 1) * 0.04 + Pop(index, 2) * 0.07 + Pop(index, 3) * 0.11 + Pop(index, 4) * 0.06 + Pop(index, 5) * 0.05;
        budget = Pop(index, 1) + Pop(index, 2) + Pop(index, 3) + Pop(index, 4) + Pop(index, 5);

        if budget > maxMoney
            profit = 0;
            Fitness_f(index) = 0;
            continue;
        end
        p4 = -0.5 * Pop(index, 1) - 0.5 * Pop(index, 2) + 0.5 * Pop(index, 3) + 0.5 * Pop(index, 4) - 0.5 * Pop(index, 5);

        if p4 > 0
            profit = 0;
            Fitness_f(index) = 0;
            continue;
        end

        budgetInFonds = Pop(index, 1) + Pop(index, 2);

        if budgetInFonds > maxMoney / 4
            profit = profit - (budgetInFonds - maxMoney / 4)*3;
        end

        if Pop(index, 4) < Pop(index, 5)
            profit = profit - (Pop(index, 5) - Pop(index, 4));
        end


        Fitness_f(index) = -1 * (profit);
    end
end

function [x1, x2, x3, x4, x5] = genpop(totalNumber)
        x1 = randi([0, totalNumber]);
        x2 = randi([0, totalNumber]);
        x3 = randi([0, totalNumber]);
        x4 = randi([0, totalNumber]);
        x5 = randi([0, totalNumber]);
end