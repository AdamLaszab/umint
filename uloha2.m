maxIterations = 5;
maxGeneration = 1000;
popCount = 25;
matica=ones(2,10).*[-500;500];
rate=0.4;
for i = 1:maxIterations
    firstpop = genrpop(popCount,matica);
    for gen = 1:maxGeneration
        fitness = testfn3(firstpop);
        graph(i,gen)= min(fitness);
        vyber = selbest(firstpop, fitness, [1 1]);
        nevybrany = selbest(firstpop, fitness, [0 0 1 1 1 1 1 1 1 1]);
        nahodny=selrand(firstpop,fitness,6);
        krizenyvybrany=crossov(vyber,2,0);
        koleso=selsus(firstpop,fitness,popCount-size(vyber,1)-size(nevybrany,1)-size(nahodny,1)-size(krizenyvybrany,1));
        nahodny=mutx(koleso,rate,matica);
        nevybrany = crossov(nevybrany, 2, 0);
        nevybrany = mutx(nevybrany,rate,matica);
        koleso = mutx(koleso,rate,matica);
        koniec = [vyber;nahodny;nevybrany;krizenyvybrany;koleso];
        firstpop = koniec;
    end
    hold on
    plot(graph(i,:));
end
hold off;
