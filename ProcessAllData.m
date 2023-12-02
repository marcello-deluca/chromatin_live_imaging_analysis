clear,clc
files = [ ...
"8hb_8xCy5_1x7G5_b2_8",...
"8hb_8xCy5_1x7G5_b2_10",...
"8hb_8xCy5_1x7G5_b2_11",...
"8hb_8xCy5_1x7G5_b2_12",...
"8hb_8xCy5_1x7G5_b2_13",...
"8hb_8xCy5_1x7G5_b2_14",...
"8hb_8xCy5_1x7G5_b2_22",...
"8hb_8xCy5_1x7G5_b2_23" ...
];


PATH = "C:/Users/sophia/Desktop/marcello_tracking/shorter_stacks/trackingResults";
OutTables = {};
OutTrajs = {};
OutTracks = {};
Unedited = {};

%diffusion data here
MSDS = {};
SEMS = {};
LENS = {};

for i=1:length(files)   
    OutTables{i} = readtable(sprintf("%s/%sSignal_expanded.csv",PATH,files(i)));
    OutTrajs{i}  = ParticleTracker(OutTables{i});
    [Unedited{i},OutTracks{i}] = PersistentParticleTracks(OutTrajs{i}, files(i));
%     szt = size(OutTracks{i});
%     for q=1:szt(2)
%         sztr = size(OutTracks{i}())
%     end
    [MSD,SEM,LEN] = GetDiffusionBehavior(OutTracks{i});
    MSD = [0, MSD];
    SEM = [0, SEM];
    LEN = [0, LEN];
    MSDS{end+1}=MSD;
    SEMS{end+1}=SEM; 
    LENS{end+1}=LEN;
    %OverlayTrajectoryOnTif(OutTrajs{i},sprintf("%s/..",PATH),files(i),sprintf("%s/Animations/%s.gif",PATH,files(i)));
    OverlayTracksOnTif(OutTracks{i},sprintf("%s/..",PATH),files(i),sprintf("%s/Animations/%s.jpg",PATH,files(i)));
   % close all
end

plot_MSD_curves;
[SDS, MultiMSD, MultiSEM] = plotMeanMSDCurve(OutTracks);
MultiMSD = [0, MultiMSD];
MultiSEM = [0,MultiSEM];