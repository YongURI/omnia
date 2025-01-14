function [sac, evt] = revsac(iup, sacdir, evtdir, returntype)
% [sac, evt] = REVSAC(iup, sacdir, evtdir, returntype)
%
% REVSAC returns a list of fullpath .sac and .evt filenames
% whose event information has been reviewed and sorted with
% reviewevt.m into either:
%
% [evtdir]/reviewed/identified/evt,
% [evtdir]/reviewed/unidentified/evt, or
% [evtdir]/reviewed/purgatory/evt.
%
% Input:
% iup          [evtdir]/reviewed/ directory (def: 1)
%              1: identified
%             -1: unidentified
%              0: purgatory
% sacdir       Directory where .sac files are kept
%                  def($MERMAID/processed)
% evtdir       Path to directory containing 'raw/' and 'reviewed'
%                  subdirectories (def: $MERMAID/events/)
% returntype   For third-generation+ MERMAID only:
%              'ALL': both triggered and user-requested SAC files (def)
%              'DET': triggered SAC files as determined by onboard algorithm
%              'REQ': user-requested SAC files
% Output:
% sac          Cell array of SAC filenames whose corresponding
%                  .evt file is in the reviewed subdirectory of interest
% evt          Cell array of .evt filenames whose corresponding
%                  in the reviewed subdirectory of interest
%
% Before running the example below run the example in reviewevt.m
%
% Ex: (load EQ data from an identified SAC file)
%    sacdir = fullfile(getenv('OMNIA'), 'exfiles')
%    evtdir = '~/cpsac2evt_example';
%    [sac, evt] = REVSAC(1, sacdir, evtdir);
%    load(evt{1}, '-mat')
%    EQ
%
% See also: getevt.m, reviewevt.m, fullsac.m
%
% Author: Joel D. Simon
% Contact: jdsimon@princeton.edu
% Last modified: 25-Sep-2019, Version 2017b on GLNXA64

% Defaults.
defval('iup', 1)
defval('sacdir', fullfile(getenv('MERMAID'), 'processed'))
defval('evtdir', fullfile(getenv('MERMAID'), 'events'))
defval('returntype', 'ALL')

sac = [];
evt = [];

% Switch the reviewed directory of interest.
switch iup
  case 1
    status = 'identified';

  case -1
    status = 'unidentified';

  case 0
    status = 'purgatory';

  otherwise
    error('Specify 1, -1, or 0 for first input.')

end

% Find the relevant paths.
evt_path = fullfile(evtdir, 'reviewed', status, 'evt');
evtdir = dir([evt_path '/*.evt']);
if isempty(evtdir)
    warning('No .evt files found in %s', evt_path)
    return

end

% Concatenate the .evt paths.
for i = 1:length(evtdir)
    evt{i} = fullfile(evtdir(i).folder, evtdir(i).name);

end

% Keep just those events in of the requested return type.
switch upper(returntype)
  case 'DET'
    idx = cellstrfind(evt, 'MER.DET.*.evt');
    if isempty(idx)
        warning('No triggered (''DET'') .evt files found')
        evt = [];
        return

    end

  case 'REQ'
    idx = cellstrfind(evt, 'MER.REQ.*.evt');
    if isempty(idx)
        warning('No requested (''REQ'') .evt files found')
        evt = [];
        return

    end

  case 'ALL'
    idx = [1:length(evt)];

  otherwise
    error('Specify one of ''ALL'', ''DET'', or ''REQ'' for input: returntype')

end
evt = evt(idx);

% Replace the filename extension.
sac = strrep({evtdir.name}, '.evt', '.sac');

% To find the fullpath SAC filenames: start with all SAC fullpath
% filenames.
allsac = fullsac([], sacdir, returntype);
if isempty(allsac)
    sac = []; % No warning necessary here as it will be thrown in fullsac.m
    return

end

% Find the intersection between all SAC filenames and those in the
% specified review class.
allsac_nopath = cellfun(@(xx) strippath(xx), allsac, 'UniformOutput', false);
[~, ~, idx] = intersect(sac, allsac_nopath);
sac = allsac(idx);
sac = sac(:);
evt = evt(:);
