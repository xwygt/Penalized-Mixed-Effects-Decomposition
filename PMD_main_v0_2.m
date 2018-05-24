% Edit by Xiaowei Yue on 02/02/2016, Updated on 03/06/2017, Updated on
% 05/20/2017, updated on 05/18/2018
% Topic: Penalized Mixed Effect Decomposition for Multichannel Profile Detection
% Related Paper: Yue, X.,Yan H., Park, J.G., Liang, Z., Shi, J., 
%                “A Wavelet-based Penalized Mixed-effects Decomposition for 
%                Multichannel Profile Detection of In-line Raman Spectroscopy”.

clc;clear;close all;
addpath(genpath('.\data'));
addpath(genpath('.\functions'));
addpath(genpath('.\results'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1. Simulation
%% 1.1 Generate simulation dataset based on ideal Raman curve
disp('Generate simulation dataset...')
run PMD_1_1_gen_sim_data_v1.m

%% 1.2 Wavelet-based Penalized Mixed Effects Model
disp('Run the Penalized Mixed Effects Decomposition...')
run PMD_1_2_run_PMD_v1.m

%% 1.3 Sensitivity Analysis of the bounds and the penalized parameter
disp('Run the Sensitivity Analysis of the bounds and the penalized parameter...')
run PMD_1_3_sensitivity_analysis_v2.m 

%% 1.4 Benchmark 1: Linear Mixed Effects Model (LMM) based on Spline

run PMD_1_4_benchmark1_LMM_v1.m

%% 1.5 Benchmark 2: Smooth Sparse Decomposition (SSD)
% related paper: Yan, H., Paynabar, K., & Shi, J. (2017). Anomaly detection 
% in images with smooth background via smooth-sparse decomposition. Technometrics, 59(1), 102-114.

% run PMD_1_5_benchmark2_SSD_v1.m


%% 1.6 Show the results of Simulation
% load all the results above from 'result_v1.mat'
disp('Show the result...')
run PMD_1_6_show_result_v1.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 2.Real Data Analysis
%% 2.1 introduce real data
clc;clear;close all;
disp('Introduce the real data...')
run PMD_2_1_intro_real_data_v1.m

%% 2.2 PMD Analysis
disp('Run the PMD method...')
run PMD_2_2_run_PMD_v1.m

%% 2.3 show results
disp('Show the results...')
run PMD_2_3_show_result_v1.m

disp('Completed.')

