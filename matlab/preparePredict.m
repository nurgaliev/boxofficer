function [ stats, ids, fundamental, stars, starValue  ] = preparePredict( movies, params )
    stats = [];
    actors = params{4};
    directors = params{3};
    genres = params{2};
    regions = params{1};
    ca = [];
    cd = [];
    cg = [];
    cr = [];
    boa = [];
    bod = [];
    bog = [];
    bor = [];
    bos = [];

for i = 1:length(movies)
    v = [movies(i).name];
    for j = 1:length(movies(i).region)
        v = [v, movies(i).region{j}];
    end
    
    for j = length(movies(i).region):10
        v = [v,' '];
    end
    for j = 1:length(movies(i).genre)
        v = [v, movies(i).genre{j}];
    end
    
    for j = length(movies(i).genre):10
        v = [v,' '];
    end
    
    for j = 1:length(movies(i).director)
        v = [v, movies(i).director{j}];
    end
    
    for j = length(movies(i).director):10
        v = [v,' '];
    end
    
    for j = 1:length(movies(i).actor)
        v = [v, movies(i).actor{j}];
    end
    
    for j = length(movies(i).actor):30
        v = [v,' '];
    end
    stats = [stats; v];
end

fundamental = [];
starValue = [];
stars = [];
v = [];
ids = [];
for i = 1:length(movies)
    ids = [ids movies(i).name(1)];
    for j = 1:length(regions(:,1))
        flag = 0;
        for k = 1:length(movies(i).region)
            if isequal(movies(i).region(k), regions(j))
                v = [v 1];
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
        end
    end

    for j = 1:length(genres(:,1))
        flag = 0;
        for k = 1:length(movies(i).genre)
            if (isequal(movies(i).genre(k), genres(j)))
                v = [v 1];
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
        end
    end
    fundamental = [fundamental; v];
    v = [];
    starNum = 0;
    starBO = 0;
    for j = 1:length(directors(:,1))
        flag = 0;
        for k = 1:length(movies(i).director)
            if (isequal(movies(i).director(k), directors(j,1)))
                v = [v 1];
                starNum = starNum + directors{j,2};
                starBO = starBO + directors{j,3};
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
        end
    end
    
    for j = 1:length(actors(:,1))
        flag = 0;
        for k = 1:length(movies(i).actor)
            if (isequal(movies(i).actor(k), actors(j,1)))
                v = [v 1];
                starNum = starNum + actors{j,2};
                starBO = starBO + actors{j,3};
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
        end
    end
    stars = [stars; v];
    starValue = [starValue; starBO];
    v=[]; 
end

%norm starValue
range = max(starValue) - min(starValue);
starValue = (starValue - min(starValue))/range*20;
starValue = uint8(starValue);
sv = starValue;
starValue = [];
for i = 1:length(sv)
    v = [];
    for j = 1:20
        if sv(i) == j-1
            v = [v, 1];
        else
            v = [v, 0];
        end
    end
    starValue = [starValue; v];
end

end

