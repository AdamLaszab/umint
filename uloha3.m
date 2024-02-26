% parameters
Points = [0,0; 77,68; 12,75; 32,17; 51,64; 20,19; 72,87; 80,37; 35,82;
          2,15; 18,90; 33,50; 85,52; 97,27; 37,67; 20,82; 49,0; 62,14; 7,60;
          100,100]';

finalFitness = intmax;
numGenes = size(Points, 2) - 2;
finalOrder = zeros(1, numGenes);
populationSize = 50;
maxGenerations = 1000;
maxIterations = 10;
crossoverRate = 0.15;
populationFitness = zeros(1, populationSize);

for iteration = 1:maxIterations

    NewPopulation = generatePopulation(numGenes, populationSize);

    for generation = 1:maxGenerations
    
        % evaluation
        populationFitness(:) = calculateFitness(Points, NewPopulation);
        [fitnessHistory(iteration, generation), idx] = min(populationFitness);
        bestIndividual = NewPopulation(idx, :);

        % selection
        best = selbest(NewPopulation, populationFitness, [2 2]);
        randomSelection = selrand(NewPopulation, populationFitness, 8);
        susSelection = selsus(NewPopulation, populationFitness, 6);
        tournamentSelection = seltourn(NewPopulation, populationFitness, ...
                                        populationSize - size(best, 1) - size(randomSelection, 1) - size(susSelection, 1));

        % crossover
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

function population = generatePopulation(numGenes, populationSize)
    population = zeros(populationSize, numGenes);
    
    [~, population(:)] = sort(rand(populationSize, numGenes), 2);
    
    population(:) = population + 1;
end

function distances = calculateFitness(points, population)
    indices = [ones(size(population, 1), 1), population, (size(population, 2) + 2) * ones(size(population, 1), 1)];
    tempX = reshape(points(1, indices), size(indices, 1), size(indices, 2));
    tempY = reshape(points(2, indices), size(indices, 1), size(indices, 2));
    
    distances = sum(((tempX(:,2:end) - tempX(:,1:end-1)).^2 + (tempY(:,2:end) - tempY(:,1:end-1)).^2).^0.5, 2);  
end
