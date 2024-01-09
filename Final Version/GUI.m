function [DataOptions, WorkerOptions, DataFileName, NumHours] = GUI
%% Friendly interface where the user will insert the values of data and workers options desired or 
%% will have an option to select the default Data Options, Worker Options and Number of hours to analyse
%% User selects the file from any device in a dialog box (open selection dialog box)

% Set default values for DataOptions, WorkerOptions, and NumHours
defaultDataOptions = [250; 5000;10000];
defaultWorkerOptions = [1; 2; 3; 4; 5; 6];
defaultNumHours = 1;

% Prompt user to select an option
selection = questdlg('Would you like to use default values for DataOptions, WorkerOptions, and NumHours?', ...
                     'Default Options', ...
                     'Yes', 'No', 'Yes');

if strcmp(selection, 'Yes')
    DataOptions = defaultDataOptions;
    WorkerOptions = defaultWorkerOptions;
    NumHours = defaultNumHours;
else
     % Prompt user to input DataOptions values
    while true
        DataOptionsStr = inputdlg('Enter 3 Data Options values separated by semicolons (;)');
        DataOptions = str2num(DataOptionsStr{:});

        % Check if input contains exactly 3 numeric values
        if numel(DataOptions) ~= 3 || ~isnumeric(DataOptions)
            errordlg('Please enter exactly 3 numeric values separated by semicolons (;)', 'Invalid Input');
        else
            break;
        end
    end

    % Prompt user to input WorkerOptions values
    WorkerOptionsStr = inputdlg('Enter Worker Options values separated by semicolons (;)');
    % Check if user input contains semicolons
    while isempty(strfind(WorkerOptionsStr{:}, ';'))
        % Prompt user to input again with a warning message
        WorkerOptionsStr = inputdlg('Please separate workers values with semicolons (;)');
    end

    % Prompt user to input WorkerOptions values
    WorkerOptionsStr = inputdlg('Enter Worker Options values separated by semicolons (;)');
    % Check if user input contains semicolons
    while isempty(strfind(WorkerOptionsStr{:}, ';'))
        % Prompt user to input again with a warning message
        WorkerOptionsStr = inputdlg('Please separate workers values with semicolons (;)');
    end
    WorkerOptions = str2num(WorkerOptionsStr{:});
    
    % Prompt user to input NumHours value
    NumHoursStr = inputdlg('Enter the value for NumHours (default is 1)');
    if isempty(NumHoursStr{:})
        NumHours = defaultNumHours;
    else
        NumHours = str2num(NumHoursStr{:});
    end
end

% Prompt user to click "OK" to select the data file
msgbox('Please click "OK" to select the data file to be analyzed.', 'Select Data File', 'modal');

% Allow user to select the data file
[filename, path] = uigetfile('*.*', 'Select data file to be analyzed');
if isequal(filename, 0)
    % User cancelled the file selection dialog
    error('User cancelled file selection.');
end

% Construct full file path
DataFileName = fullfile(path, filename);

% After user input the DataOptions and WorkerOptions call the Testing
% function to check for possible NonNumericErrors or NanErrors
MainAutomatedTesting(DataOptions, WorkerOptions, DataFileName, NumHours);

end


