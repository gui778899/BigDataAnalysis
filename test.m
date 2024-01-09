% This function creates two graphs showing the processing time vs the number of processors for three different data sizes defined by the user.
% It also shows the mean processing time vs the number of processors for the three data sizes. If sequential processing (1 worker) is present,
% it will create an additional graph comparing sequential and parallel processing times.

% Input:
% - newList1: a list containing the processing time for each worker for the first data size defined by the user.
% - newList2: a list containing the processing time for each worker for the second data size defined by the user.
% - newList3: a list containing the processing time for each worker for the third data size defined by the user.
% - WorkerOptions: a list containing the number of workers (processors) to be used for the analysis.
% - DataOptions: a list containing the three data sizes to be analysed.
newList1=[3.4, 1.81, 1.7, 1.5, 1.47, 1.45];
newList2=[40.2, 23.2, 21.7,20.37, 20.03, 19.84];
newList3=[81.3,51.3,44.55,38.03,32.4,27.8];
WorkerOptions=[1,2, 3, 4, 5, 6];
DataOptions=[250;5000;10000];
% Check if sequential processing was done using 1 worker
sequential_processing = ismember(1, WorkerOptions);
%% First figure: Processing time vs number of processors
%% 250 data processed
figure(1)
plot(WorkerOptions, newList1, '-bd', 'LineWidth', 1.5)
xlabel('Number of Processors')
ylabel('Processing time (s)')
title('Processing time vs number of processors')
hold on

%% 5,000 data processed
plot(WorkerOptions, newList2, '--rx', 'LineWidth', 1.5)

%% 10,000 data processed
plot(WorkerOptions, newList3, ':go', 'LineWidth', 1.5)

% Specify x-tick locations and labels as integers
xtickformat('%.0f')
xticks(WorkerOptions)

legend([num2str(DataOptions(1)) ' Data'], [num2str(DataOptions(2)) ' Data'], [num2str(DataOptions(3)) ' Data']);


%% Second figure: Mean processing time
figure(2)
plot(WorkerOptions, newList1/DataOptions(1), '-bd')
hold on
plot(WorkerOptions, newList2/DataOptions(2), '-rx')
plot(WorkerOptions, newList3/DataOptions(3), '-go')
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
    seq_processing = [newList1(sequential_idx), newList2(sequential_idx), newList3(sequential_idx)];
    par_processing = [newList1(par_worker); newList2(par_worker); newList3(par_worker)]';
    
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

