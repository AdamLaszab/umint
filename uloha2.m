matica=ones(2,10).*[-500;500];
rate=0.6;
for i = 1:5
    firstpop = genrpop(10, [-500 -500 -500 -500 -500 -500 -500 -500 -500 -500; 500 500 500 500 500 500 500 500 500 500]);
    for gen = 1:1000
        fitness = testfn3(firstpop);
        graph(i,gen)= min(fitness);
        vyber = selbest(firstpop, fitness, [0 0 0 0 0 0 0 0 1 1]);
        nahodny=selrand(firstpop,fitness,8);
        koleso=selsus(firstpop,fitness,4);
        nahodny=around(nahodny,0,0.9,matica);
        nevybrany = selbest(firstpop, fitness, [1 1 1 1 1 1 1 1 0 0]);
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
