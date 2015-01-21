function belief = computeBeliefState(notes)


%initialize relevant variables.
load('pomdpEnvironment');

%First, use the key-finding algorithm to generate an initial belief.
majorKeyScores = notes*MajorKeyProfile;
minorKeyScores = notes*MinorKeyProfile;

keyScore = [majorKeyScores, minorKeyScores];

%Convert to a probability distribution by scaling.
r = range(keyScore);
m = min(keyScore);

shiftedSum = (sum(keyScore) - (24* m)) / r;

keyScore = ((keyScore - m) ./ r) / shiftedSum;

belief = keyScore * TransitionMatrix;
end