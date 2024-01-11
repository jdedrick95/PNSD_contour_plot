%% size_dist_timeseries_example.m
%
% PURPOSE: Uses size distribution data to create a time series contour
% plot. 
%
% INPUTS: Size distribution data (any time average). 
%
% OUTPUTS: .PNG plot of size distribution time series contour plot. 
%
% AUTHOR: Jeramy Dedrick
%         Scripps Institution of Oceanography
%         November 22, 2021
%         
clear all; close all; clc



%% Load size distribution data example

load('COMBLE_SMPS_example.mat')


%% Plotting the timeseries

figure(1)

% limit of concentration range (change this based on relative min/max of data
SMPS_PNSD_lim = [1 300];


% plotting size distribution as "imagesc" 
SMPS_fig   = imagesc(time_hr(1:744), ...          % time matrix (x)
                    SMPS_d_mid(66:173), ...      % midpoint diameters (y) 
                    SMPS_PNSD_hr(66:173,1:744)); % size distribution (z, contours) (DIMENSIONS: ROW = diameter, COLUMN = HOUR)
                 
               
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% UNCOMMENT AND RUN THIS SECTION IF THERE ARE LONG PERIODS WITH MISSING DATA 

% finds break in period (find where uimage stretches data)                  
% SMPS_nan_block = find(diff(SMPS_fig.CData(1,:)) == 0); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% renames for specification
SMPS_mat_plot = SMPS_fig.CData; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% UNCOMMENT AND RUN THIS SECTION IF THERE ARE LONG PERIODS WITH MISSING DATA               

%SMPS_mat_plot(:,SMPS_nan_block) = NaN; % replaces stretch w/NaN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% blanking NaNs and scaling plot to a colormap
set(SMPS_fig, 'AlphaData', ~isnan(SMPS_mat_plot), ... % blank NaNs
   'CDataMapping', 'scaled')                          % scales map to colormap
        
        
set(gca, ...             % set current axis
    'ydir','normal', ... % make y axis normal
    'YScale', 'log', ... % make y axis logscale
    'ColorScale','log')  % make colorscale log

grid on
datetick('x', 'mm/dd/yy', 'keepticks')
ylim([9e-3 6e-1])
ylabel('diameter (\mum)')

% specify colormap
colormap jet

% set limits of colorbar based on relative min/max of data (see line 9)
caxis(SMPS_PNSD_lim)

% name colorbar to set specifications later
SMPS_cb = colorbar;


set(gca, ...                    % get current axis 
    'YTick', 10.^(-2:1:1),...   % set diameter ticks (on y axis)
    'TickDir','out', ...        % set tick directions outward
    'FontSize', 12)             % make font bigger


ylabel(SMPS_cb, 'dN/dlogDp (cm^{-3})', ...
       'FontSize', 12)

% set figure size
set(gcf, 'Position', [200 200 600 200])

% save figure as PNG
print('example_size_dist_timeseries', '-dpng')



