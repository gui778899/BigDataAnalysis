function[NaNErrors,NonNumericErrors] =TestSolutionsWithLogFile(DataFileName)
%% Script to examine NetCDF data formats and check for NaN
% Note, you would carry out this test each time you load data.
% You should NOT test the whole file at the start


%% Test File with Errors
NaNErrors = 0;
%% Set file to test


Contents = ncinfo(DataFileName); % Store the file content information in a variable.

%% Create and open log file
LogFileName = 'AnalysisLog.txt';

% Check if log file exists and delete if it does
if exist(LogFileName, 'file') == 2
    delete(LogFileName);
end


% create new log file, 'w' replaces the file if present. To continually
% append, use 'a'
LogID = fopen('AnalysisLog.txt', 'w');
fprintf(LogID, '%s: Starting analysis of %s\n', datestr(now, 0), DataFileName);

StartLat = 1;
StartLon = 1;

fprintf('Testing files: %s\n', DataFileName)
for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(DataFileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]); % 'inf' reads all the data
    end
    
    % check for NaNs
    if any(isnan(Data), 'All')
        NaNErrors = 1;
        %% display warning
        fprintf('NaNs present\n')
        ErrorModel = find(isnan(Data), 1, 'first');
        %% find first error:
        fprintf('Analysis for hour %i is invalid, NaN errors recorded in model %s\n',...
            idxHour, Contents.Variables(ErrorModel).Name)
        
        % Write to log file
        fprintf(LogID, '%s: %s processing data hour %i\n', datestr(now, 0), 'NaN Error', idxHour);
    else
        % write to log file
        fprintf(LogID, '%s: %s processing data hour %i\n', datestr(now, 0), 'Success', idxHour);
    end
    
end

fprintf(LogID, '%s: %s processing data hour %i\n', datestr(now, 0), 'Success', idxHour);

[NonNumericErrors]= AutomatedTestingNonNumeric(DataFileName,LogID); % call Non Numeric function to search for Non Numeric errors
 fclose(LogID); % close log file 

if ~NaNErrors && ~NonNumericErrors % if there are no errors 
    fprintf('No errors!\n')
end