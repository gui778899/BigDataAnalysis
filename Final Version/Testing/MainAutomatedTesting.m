function MainAutomatedTesting(DataOptions, WorkerOptions, DataFileName,NumHours)
%% Main function of the Automated Testing section, calls Test Solution with Log file 
%% to check if the data given as some time of Non Numeric value or NaN values


[NaNErrors,NonNumericErrors] =TestSolutionsWithLogFile(DataFileName);

% Check the results of the automated testing
if NonNumericErrors == 1 && NaNErrors == 0
    % If there are non-numeric errors only, print the message below
    fprintf('Data contains Text Variables. Please check AnalysisLog.txt file for more details.\n');
elseif NonNumericErrors == 0 && NaNErrors == 1
    % If there are NaN errors only, print the message below
    fprintf('Data contains NaN errors. Please check AnalysisLog.txt file for more details.\n');
elseif NonNumericErrors == 1 && NaNErrors == 1
    % If there are both non-numeric and NaN errors, print the message below
    fprintf('Data contains NaN errors and Text Variables. Please check AnalysisLog.txt for more details.\n');
else
    % If there are no errors, continue with the automated script
    [DataParameter,WorkerParameter] = MainProcessing(DataOptions, WorkerOptions,DataFileName,NumHours); % call the AutomatedScript function (processing and plots), if there's no errors, to continue the processing of the data
end

end