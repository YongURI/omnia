function merged = mergenearbytraces(tr, id, sacdir)
% merged = MERGENEARBYTRACES(tr, id, sacdir)
%
% MERGENEARBYTRACES is a wrapper to the shell script 'mergesac' to
% merge split SAC files, specifically returned by fetchnearbytraces.m,
% into a single SAC file.  Requires SAC program.
%
% Output merged files are named:
%
% {NETWORK}.{STATION}.{LOCATION}.{CHANNEL}.merged.SAC,
%
% whose individual files share the common glob:
%
% {NETWORK}.{STATION}.{LOCATION}.{CHANNEL}*,
%
% the latter of which are moved to [sacdir]/unmerged.
%
% Requires program: SAC
%
% Input:
% tr        Trace structures from fetchnearbytraces.m
% id        Event ID [last column of 'identified.txt']
%               defval('11052554')
% sacdir    Directory where [id]/*.SAC written
%               (def: $MERMAID/events/nearbystations/sac/)
%
% Output:
% merged    Cell of merged filenames, if any (def: {})
%
% See also: mergesac, fetchnearbytraces.m, irisFetch.Traces
%
% Author: Joel D. Simon
% Contact: jdsimon@princeton.edu
% Last modified: 06-Feb-2020, Version 2017b on GLNXA64

% Defaults.
defval('id', '11052554')
defval('sacdir', fullfile(getenv('MERMAID'), 'events', 'nearbystations', 'sac'))
merged = {};
if isempty(tr)
    return

end

% Identify all unique file pattern globs.
idx = 0;
for i = 1:length(tr)
    for j = 1:length(tr{i})
        idx = idx + 1;
        glob{idx} = [tr{i}(j).network '.' ...
                     tr{i}(j).station '.' ...
                     tr{i}(j).location '.' ...
                     tr{i}(j).channel '.' ];

    end
end
glob = unique(glob);

% Pass each unique glob to mergesac, which will handle the rest:
% $ mergesac {SAC directory} {file glob}*.SAC {merge filename}
m_idx = 0;
iddir = fullfile(sacdir, num2str(id));
for i = 1:length(glob)
    filelist =  [glob{i} '*.SAC'];
    d = dir(fullfile(iddir, filelist));

    % If the list of files that match the glob is greater than one, merge em.
    if length(d) > 1
        outfname = [glob{i} 'merged.SAC'];
        temp_file = sprintf('%s_mergesac_out.txt', iddir);

        % Call the shell script mergesac.
        [status, result] = ...
            system(sprintf('mergesac %s "%s" %s', iddir, filelist, outfname))

        % Handle errors.
        if status ~= 0 || contains(result, 'ERROR', 'IgnoreCase', true)
            error('SAC merge failed (full printout from mergesac above)')

        end

        % Grow list of merged SAC files.
        m_idx = m_idx + 1;
        merged{m_idx} = fullfile(iddir, outfname);

    end
end
