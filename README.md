# Big Data Processing with MATLAB

## About
This project, developed as part of the Big Data module at Coventry University, presents a comprehensive analysis and implementation of big data techniques to process atmospheric science data and climate models. The data for this project was provided by the European Centre for Medium-Range Weather Forecasts (ECMWF).

## Project Goals
- Utilize big data techniques to significantly reduce the processing time for large data sets.
- Make predictions on hardware requirements needed to process the client-provided data set within two hours.
- Compare sequential and parallel processing to determine the more efficient approach.
- Design the code to automatically test for common data errors and address potential issues.

## Software and Toolboxes
- MATLAB_R2022b
- Parallel Computing Toolbox Version 7.7
- Statistics and Machine Learning Toolbox version 12.4
- Data from ECMWF

## File Structure
- **Plotting**: Contains `Graphs.m` and `ResultsToGraphs.m` for data visualization.
- **Processing**: Includes `MainProcessing.m`, `Processing.m`, and `SequentialProcessing.m` for data processing.
- **Testing**: Comprises `AutomatedTestingNonNumeric.m`, `MainAutomatedTesting.m`, and `TestSolutionsWithLogFile.m` for error checking.
- **GUI.m**: Provides a user-friendly interface for setting up analysis parameters.

## Features
- **GUI**: User-friendly interface for data and worker options, and analysis duration.
- **Testing**: Functions to check for NaN or non-numeric errors in the data.
- **Processing**: Options for both sequential and parallel processing, with results logging.
- **Plotting**: Generates graphs for visual analysis of processing times and efficiency.

## Analysis and Recommendations
- Detailed analysis comparing sequential and parallel processing.
- Extrapolation of results to estimate required number of workers and memory.
- Recommendations for hardware requirements based on best industry practices.
- Suggestions for implementing the system using cloud computing technology for scalability and cost-effectiveness.

## Appendices
- Flow Charts
- Gannt Chart
- SMART targets
- Log Book
