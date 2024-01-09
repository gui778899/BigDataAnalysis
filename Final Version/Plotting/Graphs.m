function Graphs(time_dataopt1,time_dataopt2,time_dataopt3,WorkerOptions,DataOptions)
% This function creates three graphs:
%Sequential and Parallel processing speed 
%Sequential vs Parallel on the same plot
%Mean processing time per datum

% Input:
% - time_dataopt1: a list containing the processing time for each worker for the first data size defined by the user.
% - time_dataopt2: a list containing the processing time for each worker for the second data size defined by the user.
% - time_dataopt3: a list containing the processing time for each worker for the third data size defined by the user.
% - WorkerOptions: a list containing the number of workers (processors) to be used for the analysis.
% - DataOptions: a list containing the three data sizes to be analysed.

% Check if sequential processing was done using 1 worker
sequential_processing = ismember(1, WorkerOptions);
%% First figure: Processing time vs number of processors
%% 250 data processed
figure(1)
plot(WorkerOptions, time_dataopt1, '-bd', 'LineWidth', 1.5)
xlabel('Number of Processors')
ylabel('Processing time (s)')
title('Processing time vs number of processors')
hold on

%% 5,000 data processed
plot(WorkerOptions, time_dataopt2, '--rx', 'LineWidth', 1.5)

%% 10,000 data processed
plot(WorkerOptions, time_dataopt3, ':go', 'LineWidth', 1.5)

% Specify x-tick locations and labels as integers
xtickformat('%.0f')
xticks(WorkerOptions)

legend([num2str(DataOptions(1)) ' Data'], [num2str(DataOptions(2)) ' Data'], [num2str(DataOptions(3)) ' Data']);


%% Second figure: Mean processing time
figure(2)
plot(WorkerOptions, time_dataopt1/DataOptions(1), '-bd')
hold on
plot(WorkerOptions, time_dataopt2/DataOptions(2), '-rx')
plot(WorkerOptions, time_dataopt3/DataOptions(3), '-go')
xlabel('Number of Processors')
ylabel('Mean processing time per datum (s)')
title('Mean processing time per datum vs number of processors')

% Specify x-tick locations and labels as integers
xtickformat('%.0f')
xticks(WorkerOptions)

legend([num2str(DataOptions(1)) ' Data'], [num2str(DataOptions(2)) ' Data'], [num2str(DataOptions(3)) ' Data']);

%% Third figure: Sequential vs Parallel processing speeds
if sequential_processing
    figure(3)
    
    sequential_idx = find(WorkerOptions == 1);
    
    % Separate worker options for sequential and parallel processing
    seq_worker = WorkerOptions(sequential_idx);
    par_worker = WorkerOptions(WorkerOptions ~= 1);
    
    % Extract sequential and parallel processing times
    seq_processing = [time_dataopt1(sequential_idx), time_dataopt2(sequential_idx), time_dataopt3(sequential_idx)];
    par_processing = [time_dataopt1(par_worker); time_dataopt2(par_worker); time_dataopt3(par_worker)]';
    
    % Plot the data on two y-axes
    yyaxis left
    plot(seq_worker, seq_processing(1), 'x', 'LineWidth', 1.5, 'Color', 'b')
    hold on
    plot(seq_worker, seq_processing(2), 'o', 'LineWidth', 1.5, 'Color', 'b')
    plot(seq_worker, seq_processing(3), '^', 'LineWidth', 1.5, 'Color', 'b')
    ylabel('Sequential processing time (s)')
    
    yyaxis right
    plot(par_worker, par_processing(:, 1), ':x', 'LineWidth', 1.5, 'Color', 'r')
    plot(par_worker, par_processing(:, 2), ':o', 'LineWidth', 1.5, 'Color', 'r')
    plot(par_worker, par_processing(:, 3), ':^', 'LineWidth', 1.5, 'Color', 'r')
    ylabel('Parallel processing time (s)')
    
    xlabel('Number of Workers')
    title('Sequential vs Parallel processing speeds')
    
    % Specify x-tick locations and labels as integers
    xtickformat('%.0f')
    xticks(WorkerOptions)


    legend([num2str(DataOptions(1)) ' Data (Sequential)'], [num2str(DataOptions(2)) ' Data (Sequential)'], [num2str(DataOptions(3)) ' Data (Sequential)'], [num2str(DataOptions(1)) ' Data (Parallel)'], [num2str(DataOptions(2)) ' Data (Parallel)'], [num2str(DataOptions(3)) ' Data (Parallel)']);
end
end 