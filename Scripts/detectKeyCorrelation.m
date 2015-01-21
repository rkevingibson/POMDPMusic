function keyScore = detectKeyCorrelation(notes)
%Takes a 12-vector indicating which notes were played,
%Returns a vector indicating the probabilities of it being a certain key.

load('pomdpEnvironment.mat', 'MajorKeyProfile', 'MinorKeyProfile');

majorKeyScores = notes*MajorKeyProfile;
minorKeyScores = notes*MinorKeyProfile;

keyScore = [majorKeyScores, minorKeyScores];

r = range(keyScore);
m = min(keyScore);

shiftedSum = (sum(keyScore) - (24*m)) / r;
keyScore = ((keyScore - m) ./ r) / shiftedSum;

end