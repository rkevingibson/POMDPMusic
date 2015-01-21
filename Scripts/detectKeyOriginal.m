function key = detectKeyOriginal(notes)
%Takes a 12-vector indicating which notes were played.

load('pomdpEnvironment.mat', 'MajorKeyProfile', 'MinorKeyProfile');

mx = mean(notes);
my = mean(MajorKeyProfile, 1);

majorKeyScores = (notes-mx)*(MajorKeyProfile - my(1));

[majorScore, majorKey] = max(majorKeyScores);

my = mean(MinorKeyProfile, 1);
minorKeyScores = (notes-mx)*(MinorKeyProfile - my(1));

[minorScore, minorKey] = max(minorKeyScores);

if minorScore > majorScore
   key = minorKey + 12;
else
    key = majorKey;
end
end