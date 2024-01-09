function [LoopParameter] = MainSequentialProcessing()
% This function performs sequential processing on a set of options, stores the
% results in a matrix and a text file, and displays the results in the command
% window.
%
% Inputs:
%   - tSeq: a scalar representing the processing time
%
% Outputs:
%   - LoopParameter: a scalar representing the loop parameter

    % Define the set of options to be processed
    Options = [250; 5000];
    
    % Create an empty matrix to store the processing results
    Results = [];

    % Check if the Results.txt file exists and delete it if it does
    if exist('Results.txt', 'file')
        delete('Results.txt');
    end

    % Iterate over the options and perform sequential processing on each option
    for idx = 1:size(Options, 1)
        LoopParameter = Options(idx);
        
        % Call the SequentialProcessing function to perform processing and get the processing time
        [tSeq] = SequentialProcessing(LoopParameter);

        % Store the processing results in the Results matrix
        Results(idx,:) = [Options(idx), tSeq];

        % Write the results to the Results.txt file
        fid = fopen('Results.txt', 'a');
        fprintf(fid, 'Data Size: %d, Time: %f\n', LoopParameter, tSeq);
        fclose(fid);
    end

    % Display the processing results in the command window
    disp(Results)
end