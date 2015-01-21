%Create all the variables and save them to a file

MKP = [5.0; 2.0; 3.5; 2.0; 4.5; 4.0; 2.0; 4.5; 2.0; 3.5; 1.5; 4.0]; %Major Key Profile
mkp = [5.0; 2.0; 3.5; 4.5; 2.0; 4.0; 2.0; 4.5; 3.5; 2.0; 1.5; 4.0]; %minor key profile
MajorKeyProfile = [MKP, circshift(MKP, 1), circshift(MKP, 2), circshift(MKP, 3),...
        circshift(MKP, 4), circshift(MKP, 5), circshift(MKP, 6),...
        circshift(MKP, 7), circshift(MKP, 8), circshift(MKP, 9),...
        circshift(MKP, 10), circshift(MKP, 11)];

MinorKeyProfile = [mkp, circshift(mkp, 1), circshift(mkp, 2), circshift(mkp, 3),...
        circshift(mkp, 4), circshift(mkp, 5), circshift(mkp, 6),...
        circshift(mkp, 7), circshift(mkp, 8), circshift(mkp, 9),...
        circshift(mkp, 10), circshift(mkp, 11)];
    
RewardMatrix = [MKP, circshift(MKP, 1), circshift(MKP, 2), circshift(MKP, 3),...
        circshift(MKP, 4), circshift(MKP, 5), circshift(MKP, 6),...
        circshift(MKP, 7), circshift(MKP, 8), circshift(MKP, 9),...
        circshift(MKP, 10), circshift(MKP, 11),...
        mkp, circshift( mkp, 1), circshift( mkp, 2), circshift( mkp, 3),...
        circshift( mkp, 4), circshift( mkp, 5), circshift( mkp, 16),...
        circshift( mkp, 7), circshift( mkp, 8), circshift( mkp, 9),...
        circshift( mkp, 10), circshift( mkp, 11)]';
    
t = [0.40; 0.01; 0.02; 0.00; 0.01; 0.14; 0.00; 0.15; 0.00; 0.01; 0.00; 0.01; 0.01; 0.01; 0.03; 0.00; 0.05; 0.01; 0.00; 0.01; 0.00; 0.12; 0.00; 0.01];
TransitionMatrix = [t, circshift(t, 1), circshift(t, 2), circshift(t, 3),...
    circshift(t, 4), circshift(t, 5), circshift(t, 6), circshift(t, 7),...
    circshift(t, 8), circshift(t, 9), circshift(t, 10), circshift(t, 11),...
    circshift(t, 12), circshift(t, 13), circshift(t, 14), circshift(t, 15),...
    circshift(t, 16), circshift(t, 17), circshift(t, 18), circshift(t, 19),...
    circshift(t, 20), circshift(t, 21), circshift(t, 22), circshift(t, 23)]';

save('pomdpEnvironment', 'MajorKeyProfile', 'MinorKeyProfile', 'TransitionMatrix', 'RewardMatrix');