%load('data_origin.mat')
%load('data_nanas0.mat')
load('month.mat')

%load('data_cmb.mat')
load('map.mat')

%data = data_cmb;
%data_nanas0 = data;
%data_nanas0(isnan(data)) = 0;

startMonth = 49;
values = {'万A','标普','国债','南华','黄金','恒生'};
%values = {'标普','国债','A商金恒'};
%map = [linspace(0.5,1,64)]
%%
%span = 48;
v = VideoWriter('corr_1456_label.avi');
v.FrameRate = 10;
open(v);
%%
figure('Position', [10 10 900 600])
for n = startMonth:(size(monthCount,1)-1)
    for span=1:4       
        subplot(2,2,span)
        corrM = corrcoef(data_nanas0(monthCount(n-12*span):monthCount(n)-1,:));
        hm = heatmap(values,values,corrM,'ColorLimits',[-1 1],'Colormap',map);
        %hm.CellLabelColor = 'none';
        hm.CellLabelFormat = '%.3f';
        hm.Title = sprintf('%d year    %d',span,month(n));
    end
    frame = getframe(gcf);
    writeVideo(v,frame);
end

close(v);
%%
n=121;
figure('Position', [10 10 900 600])
for span=1:4
    subplot(2,2,span)
    corrM = corrcoef(data_nanas0(monthCount(n-12*span):monthCount(n)-1,:));
    hm = heatmap(values,values,corrM,'ColorLimits',[-1 1],'Colormap',map);
    %hm.CellLabelColor = 'none';
    hm.CellLabelFormat = '%.3f';
    hm.Title = sprintf('%d year    %d',span,month(n));
end

%%
% for n = startMonth:(size(monthCount,1)-1)
%    corrM = corrcoef(data_nanas0(monthCount(n-span):monthCount(n)-1,:));
%    hm = heatmap(values,values,corrM,'ColorLimits',[-1 1],'Colormap',map);
%    hm.CellLabelColor = 'none';
%    %hm.CellLabelFormat = '%.3f';
%    hm.Title = sprintf('%d',month(n));
%    frame = getframe(gcf);
%    writeVideo(v,frame);
% end


map = [128,255,128;
132,255,132;
137,255,137;
141,255,141;
145,255,145;
149,255,149;
154,255,153;
158,255,157;
162,255,162;
166,255,166;
170,255,170;
175,255,174;
179,255,178;
183,255,182;
187,255,187;
192,255,191;
196,255,195;
200,255,199;
203,255,203;
207,255,207;
211,255,210;
215,255,214;
219,255,218;
223,255,222;
227,255,226;
231,255,230;
234,255,234;
238,255,238;
242,255,241;
246,255,245;
250,255,249;
254,255,253;
255,252,253;
255,243,249;
255,235,245;
255,227,242;
255,219,238;
255,211,234;
255,203,230;
255,194,226;
255,186,222;
255,178,219;
255,170,215;
255,162,211;
255,153,207;
255,145,203;
255,137,200;
255,129,196;
255,121,192;
255,113,187;
255,105,183;
255,97,179;
255,89,175;
255,80,170;
255,72,166;
255,64,162;
255,56,158;
255,48,154;
255,40,149;
255,32,145;
255,24,141;
255,16,137;
255,8,132;
255,0,128] ./ 255;

% F = struct('cdata',[],'colormap',[]);
% for n = startMonth:(size(monthCount,1)-1)
%     corrM = corrcoef(data_nanas0(monthCount(n-span):monthCount(n)-1,:));
%     hm = heatmap(values,values,corrM);
%     hm.Title = sprintf('%d',month(n));
%     F(n-48) = getframe(gcf);
% end
% 
% fig = figure;
% movie(fig,F,1)
% 
% 
% 
% 
% Z = peaks;
% surf(Z); 
% axis tight manual 
% set(gca,'nextplot','replacechildren'); 
% 
% v = VideoWriter('peaks.avi');
% open(v);
% 
% for k = 1:20 
%    surf(sin(2*pi*k/20)*Z,Z)
%    frame = getframe(gcf);
%    writeVideo(v,frame);
% end
% 
% close(v);

%%%
% https://www.mathworks.com/help/matlab/ref/videowriter.html#busy5fx-1_sep_bus0tu7


