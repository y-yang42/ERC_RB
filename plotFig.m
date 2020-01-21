%%
% netValue = cell2mat(output(2,2:8));

len = length(netValue);
x = ((1:len)+10)/12+2008;

figure('Position', [10 10 900 600])
%netValue = [erc_netValue,srs1_netValue,srs2_netValue,srs4_netValue,srs6_netValue,srs8_netValue,srs10_netValue,srs12_netValue];
plot(x,cell2mat(output(2,2)),'k','LineWidth',1)
hold on
plot(x,cell2mat(output(2,3:5)))
plot(x,cell2mat(output(2,6:8)),':','LineWidth',0.7)
%plot(x,cell2mat(output(2,16:17)),':','LineWidth',0.9)
hold off
xlim([x(1) x(end)])
ylim([0.8 2.5])
legend('erc','srs-v-4','srs-v-6','srs-v-8','(3,3,2,2,2,3)','(1,1,1,1,1,1)','(1,1,2,2,2,1)','Location','bestoutside')
%legend('erc','srs-v-4','srs-v-6','srb-v-4','srb-v-6','srs-m-v-4','srs-m-v-6','Location','bestoutside')
%legend('erc','srs','Location','bestoutside')
%legend('erc','srs1','srs2','srs4','srs6','srs8','srs10','srs12','Location','bestoutside')
%legend('erc','maxSR1','maxSR2','maxSR4','maxSR6','maxSR8','maxSR10','maxSR12','maxSR d','Location','bestoutside')

%%
netValue = cell2mat(output(2,[3:10]));
len = length(netValue);
x = ((1:len)+10)/12+2008;

figure('Position', [10 10 900 600])
plot(x,cell2mat(output(2,2)),'k','LineWidth',1)
hold on
plot(x,netValue)
hold off
xlim([x(1) x(end)])
legend('erc','srs-2','srs-4','srs-6','srs-8','maxSR-2','maxSR-4','maxSR-6','maxSR-8','Location','bestoutside')
%legend('erc','srb1','srb2','srb4','srb6','srb8','srb10','srb12','Location','bestoutside')
%%
figure('Position', [10 10 900 600])
plot(x,data_ym49,':','LineWidth',0.7);
hold on
plot(x,cell2mat(output(2,2)),'k','LineWidth',0.7)
plot(x,cell2mat(output(2,[4 8])))
hold off
xlim([x(1) x(end)])
legend('万得全A','标普500','中债国债总财富','南华商品','黄金','恒生','erc','garch4','cmb4','Location','bestoutside')

