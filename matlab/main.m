movies = parseInfo('train');
coming = parseInfo('predict');
[stat,params,ids,bos,bon,fundamental,stars,starValue] = prepareTrain(movies);
trainInput = [fundamental, starValue]';
[net,tr] = trainModel(trainInput, bon, [18,16]);
[stat2,ids2, fundamental2,stars2,starValue2] = preparePredict(coming,params);
predictInput = [fundamental2, starValue2]';
boxoffice =  predictBoxOffice(predictInput,net);
save('../results/boxoffice.mat');
save('../results/id2.mat');
disp('box office prediction wrote to "results" directory');