% parameters
Points = [0,0; 77,68; 12,75; 32,17; 51,64; 20,19; 72,87; 80,37; 35,82;
          2,15; 18,90; 33,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60;
          100,100]';

finalFitness = intmax;
numGenes = size(Points, 2) - 2;
finalOrder = zeros(1, numGenes);
populationSize = 30;
maxGenerations = 500;
maxIterations = 5;
crossoverRate = 0.15;
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
        [fitnessHistory(iteration, generation),idx]= min(populationFitness);
        bestIndividual = NewPopulation(idx, :);

        best = selbest(NewPopulation, populationFitness, [2 2]);
        randomSelection = selrand(NewPopulation, populationFitness, 8);
        susSelection = selsus(NewPopulation, populationFitness, 6);
        tournamentSelection = seltourn(NewPopulation, populationFitness, ...
                                        populationSize - size(best, 1) - size(randomSelection, 1) - size(susSelection, 1));

        randomSelection = crosord(randomSelection, 1);
        susSelection = crosord(susSelection, 1);
        tournamentSelection = swappart(tournamentSelection, crossoverRate);
        susSelection = swapgen(susSelection, crossoverRate);
        tournamentSelection = invord(tournamentSelection, crossoverRate);
        NewPopulation = [best; randomSelection; tournamentSelection; susSelection];

    end
    
    figure(1);
    plot(fitnessHistory(iteration, :));
    
    if iteration == 1
        hold on
    end
    
    if finalFitness > fitnessHistory(iteration, end)
        finalFitness = fitnessHistory(iteration, end);
        finalOrder = bestIndividual;
    end

    UpdatedPoints = Points;
    for i = 1:numGenes   
        UpdatedPoints(:, i + 1) = Points(:, finalOrder(i));
    end

end


figure(2)
plot(UpdatedPoints(1,:), UpdatedPoints(2,:), 'x-');

function uniqueRandomMatrix = generateUniqueRandomMatrix()
    % Set the parameters
    numRows = 1;
    numCols = 18;
    minValue = 2;
    maxValue = 19;

    % Generate a pool of unique random numbers
    allNumbers = minValue:maxValue;
    uniqueNumbers = datasample(allNumbers, numRows * numCols, 'Replace', false);

    % Reshape the vector into a matrix
    uniqueRandomMatrix = reshape(uniqueNumbers, numRows, numCols);
end

function distance = calculateDistance(x1, y1, x2, y2)
    % Calculate Euclidean distance
    distance = sqrt((x2 - x1)^2 + (y2 - y1)^2);
end
