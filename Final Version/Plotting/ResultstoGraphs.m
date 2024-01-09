function [time_dataopt1,time_dataopt2,time_dataopt3] = ResultstoGraphs(Results,DataOptions)
%% Function creates new lists based on the data options user chose to analyse 

% The function takes a set of data 'Results' and a set of data options 'DataOptions' and 
% creates three new lists, based on the values of DataOptions. 
% The first list 'time_dataopt1' contains the values of the third column of 'Results' where the value in the second column matches the first value in 'DataOptions'. 
% The second list 'time_dataopt2' contains the values of the third column of 'Results' where the value in the second column matches the second value in 'DataOptions'. 
% The third list 'time_dataopt3' contains the values of the third column of 'Results' where the value in the second column matches the third value in 'DataOptions'.

% Initialize the new lists
time_dataopt1 = [];
time_dataopt2 = [];
time_dataopt3 = [];

% Loop through the rows of Results
for idx4 = 1:size(Results, 1)
    % Check if the DataParameter value matches the first desired value
    if Results(idx4, 2) == DataOptions(1) 
        % If it does, append the row to the first new list
        time_dataopt1 = [time_dataopt1; Results(idx4, 3)];
    % Check if the DataParameter value matches the second desired value
    elseif Results(idx4, 2) == DataOptions(2)
        % If it does, append the row to the second new list
        time_dataopt2 = [time_dataopt2; Results(idx4, 3)];
    % Check if the DataParameter value matches the third desired value
    elseif Results(idx4, 2) == DataOptions(3)
        % If it does, append the row to the third new list
        time_dataopt3 = [time_dataopt3; Results(idx4, 3)];
    end
end

end