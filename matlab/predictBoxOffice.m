function boxoffice = predictBoxOffice( input, net )
    category = net(input);
    category = uint8(category);
    boxoffice = [];
    for i = 1:length(category)
        bo = 0;
        switch category(i)
            case 0
                bo = 100000*rand;
            case 1
                bo = (500000 - 100000)*rand + 100000;
            case 2
                bo = (1000000 - 500000)*rand + 500000;
            case 3
                bo = (2000000 - 1000000)*rand + 1000000;
            case 4
                bo = (5000000 - 2000000)*rand + 2000000;
            case 5
                 bo = (10000000 - 5000000)*rand + 5000000;
            case 6
                 bo = (20000000 - 10000000)*rand + 10000000;
            case 7
                 bo = (30000000 - 20000000)*rand + 20000000;
            case 8
                 bo = (50000000 - 30000000)*rand + 30000000;
            case 9
                 bo = (100000000 - 50000000)*rand + 50000000;
            case 10
                 bo = 112345678;
            otherwise
                bo = -1;
        end
        boxoffice = [boxoffice, bo];
    end
end

