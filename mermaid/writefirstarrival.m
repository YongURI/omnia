function writefirstarrival(s, redo, filename, fmt, wlen, lohi, sacdir, ...
                           evtdir, EQ)
% WRITEFIRSTARRIVAL(s, redo, filename, fmt, wlen, lohi, sacdir, ...
%                   evtdir, EQ)
%
% WRITEFIRSTARRIVAL writes the output of firstarrival.m a text file.
%
% N.B. in describing the text file below the "true" arrival time
% (found with cpest.m) is labeled "dat", while the theoretical arrival
% time of the first-arriving phase is labeled "syn".
%
% Input:
% s        Cell array of identified SAC filenames (def: revsac(1))
% redo     true: delete and remake the text file
%          false: append new lines to the existing tex file unless
%              that SAC file name already exists in the text file (def)
% filename Output text file name (def: $MERMAID/.../firstarrivals.txt)
% fmt      Line format, e.g., set if using SAC files with names
%              longer than 44 chars (see default internally)
% wlen     Window length [s] (def: 30)
% lohi     1x2 array of corner frequencies (def: [1 5]])
% sacdir   Directory containing (possibly subdirectories)
%              of .sac files (def: $MERMAID/processed)
% evtdir   Directory containing (possibly subdirectories)
%              of .evt files (def: $MERMAID/events)
% EQ      Cell array (same size as 's') of EQ structs, if they are
%             not reviewed, or one different from saved is preferred
%
% Output:
% Text file with the following columns (firstarrivals.m outputs in parentheses):
%    (1) SAC filename
%    (2) Theoretical 1st-arriving phase name (ph)
%    (3) Travel time residual: dat - syn (tres)
%    (4) Time delay between cpest.m arrival time estimate and
%        maximum absolute amplitude (delay)
%    (5) 2-standard deviation error estimation per M1 method (twosd)
%    (6) Signal-to-noise ratio of "dat" in a time window centered on "syn"
%        (SNR)
%    (7) Maximum absolute amplitude in counts in the time window starting at
%        "dat" and extending 1/2 the length of the input window (maxc_y)
%
% See also: firstarrival.m, readfirstarrival.m
%
% Author: Joel D. Simon
% Contact: jdsimon@princeton.edu
% Last modified: 27-Sep-2019, Version 2017b on MACI64

% Defaults.
defval('s', revsac(1))
defval('redo', false)
defval('filename', fullfile(getenv('MERMAID'), 'events', 'reviewed', ...
                            'identified', 'txt', 'firstarrivals.txt'))
defval('fmt', ['%44s    '  , ...
               '%5s    '   , ...
               '%6.2f    ' , ...
               '%6.2f    ' , ...
               '%5.2f    ' , ...
               '%9.1f    ' , ...
               '%11i\n'])
defval('wlen', 30)
defval('lohi', [1 5])
defval('sacdir', fullfile(getenv('MERMAID'), 'processed'))
defval('evtdir', fullfile(getenv('MERMAID'), 'events'))

% Sort out if deleting, appending to, or creating output file.
file_exists = (exist(filename,'file') == 2);
if file_exists
    % Grant write access to file.
    fileattrib(filename, '+w')

    if redo
        % Clear existing contents.
        fid = fopen(filename, 'w');
        fprintf('Deleted:\n%s\n\n', filename);
        verb = 'Wrote';

    else
        % Append to existing contents.
        fid = fopen(filename, 'a');
        verb = 'Appended';

    end
else
    % Generate new file.
    fid = fopen(filename, 'w+');
    fprintf('Created:\n%s\n\n', filename);
    verb = 'Wrote';

end

% Loop over every SAC file, skipping those that already exist in the
% output file, and concatenating the lines of all others to be written
% in one fell-swoop later.
wline = [];
wlines = [];
parfor i = 1:length(s)
    sac = s{i};

   % Skip SAC files that are already written.
   if ~redo && ~isempty(mgrep(filename, strippath(sac)))
       continue

   end

   % Concatenate the write lines.
   wline = single_wline(sac, true, wlen, lohi, sacdir, evtdir, fmt, EQ);
   wlines = [wlines wline];

end

if isempty(wlines)
    % Nothing to do if there are no new lines to write.
    fprintf('No new lines written to:\n%s\n', filename)

else
    % Append new lines to the text file.
    fprintf(fid, wlines);
    fclose(fid);

    % Exit with informative printout.
    numlines = length(regexp(wlines, '\n'));
    fprintf('%s %i %s to:\n%s\n', verb, numlines, plurals('line', ...
                                                      numlines), filename)
end


% Write protect the file.
fileattrib(filename, '-w')

%_______________________________________________________________________________%
function wline = single_wline(sac, ci, wlen, lohi, sacdir, evtdir, fmt, EQ)
% Local call to, and formatting of, firstarrival.m

% Collect.
[tres, dat, syn, ph, delay, twosd, ~, ~, ~, maxc_y, SNR] = ...
    firstarrival(sac, true, wlen, lohi, sacdir, evtdir, EQ);

% Parse.
data = {strippath(sac), ...
        ph,             ...
        tres,           ...
        delay,          ...
        twosd,          ...
        SNR,            ...
        round(maxc_y)};

% Format.
wline = sprintf(fmt, data{:});
