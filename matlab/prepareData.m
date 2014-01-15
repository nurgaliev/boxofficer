function [ stats, params, ids, bos, matrix, matrix2 ] = prepareData( movies )
    stats = [];
    actors2 = [];
    directors2 = [];
    genres2 = [];
    regions2 = [];
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
    if size(movies(i).boxoffice,2) ~= 4 || isequal(movies(i).boxoffice{1},'0')
        continue;
    end
    bo = 0;
    for j = 1:4
        bo = bo + str2num(movies(i).boxoffice{j});
    end
    
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
    v = [v bo];
    bos = [bos bo];
    stats = [stats; v];
end

count = 0;
for i = 1:length(movies)
    if size(movies(i).boxoffice,2) ~= 4 || isequal(movies(i).boxoffice{1},'0')
        continue;
    end
    add = 1;
    count = count + 1;
    for j = 1:length(movies(i).actor)
        for k = 1:length(actors2)
        	if (isequal(movies(i).actor(j), actors2(k)))
               % if (isequal(movies(i).actor{j},'ÎâÃÏ´ï'))
                %    disp(bos(count));
               % end
                add = 0;
                ca(k) = ca(k) + 1;
                boa(k) = boa(k) + bos(count);
                break;
            end
        end
        if (add == 1)
           actors2 = [actors2, movies(i).actor(j)];
           ca = [ca, 1];
           boa = [boa, bos(count)];
        end
    end

    add = 1;
    for j = 1:length(movies(i).director)
        for k = 1:length(directors2)
            if (isequal(movies(i).director(j), directors2(k)))
                add = 0;
                cd(k) = cd(k) + 1;
                bod(k) = bod(k) + bos(count);
                break;
            end
        end
        if (add == 1)
           directors2 = [directors2, movies(i).director(j)];
           cd = [cd, 1];
           bod = [bod, bos(count)];
        end
    end

    add = 1;
    for j = 1:length(movies(i).genre)
        for k = 1:length(genres2)
            if (isequal(movies(i).genre(j), genres2(k)))
                add = 0;
                cg(k) = cg(k) + 1;
                bog(k) = bog(k) + bos(count);
                break;
            end
        end
        if (add == 1)
           genres2 = [genres2, movies(i).genre(j)];
           cg = [cg, 1];
           bog = [bog, bos(count)];
        end
    end
    
    add = 1;
    for j = 1:length(movies(i).region)
        for k = 1:length(regions2)
            if (isequal(movies(i).region(j), regions2(k)))
                add = 0;
                cr(k) = cr(k) + 1;
                bor(k) = bor(k) + bos(count);
                break;
            end
        end
        if (add == 1)
               regions2 = [regions2, movies(i).region(j)];
               cr = [cr, 1];
               bor = [bor, bos(count)];
        end
    end
end
actors = [];
directors = [];
genres = [];
regions = [];
for i = 1:length(actors2)
    if (ca(i) > 1)
        actors = [actors; actors2(i), ca(i),boa(i)/ca(i)];
    end
end

for i = 1:length(directors2)
    if (cd(i) > 1)
        directors = [directors; directors2(i), cd(i),bod(i)/cd(i)];
    end
end

for i = 1:length(genres2)
    if (cg(i) > 1)
        genres = [genres; genres2(i), cg(i),bog(i)/cg(i)];
    end
end

for i = 1:length(regions2)
    if (cr(i) > 1)
        regions = [regions; regions2(i), cr(i),bor(i)/cr(i)];
    end
end

params =[regions; genres; directors; actors];
matrix = [];
matrix2 = [];
v = [];
v2 = [];
ids = [];
for i = 1:length(movies)
    if size(movies(i).boxoffice,2) ~= 4 || isequal(movies(i).boxoffice{1},'0')
        continue;
    end
    
    ids = [ids movies(i).name(1)];
    for j = 1:length(regions(:,1))
        flag = 0;
        for k = 1:length(movies(i).region)
            if isequal(movies(i).region(k), regions(j))
                v = [v 1];
                v2 = [v2 1];
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
            v2 = [v2 0];
        end
    end

    for j = 1:length(genres(:,1))
        flag = 0;
        for k = 1:length(movies(i).genre)
            if (isequal(movies(i).genre(k), genres(j)))
                v = [v 1];
                v2 = [v2 1];
                flag = 1;
                break;
            end
        end
        if (flag == 0)
            v = [v 0];
            v2 = [v2 0];
        end
    end
    
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
    v2 = [v2 starBO];
    matrix = [matrix; v];
    matrix2 = [matrix2; v2];
    v=[]; 
    v2=[];
end




