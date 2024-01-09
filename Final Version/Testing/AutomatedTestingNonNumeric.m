function [NonNumericErrors]= AutomatedTestingNonNumeric(DataFileName,LogID)
%% Function to examine NetCDF data formats and check for non-numeric values (chars only)

%% Define plain text variable types
DataTypes = {'NC_Byte', 'NC_Char', 'NC_Short', 'NC_Int', 'NC_Float', 'NC_Double'};

NonNumericErrors=0; % flag variable for errors
%% Set file to test
FileName = DataFileName; % define our test file

Contents = ncinfo(FileName); % Store the file content information in a variable.
FileID = netcdf.open(FileName,'NC_NOWRITE'); % open file read only and create handle

VarNames = {Contents.Variables.Name}; %store the Variables Names into VarNames


IncorrectVars = {}; %initialise the IncorrectVars variable 

for idx = 0:size(Contents.Variables,2)-1 % loop through each variable
        % read data type for each variable and store
        [~, datatype(idx+1), ~, ~] = netcdf.inqVar(FileID,idx);
    

    % check if data type is character
    if strcmp(DataTypes(datatype(idx+1)), 'NC_Char')
        % if character, add variable name to IncorrectVars array
        IncorrectVars = [IncorrectVars, VarNames{idx+1}];
    end
end 

%% display data types
DataInFile = DataTypes(datatype)'

%% find character data types
FindText = strcmp('NC_Char', DataInFile);

 fprintf(LogID, 'Non Numeric analysis:\n'); % information to the user is starting the Non Numeric analysis
%% print results to log file
if any(FindText)
    NonNumericErrors=1;
    fprintf(LogID, 'Error, text variables present:\n');
    for i = 1:numel(IncorrectVars) %loop over the Incorrect Vars array to append the name of the variables with errors to the log file 
        fprintf(LogID, '%s\n', IncorrectVars{i});
    end
else
    fprintf(LogID, 'All data is numeric, continue analysis.\n');
end
end 