%%
figure('Position', [10 10 900 600])
prop = [output{6,3};output{6,4};output{6,5};output{6,6}];
bar(prop')
%ylim([-0.05 0.5])
%legend('全A','标普','国债','商品','黄金','恒生')

%%
output_val = [];
output_per = [];
col = 3;

for yr = 13:12:monthEnd
    prop = sum(output{4,col}((yr-11):yr,:));
    output_val = [output_val; prop];
    output_per = [output_per; prop ./ sum(prop) * 100];
end

figure('Position', [10 10 900 600])
pie(output_per(1,:))

%%
len = length(data_ym);
x=((1:len)+10)/12+2004;
figure('Position', [10 10 900 600])
plot(x,data_ym);
xlim([x(1) x(end)])
ylim([0 9])
legend('万得全A','标普500','中债国债总财富','南华商品','黄金','恒生','Location','bestoutside')

%%
C(:,1) = {'BarWidth'; 1};
C(:,2) = {'EdgeColor';'none'};

%%
xW = ((1:128)+10)/12+2008;
figure('Position', [10 10 900 600])
bar(xW,output{3,2},'stacked',C{:})
title('erc')
xlim([xW(1) xW(end)])
ylim([0 1])
lgd = legend('万得全A','标普500','中债国债总财富','南华商品','黄金','恒生','Location','bestoutside');

%%
xW = ((1:128)+10)/12+2008;

figure('Position', [10 10 900 600])
subplot(2,5,[1 2])
bar(xW,output{3,2},'stacked',C{:})
axis([xW(1) xW(end) 0 1])
title('erc')

subplot(2,5,[3 4])
bar(xW,output{3,4},'stacked',C{:})
axis([xW(1) xW(end) 0 1])
title('srs-m-v-2')

subplot(2,5,[6 7])
bar(xW,output{3,6},'stacked',C{:})
axis([xW(1) xW(end) 0 1])
title('srs-m-v-6')

subplot(2,5,[8 9])
bar(xW,output{3,8},'stacked',C{:})
axis([xW(1) xW(end) 0 1])
title('srs-m-v-10')

Lgnd = legend('万得全A','标普500','中债国债总财富','南华商品','黄金','恒生','Location','bestoutside');
Lgnd.Position(1) = 0.78;
Lgnd.Position(2) = 0.78;

%%

figure
subplot(2,3,1);       h1 = plot(randperm(10),randperm(10),'ko-');
subplot(2,3,2);       h2 = plot(randperm(10),randperm(10),'g+-');
subplot(2,3,4);       h3 = plot(randperm(10),randperm(10),'md-');
subplot(2,3,5);       h4 = plot(randperm(10),randperm(10),'rv-.');

hL = subplot(2,3,3);
poshL = get(hL,'position');     % Getting its position

lgd = legend(hL,[h1;h2;h3;h4],'RandomPlot1','RandomPlot2','RandomPlot3','RandomPlot4');
set(lgd,'position',poshL);      % Adjusting legend's position
axis(hL,'off');                 % Turning its axis off

%% maxSR
len=128;

figure('Position', [10 10 900 600])
subplot(2,2,1)
bar(output{3,3},'stacked',C{:})
title('span=1')
axis([1 len 0 1])

subplot(2,2,2)
bar(output{3,4},'stacked',C{:})
title('span=2')
axis([1 len 0 1])

subplot(2,2,3)
bar(output{3,5},'stacked',C{:})
title('span=4')
axis([1 len 0 1])

subplot(2,2,4)
bar(output{3,6},'stacked',C{:})
title('span=6')
axis([1 len 0 1])


%%
xW = ((1:128)+10)/12+2008;
xN = ((0:128)+10)/12+2008;
row = 10;

figure('Position', [10 10 900 400])
subplot(2,2,1)
bar(xW,output{row,8},'stacked',C{:})
axis([xW(1) xW(end) 0 1])
title('cmb4')

subplot(2,2,2)
bar(xW,output{row,9},'stacked',C{:})
axis([xW(1) xW(end) 0 1])
title('cmb6')

subplot(2,2,3)
plot(xN,data_ym49(:,[1 4 6]),':','LineWidth',0.7);
hold on
plot(xN,cell2mat(output(2,2)),'k','LineWidth',0.7)
plot(xN,cell2mat(output(2,[4 8])))
hold off
xlim([xN(1) xN(end)])
legend('万得全A','南华商品','恒生','erc','garch4','cmb4','Location','northwest')

subplot(2,2,4)
plot(xN,data_ym49(:,[1 4 6]),':','LineWidth',0.7);
hold on
plot(xN,cell2mat(output(2,2)),'k','LineWidth',0.7)
plot(xN,cell2mat(output(2,[5 9])))
hold off
xlim([xN(1) xN(end)])
legend('万得全A','南华商品','恒生','erc','garch6','cmb6','Location','northwest')

%%
figure('Position', [10 10 900 400])
len = length(data_nanas0);
x = ((1:len)+22)/250+2004;

plot(x,data_nanas0(:,1))
xlim([x(1) x(end)])


%%
len = 128;
x = ((1:len)+10)/12+2008;
row = 10;

figure('Position', [10 10 900 400])
subplot(2,2,1)
bar(x,output{row,7},'stacked',C{:})
xlim([x(1) x(end)])
title('cmb2')

subplot(2,2,2)
bar(x,output{row,8},'stacked',C{:})
xlim([x(1) x(end)])
title('cmb4')

subplot(2,2,3)
bar(x,output{row,9},'stacked',C{:})
xlim([x(1) x(end)])
title('cmb6')

subplot(2,2,4)
xlim([x(1) x(end)])
bar(x,output{row,10},'stacked',C{:})
title('cmb8')



axis([dateS x(end) 0 1])


%%
len = 128;
x = ((1:len)+10)/12+2008;
row=9;

dateS = x(1);

figure('Position', [10 10 900 400])
subplot(2,3,1)
bar(x,output{row,4},'stacked',C{:})
title('garch4')
axis([dateS x(end) 0 1])
set(gca,'TickDir','out')

subplot(2,3,4)
bar(x,output{row,8},'stacked',C{:})
title('cmb4')
axis([dateS x(end) 0 1])
set(gca,'TickDir','out')

subplot(2,3,2)
bar(x,output{row,5},'stacked',C{:})
title('garch6')
axis([dateS x(end) 0 1])
set(gca,'TickDir','out')

subplot(2,3,5)
bar(x,output{row,9},'stacked',C{:})
title('cmb6')
axis([dateS x(end) 0 1])
set(gca,'TickDir','out')

subplot(2,3,3)
bar(x,output{row,6},'stacked',C{:})
title('garch8')
axis([dateS x(end) 0 1])
set(gca,'TickDir','out')

subplot(2,3,6)
bar(x,output{row,10},'stacked',C{:})
title('cmb8')
axis([dateS x(end) 0 1])
set(gca,'TickDir','out')




%%

figure('Position', [10 10 900 600])
colormap(parula)
bar(output{3,2},'stacked','DisplayName','erc_weight','BarWidth', 1)
axis([0 160 0 1])
legend('万得全A','标普500','中债国债总财富','南华商品','黄金','恒生','Location','bestoutside')

figure('Position', [10 10 900 600])
plot(comp(:,[1 2 4]),'LineWidth',1)
legend('real','mean','grach')

figure('Position', [10 10 900 600])
plot(cell2mat(output(9:end,2:end)))
legend('erc','srs1','srs2','srs4','srs6','srs8','srs10','srs12','Location','bestoutside')


figure('Position', [10 10 900 600])
subplot(2,2,[1 3])
plot(r)
hold on
const = ones(T).*mean(r);
plot(const,'r','LineWidth',2)
xlim([0,T])
title('Daily Returns')


e = r - mean(r);

figure
subplot(4,2,1)
autocorr(e.^2)
title('sample size = 3798')
subplot(4,2,3)
parcorr(e.^2)

subplot(4,2,2)
autocorr(e(1:1000).^2)
title('sample size = 1000')
subplot(4,2,4)
parcorr(e(1:1000).^2)

subplot(4,2,5)
autocorr(e(1:600).^2)
title('sample size = 600')
subplot(4,2,7)
parcorr(e(1:600).^2)

subplot(4,2,6)
autocorr(e(1:200).^2)
title('sample size = 200')
subplot(4,2,8)
parcorr(e(1:200).^2)
