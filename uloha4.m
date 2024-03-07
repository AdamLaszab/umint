final_fitnes=0;
max_money = 10000000;
max_iteration=25;
pocet_genov=5;
populacia=60;
numgen=2000;
Priestor=[ 0, 0, 0, 0, 0; max_money, max_money, max_money, max_money, max_money];
alfa=0.9;
rate=0.8;
Amp=100.0*ones(1,pocet_genov);
Pop = zeros(populacia,5);
for iteration=1:max_iteration
    while i:1:populacia
    Pop(i,:)= genpop(10000000);
    end
for gen=1:numgen
    ucelova_f=Fit(Pop,max_money,populacia);
    fitness_graf(iteration,gen)= -1*min(ucelova_f);
    
    best=selbest(Pop,ucelova_f,[1 1 1 1]);
    best2=selbest(Pop,ucelova_f,[0 0 0 0 1 1 1 1 1 1 1 1 1 1]);
    sel_0=selrand(Pop,ucelova_f,10);
    sel_1=selsus(Pop,ucelova_f,8);
    
    sel_2=selbest(Pop,ucelova_f,populacia-size(best,1)-size(sel_0,1)-size(sel_1,1)-size(best2,1));
    
    sel_0(:)=around(sel_0,0,alfa,Priestor);
    sel_1(:)=crossov(sel_1,2,0);
    
    sel_2(:)=mutx(sel_2,rate,Priestor);
    best2(:)=around(best2,0,alfa,Priestor);
    best2(2:end,:)=muta(best2(2:end,:),rate,Amp,Priestor);
    best(2:end,:)=muta(best(2:end,:),rate,Amp,Priestor);
    
    Pop(:)=[best;best2;sel_0;sel_1;sel_2];
end %gen

    if final_fitnes < fitness_graf(end);
        final_fitnes = fitness_graf(end);
    end
najlepsia_skupina(iteration,:)=selbest(Pop,ucelova_f,1);
najlepsia_hodnota(iteration)=fitness_graf(end);
fprintf('\n\n%2d spustenie: vysledok optimalneho riesenia: %4.4f \ns hodnotami: ',iteration,fitness_graf(end));
disp(najlepsia_skupina(iteration,:));

if iteration==1
    hold on
end

plot(fitness_graf(iteration,:));
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