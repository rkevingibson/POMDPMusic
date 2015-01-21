function output = pomdpMusic(filename)



%get note information
midi = readmidi(filename);
notes = midiInfo(midi);

note_in_bar = zeros(1, 12); %Which notes were played in the current bar

quarter_notes_per_bar = 4; %Assume 4/4 time for now.
bar_length = 50000 * 4 * quarter_notes_per_bar / 1000000; %seconds per bar, based on default midi length.
next_bar_start = bar_length;

belief_state = zeros(1, 24);

output_index = 1;
for i = 1:length(notes) %for each input note

    %Get time of the note start
    note_start = notes(i, 5);
    note_end = notes(i, 6);
    note_num = notes(i, 3);
    
    if note_start > next_bar_start
       %Finished a bar, update belief state
       belief_state = detectKeyNew(note_in_bar);
       note_in_bar = zeros(1, 12);
       next_bar_start = next_bar_start + bar_length;
    end
    
    %add this note to the notes played this bar
    %Want 57 -> 1
    % 84 -> 4
    note_index = mod(note_num + 3, 12) + 1;
    note_in_bar(note_index) = 1;
    
    %If the note is above a certain value, I want to output another note
    %with it.
    %Calculate reward for each note
    
    if note_num > 60 && sum(belief_state) ~= 0
    
        rewards = rewardFunction(belief_state);

        %Find maximum reward, play that note.
        [r, idx] = max(rewards);

        % we want to play in a certain octave above middle C, so we want midi
        % notes 60-72
        midi_note = idx + 32;
        output_notes(output_index, :) = [notes(i, 1:2), midi_note, notes(i, 4:6)];
        output_index = output_index +1;
        %Add input note and generated note to output matrix
        
        output_notes(output_index, :) = notes(i, 1:6);
        output_index = output_index +1;
    end
    
    %Test our note conversion:
    octave = floor(note_num / 12) - 1;
    
    %output_notes(output_index, :) = [notes(i, 1:2), (note_index - 1) + (12*octave) + 9, notes(i, 4:6)];
    %output_index = output_index +1;
    
    
    
    
end

output = matrix2midi(output_notes, midi.ticks_per_quarter_note);

end