Points = [0,0; 77,68; 12,75; 32,17; 51,64; 20,19; 72,87; 80,37; 35,82;
          2,15; 18,90; 33,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60;
          100,100]';

maxi = 10000;
numGenes = 18;
najlepsiaCesta = zeros(1, numGenes);
populationSize = 30;
maxGenerations = 1000;
maxIterations = 10;
crossoverRate = 0.2;
minValue = 2;
maxValue = numGenes+1;
for iteration = 1:maxIterations
    
    populacia = permutacie(numGenes,minValue,maxValue);
    for i = 1:populationSize-1
     populacia = [populacia;permutacie(numGenes,minValue,maxValue)];
    end

    for generation = 1:maxGenerations
            populationFitness = zeros(populationSize, 1);

            for row = 1:populationSize
                    x = [Points(1, 1), Points(1, populacia(row, 1:18)),Points(1, 20)];
                    y = [Points(2, 1), Points(2, populacia(row, 1:18)),Points(2, 20)];
    
                    sum1 = sum(sqrt(diff(x).^2 + diff(y).^2));
    
                    populationFitness(row,:) = sum1;
            end

        graph(iteration,generation) = min(populationFitness);
        najlepsi=selbest(populacia,populationFitness,[1]);
        best = selbest(populacia, populationFitness, [1 1 1 1 1 1 1 1]);
        nahodny = selrand(populacia, populationFitness, 6);
        bestSwap = invord(best,crossoverRate);
        bestSwap = swappart(bestSwap,crossoverRate);
        turnajovy = seltourn(populacia, populationFitness,populationSize-4-4-7-7);
        nahodny = invord(nahodny, crossoverRate);
        nahodny = swapgen(nahodny,crossoverRate);
        turnajovy = invord(turnajovy, crossoverRate);
        turnajovy = swapgen(turnajovy,crossoverRate);
        populacia = [best;bestSwap;nahodny; turnajovy];

    end
    
    graph(iteration,end)
    if maxi > graph(iteration, end)
        maxi = graph(iteration, end);
        najlepsiaCesta = najlepsi;
    end

    figure(1);
    plot(graph(iteration,:));
    hold on;


end

figure(2);
najlepsiaCesta = [1, najlepsiaCesta, numGenes+2];
for z = 1:numGenes+1
    x = Points(1, najlepsiaCesta(z:z+1));
    y = Points(2, najlepsiaCesta(z:z+1));

    plot(x, y, "o-");
    hold on;
end
function odpoved = permutacie(numCols, minValue, maxValue)
    rozsah = minValue:maxValue;
    cisla = datasample(rozsah,numCols, 'Replace', false);
    odpoved = reshape(cisla,1, numCols);
end


