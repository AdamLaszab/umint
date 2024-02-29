maxIterations = 5;
maxGeneration = 1000;
popCount = 25;
matica=ones(2,10).*[-500;500];
rate=0.6;
for i = 1:maxIterations
    firstpop = genrpop(popCount,matica);
    for gen = 1:maxGeneration
        fitness = testfn3(firstpop);
        graph(i,gen)= min(fitness);
        vyber = selbest(firstpop, fitness, [1 1]);
        nevybrany = selbest(firstpop, fitness, [0 0 1 1 1 1 1 1 1 1]);
        nahodny=selrand(firstpop,fitness,6);
        koleso=selsus(firstpop,fitness,popCount-2-8-6);
        nahodny=around(nahodny,0,0.9,matica);
        krizeny = crossov(nevybrany, 2, 0);
        mutovany = mutx(krizeny,rate,matica);
        krizenyvybrany=crossov(vyber,2,0);
        koniec = [mutovany; vyber;nahodny;krizeny;krizenyvybrany;koleso];
        firstpop = koniec;
    end
    hold on
    plot(graph(i,:));
end
hold off;
