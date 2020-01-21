import erc.*
import srb.*
import srb_volt.*
import srs_volt.*
import srs_volt_nm.*
import srs_nm.*
import srs_cost.*
import srs_v_mu.*
import srs_erc_volt.*
import maxSR_cost.*
import maxSR_volt.*

import static.*

load('data_origin.mat')
%load('data_nanas0.mat')
load('voltM_Aug.mat')

load('monthCount.mat')

% load('times.mat')
% 
% yyyymm = str2num(datestr(times,'yyyymm'));
% month = yyyymm(diff([0;yyyymm])~=0);
% monthCount = find([1;diff(yyyymm)]);

output = {'name';'netValue';'weight'};
% output = {'name';'netValue';'weight';'profit'};
col = 2;

covSpan = 4;
rate = 0.003;
startMonth = 49;
monthEnd = 125;


[netValue,weight]=erc(data_origin, monthCount, startMonth, covSpan, rate);
output{1,col} = 'erc';
output{2,col} = netValue;
output{3,col} = weight;
col = col+1;


%span = 4;
% [netValue,weight] = srs(data_origin, monthCount, startMonth, covSpan, span, rate);
% output{1,col} = sprintf('srs_%d',span);
% output{2,col} = netValue;
% output{3,col} = weight;
% col = col+1;
% 
% [netValue,weight] = maxSR(data_origin, monthCount, startMonth, covSpan, span, rate);
% output{1,col} = sprintf('maxSR_%d',span);
% output{2,col} = netValue;
% output{3,col} = weight;
% col = col+1;
%%
%span_test = 4;
span_test = [4,6,8];

