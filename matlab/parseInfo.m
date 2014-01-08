fileInfo = fopen('../data/movie_info.txt', 'r', 'n', 'UTF-8');
tline = fgetl(fileInfo);
splits = strread(tline, '%s', 'delimiter', '\t');
movie.id = splits(1,1);
movie.id = {'479'};
movie.name = splits(2,1);
tline = fgetl(fileInfo);
splits = strread(tline, '%s', 'delimiter', '\t');
movie.director = splits;
tline = fgetl(fileInfo);
splits = strread(tline, '%s', 'delimiter', '\t');
movie.actor = splits;
tline = fgetl(fileInfo);
splits = strread(tline, '%s', 'delimiter', '\t');
movie.region = splits;
tline = fgetl(fileInfo);
splits = strread(tline, '%s', 'delimiter', '\t');
movie.genre = splits;

movies = movie;
tline = fgetl(fileInfo);
while ischar(tline)
    splits = strread(tline, '%s', 'delimiter', '\t');
    movie.id = splits(1);
    movie.name = splits(2);

    tline = fgetl(fileInfo);
    splits = strread(tline, '%s', 'delimiter', '\t');
    movie.director = splits;
    tline = fgetl(fileInfo);
    splits = strread(tline, '%s', 'delimiter', '\t');
    movie.actor = splits;
    tline = fgetl(fileInfo);
    splits = strread(tline, '%s', 'delimiter', '\t');
    movie.region = splits;
    tline = fgetl(fileInfo);
    splits = strread(tline, '%s', 'delimiter', '\t');
    movie.genre = splits;
    movies = [movies, movie];
    tline = fgetl(fileInfo);
end
fileBox = fopen('../data/boxoffice.txt', 'r', 'n', 'UTF-8');
tline = fgetl(fileBox);

while ischar(tline)
    splits = strread(tline, '%s', 'delimiter', '\t');
    for i = 1:length(movies)
        if isequal(movies(i).id(1,1), splits(1,1))
            movies(i).boxoffice = splits(2);
            movies(i).boxoffice = [movies(i).boxoffice, splits(3)];
            movies(i).boxoffice = [movies(i).boxoffice, splits(4)];
            movies(i).boxoffice = [movies(i).boxoffice, splits(5)];
        end
    end
    tline = fgetl(fileBox);
end

