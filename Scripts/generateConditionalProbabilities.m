%Generate the two belief vectors from the original paper. 
load('pomdpEnvironment.mat', 'MajorKeyProfile', 'MinorKeyProfile');

n = 5000;

MajorWeights = MajorKeyProfile(:, 1);
MinorWeights = MinorKeyProfile(:, 1);

majorKeyCounts = zeros(1, 24);
minorKeyCounts = zeros(1, 24);

for i= 1:n
   
    majorSamples = randsample(12, 16, true, MajorWeights);
    majorNotes = zeros(1, 12);
    for j = 1:16
        majorNotes(majorSamples(j)) = majorNotes(majorSamples(j)) + 1;
    end
    k = detectKeyOriginal(majorNotes);
        
    majorKeyCounts(k) = majorKeyCounts(k) + 1;

    minorSamples = randsample(12, 16, true, MinorWeights);
    minorNotes = zeros(1, 12);
    for j = 1:16
       minorNotes(minorSamples(j)) = minorNotes(minorSamples(j)) + 1;
    end
    k = detectKeyOriginal(minorNotes);
        
    minorKeyCounts(k) = minorKeyCounts(k) + 1;

end

majorKeyCounts = majorKeyCounts ./ n;
minorKeyCounts = minorKeyCounts ./ n;
