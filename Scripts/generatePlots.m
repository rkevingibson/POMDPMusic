%Generate plots for the paper

cmaj = [1 0 0 0 1 0 0 1 0 0 0 0];
cmin = [1 0 0 1 0 0 0 1 0 0 0 0];
emin = circshift(cmin, [0, 4]);
gmaj = circshift(cmaj, [0, 7]);
emaj = circshift(cmaj, [0, 4]);
%Generate 3 plots comparing different methods of getting a belief state.
test = [1 0 0 1 0 1 0 1 1 0 0 0];

figure(1)
bar(computeBeliefOriginal(emin));
ylim([0 0.3]);
xlabel('Key');
ylabel('Belief');
figure(2)
bar(detectKeyCorrelation(emin));
ylim([0 0.3]);
xlabel('Key');
ylabel('Belief');
figure(3)
bar(detectKeyNew(emin));
ylim([0 0.3]);
xlabel('Key');
ylabel('Belief');