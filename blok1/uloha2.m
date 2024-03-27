clear
maxi=10000;
maxIterations = 5;
maxGeneration = 1000;
pocPop = 25;
matica=ones(2,10).*[-500;500];
Amp=100.0*ones(1,pocPop);
rate=0.1;
bestIteration = 0;
for i = 1:maxIterations
    firstpop = genrpop(pocPop,matica);
    for gen = 1:maxGeneration
        fitness = testfn3(firstpop);
        graph(i,gen)= min(fitness);
        top = selbest(firstpop,fitness,[1]);
        vyber = selbest(firstpop, fitness, [1 1]);
        nevybrany = selbest(firstpop, fitness, [0 0 1 1 1 1 1 1 1 1]);
        nahodny=selrand(firstpop,fitness,6);
        krizenyvybrany=crossov(vyber,2,0);
        koleso=selsus(firstpop,fitness,pocPop-size(vyber,1)-size(nevybrany,1)-size(nahodny,1)-size(krizenyvybrany,1));
        nahodny=mutx(koleso,rate,matica);
        nevybrany = crossov(nevybrany, 2, 0);
        nevybrany = muta(nevybrany,rate,Amp,matica);
        koleso = mutx(koleso,rate,matica);
        koniec = [vyber;nahodny;nevybrany;krizenyvybrany;koleso];
        firstpop = koniec;
    end
    if maxi > graph(i,end)
        maxi= graph(i, end);
        bestIteration = i;
    end
    najlepsi(i,:)=top;
    hold on
    plot(graph(i,:));
end
bestIteration
najlepsi=najlepsi(bestIteration,:)
hold off;
