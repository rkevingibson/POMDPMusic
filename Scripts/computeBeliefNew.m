function belief = computeBeliefNew(notes)

keyScore = detectKeyNew(notes);

load('pomdpEnvironment.mat', 'TransitionMatrix');

belief = keyScore*TransitionMatrix;
end