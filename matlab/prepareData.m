function [ params, ids, bos, matrix ] = prepareData( movies )
    actors2 = [];
    directors2 = [];
    genres = [];
    regions = [];
    ca = [];
    cd = [];
for i = 1:length(movies)
    add = 1;
    for j = 1:length(movies(i).actor)
        for k = 1:length(actors2)
        	if (isequal(movies(i).actor(j), actors2(k)))
                add = 0;
                ca(k) = ca(k) + 1;
                break;
            end
        end
        if (add == 1)
           actors2 = [actors2, movies(i).actor(j)];
           ca = [ca, 0];
        end
    end

    add = 1;
    for j = 1:length(movies(i).director)
        for k = 1:length(directors2)
            if (isequal(movies(i).director(j), directors2(k)))
                add = 0;
                cd(k) = cd(k) + 1;
                break;
            end
        end
        if (add == 1)
           directors2 = [directors2, movies(i).director(j)];
           cd = [cd, 0];
        end
    end

    add = 1;
    for j = 1:length(movies(i).genre)
        for k = 1:length(genres)
            if (isequal(movies(i).genre(j), genres(k)))
                add = 0;
                break;
            end
        end
        if (add == 1)
           genres = [genres, movies(i).genre(j)];
    end

    end
    
    add = 1;
    for j = 1:length(movies(i).region)
        for k = 1:length(regions)
            if (isequal(movies(i).region(j), regions(k)))
                add = 0;
                break;
            end
        end
        if (add == 1)
               regions = [regions, movies(i).region(j)];
        end
    end
end
actors = [];
directors = [];
for i = 1:length(actors2)
    if (ca(i) ~= 0)
        actors = [actors, actors2(i)];
    end
end

for i = 1:length(directors2)
    if (cd(i) ~= 0)
        directors = [directors, directors2(i)];
    end
end

params =[regions, genres, directors, actors];
matrix = [];
v = [];
ids = [];
bos = [];
for i = 1:length(movies)
    i
    if size(movies(i).boxoffice,2) ~= 4 || isequal(movies(i).boxoffice{1},'0')
        continue;
    end
    ids = [ids movies(i).name(1)];
    bos = [bos str2num(movies(i).boxoffice{1})];
    for j = 1:length(regions)
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

    for j = 1:length(genres)
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
    
    for j = 1:length(directors)
        flag = 0;
        for k = 1:length(movies(i).director)
            if (isequal(movies(i).director(k), directors(j)))
                v = [v 1];
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
        end
    end
    
    for j = 1:length(actors)
        flag = 0;
        for k = 1:length(movies(i).actor)
            if (isequal(movies(i).actor(k), actors(j)))
                v = [v 1];
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
        end
    end
    matrix = [matrix; v];
    v=[]; 
end




