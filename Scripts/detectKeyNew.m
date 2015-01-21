function keyScore = detectKeyNew(notes)
%Takes a 12-vector indicating which notes were played,
%Returns a vector indicating the probabilities of it being a certain key.

load('pomdpEnvironment.mat', 'MajorKeyProfile', 'MinorKeyProfile');

mx = mean(notes);
my = mean(MajorKeyProfile, 1);
majorKeyScores = (notes-mx)*(MajorKeyProfile - my(1));

my = mean(MinorKeyProfile, 1);
minorKeyScores = (notes-mx)*(MinorKeyProfile - my(1));

keyScore = [majorKeyScores, minorKeyScores];

keyScore = max(keyScore, zeros(1, 24));

r = range(keyScore);
m = min(keyScore);

shiftedSum = (sum(keyScore) - (24*m)) / r;
keyScore = ((keyScore - m) ./ r) / shiftedSum;

end