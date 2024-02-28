Points = [0,0; 77,68; 12,75; 32,17; 51,64; 20,19; 72,87; 80,37; 35,82;
          2,15; 18,90; 33,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60;
          100,100]';

maxi = 10000;
numGenes = size(Points, 2) - 2;
najlepsiaCesta = zeros(1, numGenes);
populationSize = 30;
maxGenerations = 750;
maxIterations = 5;
crossoverRate = 0.12;
populationFitness = zeros(1, populationSize);

for iteration = 1:maxIterations
    
    NewPopulation = generateUniqueRandomMatrix();
    for i = 1:populationSize-1
     NewPopulation = [NewPopulation;generateUniqueRandomMatrix()];
    end

    for generation = 1:maxGenerations
            populationSize = size(NewPopulation, 1);
            matrix = zeros(populationSize, 1);

            for row = 1:populationSize
                    x = [Points(1, 1), Points(1, NewPopulation(row, 1:17)), Points(1, NewPopulation(row, 18)), Points(1, 20)];
                    y = [Points(2, 1), Points(2, NewPopulation(row, 1:17)), Points(2, NewPopulation(row, 18)), Points(2, 20)];
    
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
        randomSelection = invord(randomSelection, crossoverRate);
        susSelection = invord(susSelection, crossoverRate);
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


figure(2)
konecneZnacenie = Points;
for i = 1:numGenes   
    konecneZnacenie(:, i + 1) = Points(:, najlepsiaCesta(i));
end

plot(konecneZnacenie(1,:), konecneZnacenie(2,:), 'O-');

function uniqueRandomMatrix = generateUniqueRandomMatrix()
    numRows = 1;
    numCols = 18;
    minValue = 2;
    maxValue = 19;

    allNumbers = minValue:maxValue;
    uniqueNumbers = datasample(allNumbers, numRows * numCols, 'Replace', false);
    uniqueRandomMatrix = reshape(uniqueNumbers, numRows, numCols);
end

function distance = calculateDistance(x1, y1, x2, y2)
    distance = sqrt((x2 - x1)^2 + (y2 - y1)^2);
end
