function [DataParameter,WorkerParameter] = MainProcessing(DataOptions, WorkerOptions,DataFileName,NumHours)
%% Function is called after the data has passed every test in the automated test function 
%% Loops over the different Data Options and Size Options the user decided to input and call the ParallelProcessing function to do the actual processing of the data 
%% Calls other two functions after processing the data to organise and output the results

% Define log file name
logFileName = 'Results.txt';

% Check if log file exists and delete it if it does
if exist(logFileName, 'file')
    delete(logFileName);
end

Results = []; % empty matrix to store the Processing Results
for idx1 = 1:size(DataOptions,1) % loop through the DataOptions user defined 
    DataParameter = DataOptions(idx1); % assign the value of Data to the DataParameter
    for idx2 = 1: size(WorkerOptions, 1) % loop through the WorkerOption user defined
        WorkerParameter = WorkerOptions(idx2);% assign the worker value to the WorkerParmeter
        [TimetoProcess]=Processing(DataParameter,WorkerParameter,DataFileName,NumHours); % call the ParallelProcessing function to process the data
        Results = [Results; WorkerParameter, DataParameter, TimetoProcess]; % append a row (WorkerParameter,DataParameter,TimetoProcess) to the matrix Results

        % Append results to log file
        fileid = fopen(logFileName, 'a');
        fprintf(fileid, 'Worker Parameter: %d, Data Parameter: %d, Time to Process: %f\n', WorkerParameter, DataParameter, TimetoProcess);
        fclose(fileid);
    end

end
[newList1,newList2,newList3] = ResultstoGraphs(Results,DataOptions); % call the function ResultstoGraphs to separate the Results into separate lists according to the Data size
Graphs(newList1,newList2,newList3,WorkerOptions,DataOptions); % call the Graphs function to plot automatically the graphs with the results to the user
end
