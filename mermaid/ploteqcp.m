function F = ploteqcp(EQ, CP, h)
%% This assumes a single EQ. %%

defval('diro', fullfile(getenv('MERMAID'), 'processed'))

% Some plotting defaults.
linewidth = 1;
fonts = 11;


%% PLOT CHANGEPOINT

% Plot arrival times for all scales -- in case of time-scale domain,
% smooth by setting abe/dbe to central point of the time smear.
F.fig = figure;
F.f = plotchangepoint(CP, 'all', 'ar');
%set(F.f.ha, 'YLim', [-2 2]);

%% PLOT THEORETICAL ARRIVAL TIMES.

% Title the seismogram (first subplot).
ax = F.f.ha(1);
hold(ax, 'on')
F.tl = title(ax, EQ(1).FlinnEngdahlRegionName, 'FontSize', ...
             17, 'FontWeight', 'normal');
F.tl.Position(2) = 2;

% Mark arrivals matched with the residuals.
[tres_time, tres_phase, tres_EQ, tres_TT] = tres(EQ, CP, false, 'middle');
unique_res = tres_TT(~isnan(tres_TT));

for j = 1:1%length(EQ)
    for k = unique_res
        tp = EQ(j).TaupTimes(k);
        tparr = tp.arsecs;

        if tparr >= CP.outputs.xax(1) && ...
                    tparr <= CP.outputs.xax(end)
            F.tp{j}{k} = plot(ax, repmat(tparr, [1, 2]), ...
                              ax.YLim, 'k', 'LineWidth', 2*linewidth);
            phstr = sprintf('%s', tp.phaseName);
            F.tx{j}{k} = text(ax, tparr, 1.7, phstr, ...
                              'HorizontalAlignment', 'Center', ...
                              'FontSize', F.tl.FontSize, 'FontWeight', 'Normal');

        else        
            F.tp{j}{k} = [];
            F.tx{j}{k} = [];
            
        end
    end                            
end
hold(ax, 'off')

% Annotate the seismogram with the largest event info.
magstr = sprintf('%.1f~%s', EQ(1).PreferredMagnitudeValue, ...
                 EQ(1).PreferredMagnitudeType);
depthstr = sprintf('%.2f~km', EQ(1).PreferredDepth);
diststr = sprintf('%.2f$^{\\circ}$', EQ(1).TaupTimes(1).distance);


% Order clockwise from upper left.
ax = F.f.ha(1);
[F.lg(1), F.lgtx(1)] = textpatch(ax, 'NorthWest', magstr, 10);
[F.lg(2), F.lgtx(2)] = textpatch(ax, 'NorthEast', [diststr ', ' depthstr], 10);
%[F.lg(3), F.lgtx(3)] = textpatch(ax, 'SouthEast', depthstr, 10);
%[F.lg(4), F.lgtx(4)] = textpatch(ax, 'SouthWest', EQ.Filename, 10);

set([F.f.pl.aicj{:}], 'LineWidth', linewidth)
set([F.f.pl.da{:}], 'LineWidth', linewidth)


% Shrink the distance between each subplot -- 'multiplier' is adjusted
% depending on the number of subplots (the number of wavelet scales
% plotted).
multiplier = 0;
switch CP.inputs.n
  case 3
    shrink(F.f.ha, 1, 1.53)
    for l = 1:length(F.f.ha)
        multiplier = multiplier + 1;
        movev(F.f.ha(l), multiplier * 0.08)
        
    end
    movev(F.f.ha, -0.1)
    
  case 5
    for l = 1:length(F.f.ha)
        multiplier = multiplier + 1;
        movev(F.f.ha(l), multiplier * 0.02)
        
    end
    movev(F.f.ha, -0.1)
    
  otherwise
    % Add to this list with trial and error given more examples with
    % differing sampling frequencies.
    warning('No figure formatting scheme available for %i %s', ...
            CP.n, plurals('scale', CP.n))
    
end

% Remove x-tick labels from all but last plot and label the lower x-axis.
set(F.f.ha(1:end-1), 'XTickLabel', '')
F.f.ha(1).YTick = [-1:1];

seisdate = seistime(h);

F.f.ha(end).XLabel.String = sprintf(['time relative to %s UTC ' ...
                    '(s)\n[%s]'], datestr(seisdate.B), ...
                                    strrep(EQ(1).Filename, '_', '\_'));
F.f.ha(end).XLabel.FontSize = 13;
longticks(F.f.ha, 3)

% % Add the scale-specific SNR, tres, and fatten CP arrival marks.
for j = 1:length(CP.SNRj)
    if CP.SNRj(j) > CP.inputs.snrcut % Cp.arsecs = NaN
        
        % SNR
        [F.lgsnr(j), F.lgsnrtx(j)] = textpatch(F.f.ha(j + 1), ...
                                               'SouthWest', ...
                                               sprintf('SNR = %.1f', ...
                                                       CP.SNRj(j)), 10);
        tack2corner(F.f.ha(j+1), F.lgsnr(j),'SouthWest');

        tres_str = sprintf(['tres. [%s] = %.1f s\n2$\\cdot$SD = %.1f ' ...
                            's'], tres_phase{j}, tres_time(j), ...
                           CP.ci.M1(j).twostd);
        
        xl = F.f.ha(j+1).XLim;
        xl = xl(2);
        yl = F.f.ha(j+1).YLim;
        text(F.f.ha(j+1), xl*1.15, mean(yl),  tres_str, 'FontSize', ...
             F.f.ha(end).XLabel.FontSize, 'HorizontalAlignment', 'Center')
        set(F.f.pl.vl{j}, 'LineWidth', 2*linewidth)

    else
        [F.lgsnr(j), F.lgsnrtx(j)] = textpatch(F.f.ha(j + 1), ...
                                               'SouthWest', ...
                                               sprintf('SNR $\\leq$ %.1f', ...
                                                       CP.inputs.snrcut), 10);
        
    end
    tack2corner(F.f.ha(j+1), F.lgsnr(j),'SouthWest');
    F.f.ha(j+1).XLim = [0 F.f.ha(j+1).XLim(2)];

end

latimes

% Tack all legends to corners.
tack2corner(F.f.ha(1), F.lg(1), 'NorthWest')
tack2corner(F.f.ha(1), F.lg(2), 'SouthWest')
