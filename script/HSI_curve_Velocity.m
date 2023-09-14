clc
close all

%%%%% Script to create an HSI curve for water velocity %%%%%

% Francesca Paodan 14/09/2023
% Matlab version R2022b
% Script complete

% This script is to create an Habitat Suitablility Index graph for adult 
% brown trout and for the juveniles (here identified with 'spawning' from 
% a table containing values of water velocity that are optimal and 
% suitable for the suvival of brown trout. Data are collected from literature.

% ----- Start with spawning

% Read the modified table for spawning form the folder
tab_spawning = readtable('D:\MATLAB_Phd\HSI\_Water velocity_adult_spawning.xlsx','sheet','Spawning','VariableNamingRule','preserve');

% Create a vector for spawning valuesfrom 0 to 90 (min e max velocity in 
% the spawning table)
vec_spawning = 0:0.1:90;

% Create a vector of zeros of the same lenght of the vector for spawning.
% This will be used to create the curve of HSI. To the value zero will be
% added the weight the habitat values have to count how many times that
% value is mentioned in literature and if it is considered as 'optimal' or
% 'suitable'
vec_length_vec_spawning = zeros(size(vec_spawning));

% Define the weight for 'suitable' and 'optimal' habitat values 
weight_suitable_values = 0.5;
weight_optimal_values = 1;

for i_spawning = 1 : length (vec_spawning)
% Index for reading the values of velocity on the table for every author
    for i_authors = 2 : size (tab_spawning, 1)
% If the value of the vector spawning is less than or equal to the maximum
% value and more than or equal to the minimum value for for water velocity 
% then the habitat is defined 'suitable'.The weight of suitable habitat is
% added to the vector of zeros
        if vec_spawning(i_spawning) <= (tab_spawning{i_authors, 3}) && vec_spawning(i_spawning) >= (tab_spawning{i_authors, 2})
           vec_length_vec_spawning(i_spawning) = vec_length_vec_spawning(i_spawning) + weight_suitable_values;

% Otherwise, if the value of the vector spawning is less than or equal to the maximum
% value and more than or equal to the minimum value for for water velocity 
% then the habitat is defined 'optimal'. The weight of optimal habitat is
% added to the vector of zeros
        elseif vec_spawning(i_spawning) <= (tab_spawning{i_authors, 5}) && vec_spawning(i_spawning) >= (tab_spawning{i_authors, 4})
               vec_length_vec_spawning(i_spawning) = vec_length_vec_spawning(i_spawning) + weight_optimal_values;
        end
    end
end

% Since the HSI is an index from 0 to 1 we need to normalise the values
% that the vector of zeros has now
Normalise_spawning = vec_length_vec_spawning/max(vec_length_vec_spawning);

%plot the spawning graph
hold on

Spawning = plot (vec_spawning,Normalise_spawning, 'Color','r','LineWidth',1.5);
ylim = ([0 1]);

% ----- Do the same for the adult

% Read the modified table for spawning form the folder
tab_adult = readtable('D:\MATLAB_Phd\HSI\_Water velocity_adult_spawning.xlsx','sheet','Adult','VariableNamingRule','preserve');

% Create a vector for spawning valuesfrom 0 to 100 (min e max velocity in 
% the spawning table)
vec_adult = 0:0.1:100;

% Create a vector of zeros of the same lenght of the vector for adults.
vec_length_vec_adult = zeros(size(vec_adult));


for i_adult = 1 : length(vec_adult)
% Index for reading the values of velocity on the table for every author
    for i_authors = 2:size(tab_adult,1)

% If the value of the vector adults is less than or equal to the maximum
% value and more than or equal to the minimum value for for water velocity 
% then the habitat is defined 'suitable'.The weight of suitable habitat is
% added to the vector of zeros
        if vec_adult(i_adult) <= (tab_adult{i_authors, 3}) && vec_adult(i_adult) >= (tab_adult{i_authors, 2})
            vec_length_vec_adult(i_adult) = vec_length_vec_adult(i_adult) + weight_suitable_values;

% Otherwise, if the value of the vector spawning is less than or equal to the maximum
% value and more than or equal to the minimum value for for water velocity 
% then the habitat is defined 'optimal'. The weight of optimal habitat is
% added to the vector of zeros
        elseif vec_adult(i_adult) <= (tab_adult{i_authors, 5}) && vec_adult(i_adult) >= (tab_adult{i_authors, 4})
            vec_length_vec_adult(i_adult) = vec_length_vec_adult(i_adult) + weight_optimal_values;
        end
    end
end

% Since the HSI is an index from 0 to 1 we need to normalise the values
% that the vector of zeros has now
Normalise_adult = vec_length_vec_adult/max(vec_length_vec_adult);

%plot the adult graph
Adult = plot (vec_adult,Normalise_adult, 'Color','k','LineWidth',1.5);
legend([Spawning,Adult],'Juvenile','Adult')
ylim = ([0 1]);
xlabel ('Water velocity [cm/s]','interpreter','latex', 'FontSize', 12)