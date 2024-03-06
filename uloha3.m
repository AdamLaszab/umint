Points = [0,0; 77,68; 12,75; 32,17; 51,64; 20,19; 72,87; 80,37; 35,82;
          2,15; 18,90; 33,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60;
          100,100]';

maxi = 10000;
numGenes = 18;
najlepsiaCesta = zeros(1, numGenes);
populationSize = 30;
maxGenerations = 1000;
maxIterations = 5;
crossoverRate = 0.3;
populationFitness = zeros(1, populationSize);
minValue = 2;
maxValue = numGenes+1;
for iteration = 1:maxIterations
    
    NewPopulation = permutacie(numGenes,minValue,maxValue);
    for i = 1:populationSize-1
     NewPopulation = [NewPopulation;permutacie(numGenes,minValue,maxValue)];
    end

    for generation = 1:maxGenerations
            populationSize = size(NewPopulation, 1);
            matrix = zeros(populationSize, 1);

            for row = 1:populationSize
                    x = [Points(1, 1), Points(1, NewPopulation(row, 1:18)),Points(1, 20)];
                    y = [Points(2, 1), Points(2, NewPopulation(row, 1:18)),Points(2, 20)];
    
                    sum1 = sum(sqrt(diff(x).^2 + diff(y).^2));
    
                    matrix(row,:) = sum1;
            end
        populationFitness(:) = matrix;
        graph(iteration,generation) = min(populationFitness);
        najlepsi=selbest(NewPopulation,populationFitness,[1]);
        
        best = selbest(NewPopulation, populationFitness, [1 1 1 1]);
        randomSelection = selrand(NewPopulation, populationFitness, 7);
        susSelection = selsus(NewPopulation, populationFitness, 7);
        bestSwap = invord(best,crossoverRate);
        tournamentSelection = seltourn(NewPopulation, populationFitness,populationSize-22);
        randomSelection = swappart(randomSelection, crossoverRate);
        susSelection = swappart(susSelection, crossoverRate);
        tournamentSelection = swappart(tournamentSelection, crossoverRate);
        tournamentSelection = swapgen(tournamentSelection, crossoverRate);
        NewPopulation = [best;bestSwap;randomSelection; tournamentSelection; susSelection];

    end
    
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
function uniqueRandomMatrix = permutacie(numCols, minValue, maxValue)
    allNumbers = minValue:maxValue;
    uniqueNumbers = datasample(allNumbers,numCols, 'Replace', false);
    uniqueRandomMatrix = reshape(uniqueNumbers,1, numCols);
end


