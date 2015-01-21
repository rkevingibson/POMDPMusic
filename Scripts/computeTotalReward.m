function [ourScore, oldScore] = computeTotalReward(file)

%Open midi file
midi = readmidi(file);
notes = midiInfo(midi);

notes_in_bar  = zeros(1, 12); %The notes that were played in the previous bar

quarter_notes_per_bar = 4;
bar_length = 50000 * 4* quarter_notes_per_bar / 1000000; %Seconds per bar
next_bar_start = bar_length;
ourBelief = zeros(1, 24);
oldBelief = zeros(1,24);

ourNote = 0;
oldNote = 0;

ourScore = 0;
oldScore = 0;

load('pomdpEnvironment.mat', 'MajorKeyProfile', 'MinorKeyProfile');

for i = 1:length(notes) %For each note in the file...
    
    %...get the time the note starts
    note_start  = notes(i, 5);
    note_num    = notes(i, 3);
    
    if note_start > next_bar_start 
        %We're done a bar, so look how well we performed and recompute the belief state
        if ourNote ~= 0 %We chose a note last bar, so see how we did.
            key = detectKeyOriginal(notes_in_bar);
            
            %Compute scores based on the note we chose compared to the key.
            %if key is minor, use the minor key profile and shift it by
            %key-1 units, then access the [note] element to get the score.
            if key > 12 %Minor key
                rewards = circshift(MinorKeyProfile(:,1), key-13) - mean(MinorKeyProfile(:,1));
            else
                rewards = circshift(MajorKeyProfile(:,1), key-1) - mean(MinorKeyProfile(:,1));
            end
            
            ourScore = ourScore + rewards(ourNote);
            oldScore = oldScore + rewards(oldNote);
        end
        
        ourBelief = detectKeyNew(notes_in_bar); %Need to multiply by transition matrix
        oldBelief = computeBeliefOriginal(notes_in_bar);
        
        %Determine what note we would play this bar.
        if sum(notes_in_bar) ~= 0
            [~, ourNote] = max(rewardFunction(ourBelief));
            [~, oldNote] = max(oldRewardFunction(oldBelief));
        else
           ourNote = 0;
           oldNote = 0;
        end
        notes_in_bar = zeros(1, 12);
        next_bar_start = next_bar_start + bar_length;
    end
    
    %Add the note to the list of notes played this bar:
    note_index = mod(note_num + 3, 12) + 1;
    notes_in_bar(note_index) = 1;
end

end