function rewards = rewardFunction(belief)

load('pomdpEnvironment.mat', 'RewardMatrix');

rewards = belief*RewardMatrix;

%Here, we can add heuristics to get better note picking.
%Discourage repetetiveness, try to find patterns, etc.


end