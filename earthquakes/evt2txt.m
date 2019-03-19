function txt = evt2txt(revdir, procdir, geoazur)
% txt = EVT2TXT(revdir, procdir, geoazur)
%
% EVT2TXT converts reviewed .evt files (which are really .mat files)
% to human readable textfiles.
%
% EVT2TXT (over)writes: 
%    [revdir]/reviewed/identified/txt/identified.txt
%    [revdir]/reviewed/unidentified/txt/unidentified.txt
%    [revdir]/reviewed/all.txt
%
% Inputs:
% iup       Reviewed subdirectory (def: 1)
%           1 identified
%          -1 unidentified
%           0 purgatory
% revdir    Path to directory containing 'reviewed' subdirectory
%               (def: $MERMAID/events)
% procdir   Path to 'processed' directory containing SAC files
%               e.g., for fullsac.m (def: $MERMAID/processed)
% geoazur   logical true to assume GeoAzur's naming scheme 
%               (def: false)
%
% Output:
% *N/A*     Writes formatted textfiles
% txt       Formatted text structure with fields:
%           .identified
%           .unidentified
%           .all  
%
% GeoAzur naming scheme example:
%    'm12.20130416T105310.sac'
%
% Current naming scheme example (default):
%
%
%
% Before running the example below run the example in reviewevt.m and
% make these directories:
% mkdir ~/sac2evt_example/reviewed/identified/txt/
% mkdir ~/sac2evt_example/reviewed/unidentified/txt/
%
% Ex: (write a line to identified.txt and all.txt)
%    revdir = '~/sac2evt_example';
%    txt = evt2txt(revdir)
% 
% See also: sac2evt.m, reviewevt.m, revsac.m, getevt.m
%
% Author: Joel D. Simon
% Contact: jdsimon@princeton.edu
% Last modified: 18-Mar-2019, Version 2017b

% Defaults.
defval('revdir', fullfile(getenv('MERMAID'), 'events'))
defval('procdir', fullfile(getenv('MERMAID'), 'processed'))
defval('geoazur', false)

% Initialize empty struct to hold text lines and specify format.
txt.all = [];
txt.identified = [];
txt.unidentified = [];

if ~geoazur
    fmt = ['%44s\t'  , ...
           '%23s\t'  , ...
           '%6.2f\t' , ...
           '%7.2f\t' , ...
           '%34s\t'  , ...
           '%6.2f\t' , ...
           '%6.2f\t' , ...
           '%4.1f\t' , ...
           '%6s\t'   , ...
           '%13s\n'];

else
    fmt = ['%23s\t'  , ...
           '%23s\t'  , ...
           '%6.2f\t' , ...
           '%7.2f\t' , ...
           '%34s\t'  , ...
           '%6.2f\t' , ...
           '%6.2f\t' , ...
           '%4.1f\t' , ...
           '%6s\t'   , ...
           '%13s\n'];

end
% Fetch and format data.
allsactimes = {};
review_status = {'identified', 'unidentified'};
for i = 1:2
    status = review_status{i};
    if strcmp(status, 'identified')
        iup =  1;

    else
        iup = -1;

    end
    [sac, evt] = revsac(iup, revdir);

    if isempty(sac)
        % Possible to have the correct path but no .evt files (see the example
        % in the header where no "unidentified" events are present).
        % Rely on warning in revsac.m to alert user.
        continue

    end

    % Sort the events based on the time assigned the first sample in the seismogram.

    % !! Edit this line to accommodate different SAC naming schemes.  In
    % our case the first 15 chars of the filename tag the time of the
    % first sample of the seismogram.
    if ~geoazur 
        sactime = cellfun(@(xx) xx(1:15), sac, 'UniformOutput', false);

    else
        sactime = cellfun(@(xx) xx(5:19), sac, 'UniformOutput', false);

    end

    [~, idx] = sort(sactime);
    sac = sac(idx);
    evt = evt(idx);

    % Keep track of identified and unidentified sactimes in single array
    % sorting after concatenation.
    allsactimes = [allsactimes  sactime];

    for j = 1:length(evt)
        tmp = load(evt{j}, '-mat');
        EQ = tmp.EQ;
        clear('tmp')
        
        if strcmp(status, 'identified')
            % Make note of multiple event and/or phase matches by tagging the
            % public ID or phase name with a ('*') prefix.
            publicid = fx(strsplit(EQ(1).PublicId, '='),  2);
            if length(EQ) > 1
                publicid = ['*' publicid];
            end
            
            eqphase = EQ(1).TaupTimes(1).phaseName;
            if length(EQ(1).TaupTimes) > 1
                eqphase = ['*' eqphase];

            end
        
            data = {EQ(1).FileName,
                    EQ(1).PreferredTime(1:19),
                    EQ(1).PreferredLatitude,
                    EQ(1).PreferredLongitude,
                    EQ(1).FlinnEngdahlRegionName,
                    EQ(1).PreferredDepth,
                    EQ(1).TaupTimes(1).distance,
                    EQ(1).PreferredMagnitudeValue,
                    eqphase,
                    publicid};

            
        else
            data = {sac{j}, NaN(1,9)};

        end
        txt.(status){j} = sprintf(fmt, data{:});

    end
end

% Write 'identified.txt' and 'unidentified.txt'.
for i = 1:2
    status = review_status{i};    
    fout  = fullfile(revdir, 'reviewed', status, 'txt', [status '.txt']);
    
    if exist(fout, 'file')
        wstatus = fileattrib(fout, '+w', 'a');
        if wstatus == 0 
            error('Unable to allow write access to %s.', fout) 
            
        end
    end

    fid = fopen(fout, 'w');
    for j = 1:length(txt.(status))
        fprintf(fid, txt.(status){j});
        
    end
    fclose(fid);
    
    wstatus = fileattrib(fout, '-w', 'a');
    if wstatus == 0 
        error('Unable to restrict write access to %s.', fout) 
        
    end
end

% Write 'all.txt' by concatenating identified and unidentified text.
% Sort again based on time assigned to first sample.
txt.all = [txt.identified txt.unidentified];
[~, idx] = sort(allsactimes);
txt.all = txt.all(idx);

fout  = fullfile(revdir, 'reviewed', 'all.txt');
if exist(fout, 'file')
    wstatus = fileattrib(fout, '+w', 'a');
    if wstatus == 0 
        error('Unable to allow write access to %s.', fout) 
        
    end
end

fid = fopen(fout, 'w');
for j = 1:length(txt.all)
    fprintf(fid, txt.all{j});
    
end
fclose(fid);

wstatus = fileattrib(fout, '-w', 'a');
if wstatus == 0 
    error('Unable to restrict write access to %s.', fout) 
    
end