% for span = span_test
%     [netValue,weight] = srs_nm(data_origin, monthCount, startMonth, covSpan, span, rate);
%     output{1,col} = sprintf('srs-%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end
% 
% for span = span_test
%     [netValue,weight] = srs_volt_nm(data_origin, monthCount, startMonth, covSpan, span, voltM, rate);
%     output{1,col} = sprintf('srs-m-v-%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end

% for span = span_test
%     [netValue,weight] = maxSR(data_origin, monthCount, startMonth, covSpan, span, rate);
%     output{1,col} = sprintf('maxSR-%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end

for span = span_test
    [netValue,weight] = srs_volt(data_origin, monthCount, startMonth, covSpan, span, voltM, rate);
    output{1,col} = sprintf('srs-v-%d',span);
    output{2,col} = netValue;
    output{3,col} = weight;
    col = col+1;
end


%%
% span_test = [2,4,6,8];
% % span_test = [1,2,4,6,8,10,12];
% for span = span_test
%     [netValue,weight] = srs_volt_nm(data_origin, monthCount, startMonth, covSpan, span, voltM, rate);
%     output{1,col} = sprintf('srs-v-%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end
% 
% for span = span_test
%     [netValue,weight] = maxSR_volt(data_origin, monthCount, startMonth, covSpan, span, voltM, rate);
%     output{1,col} = sprintf('maxSRv%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end
% 
% for span = span_test
%     [netValue,weight] = srb_volt(data_origin, monthCount, startMonth, covSpan, span, voltM, rate);
%     output{1,col} = sprintf('srbv%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end
% 
% for span = span_test
%     [netValue,weight] = srs_volt(data_origin, monthCount, startMonth, covSpan, span, voltM, rate);
%     output{1,col} = sprintf('srsmv%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end
%%
% weight_test = [
% %     [10,6,3,1,0,0,0,0];
% %     [4,3,2,1,0,0,0,0];
% %     [6,5,4,3,2,1,0,0];
% %     [10,6,3,3,1,1,0,0];
% %     [20,12,6,6,2,2,1,1];
%     [10,8,4,4,3,3,0,0];
%     [20,12,2,2,6,6,1,1];
%     [11,9,6,6,4,4,3,3];
%     ];
% for dWeight = weight_test'
%     [netValue,weight] = srs_v_mu(data_origin, monthCount, startMonth, covSpan, voltM, dWeight', rate);
%     output{1,col} = sprintf('%d',dWeight');
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end
%%


% for span = span_test
%     [netValue,weight] = srs_nm(data_origin, monthCount, startMonth, covSpan, span, rate);
%     output{1,col} = sprintf('srs_ns_%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end

% %span_test = [1,2,4,6,8,10,12];
% span_test = [2,4,6,8];
% for span = span_test
%     [netValue,weight] = srs_volt(data_1, monthCount, startMonth, covSpan, span, voltM, rate);
%     output{1,col} = sprintf('srs_v_%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end

% % 1'国债', 2'标普', 3'万A', 4'南华', 5'黄金', 6'恒生'
% cmbW = [0,0,1,1,0,1];
% for span = span_test
%     [netValue,weight,cWeight] = srs_erc_volt(data_1, monthCount, startMonth, covSpan, span, voltM, rate, cmbW);
%     output{1,col} = sprintf('srs_v_erc_%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     output{10,col} = cWeight;
%     col = col+1;
% end

weight_test = [
    [3 3 2 2 2 3];
    [1 1 1 1 1 1];
    [1 1 2 2 2 1];
];
for weight = weight_test'   
    wghtS = weight ./ sum(weight);
    [netValue,valueHist] = static(data_origin, monthCount, startMonth, wghtS, rate);
    output{1,col} = sprintf('(%d,%d,%d,%d,%d,%d)',weight);
    output{2,col} = netValue;
    output{3,col} = valueHist;
    col = col+1;
end



% for span = span_test
%     [netValue,weight] = maxSR(data_origin, monthCount, startMonth, covSpan, span, rate);
%     output{1,col} = sprintf('maxSR_%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end

%load('voltM_garch11_offset_tDstb')


% [netValue,weight] = srs_SR(data_origin, monthCount, startMonth, covSpan, SRm, rate);
% output{1,col} = 'srs_SRm';
% output{2,col} = netValue;
% output{3,col} = weight;
% col = col+1;

% [netValue,weight] = maxSR_SR(data_origin, monthCount, startMonth, covSpan, span, SRm, rate);
% output{1,col} = 'maxSR_SRm';
% output{2,col} = netValue;
% output{3,col} = weight;
% col = col+1;

% for span = span_test
%     [netValue,weight] = srs_cmpd(data_origin, monthCount, startMonth, covSpan, span, rate);
%     output{1,col} = sprintf('srs_cmpd_%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end


% for span = span_test
%     [netValue,weight] = maxSR_volt(data_origin, monthCount, startMonth, covSpan, span, voltM, rate);
%     output{1,col} = sprintf('maxSR_volt_%d',span);
%     output{2,col} = netValue;
%     output{3,col} = weight;
%     col = col+1;
% end
% 
% span=4;
% [netValue,weight] = srs_season(data_origin, monthCount, startMonth, covSpan, span, rate);
% output{1,col} = sprintf('srs_%d',span);
% output{2,col} = netValue;
% output{3,col} = weight;
% col = col+1;

% [netValue,weight] = maxSR(data_origin, monthCount, startMonth, covSpan, span, rate);
% output{1,col} = sprintf('srs_%d',span);
% output{2,col} = netValue;
% output{3,col} = weight;
% col = col+1;





output{5,1} = 'M_ret';
%output{6,1} = 'prop';
output{7,1} = sprintf('Y_ret%d',monthEnd);
output{8,1} = sprintf('Y_vot%d',monthEnd);
output{9,1} = 'SR';
output{10,1} = 'maxDrawdown';
%output{9,1} = 'o_weight';
%%
for n = 2:size(output,2)
    output{5,n} = tick2ret(output{2,n});
    %output{6,n} = sum(output{4,n},1);
    output{7,n} = (output{2,n}(monthEnd) .^ (12/monthEnd)-1) * 100;
    output{8,n} = std(output{5,n}(1:monthEnd)) * sqrt(12) * 100;
    output{9,n} = output{7,n} / output{8,n};
    output{10,n} = maxdrawdown(output{2,n})*100;
    %output{9,n} = output{3,n}(:,[2 3 1 4 5 6]);
end

for n = 2:size(output,2)
    row = 12;
    for yr = 14:12:monthEnd
        output{row,1} = sprintf('Y_ret_%d',yr);
        output{row,n} = (output{2,n}(yr)/output{2,n}(yr-12)-1)*100;
        row = row+1;
    end
end

%%
% n=6;
% monthEnd = 40;
% output{4,n} = tick2ret(output{2,n});
% output{5,n} = (output{2,n}(monthEnd) .^ (4/monthEnd)-1) * 100;
% output{6,n} = std(output{4,n}(1:monthEnd)) * sqrt(3) * 100;
% output{7,n} = output{5,n} / output{6,n};
% output{8,n} = maxdrawdown(output{2,n}(1:monthEnd))*100;
% 

% for n = 2:size(output,2)
%     row = 23;
%     for yr = 14:12:monthEnd
%         output{row,1} = sprintf('Y_vot_%d',yr);
%         output{row,n} = std(output{4,n}(yr-12:yr) * sqrt(12) * 100);
%         row = row+1;
%     end
% end

