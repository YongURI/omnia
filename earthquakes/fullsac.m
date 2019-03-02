function s = fullsac(singl, diro)
% s = FULLSAC(singl, diro)
%
% FULLSAC returns full-path (complete) filenames of SAC files in "diro."
%
% FULLSAC returns a cell array of full-path filenames of all SAC files
% in "diro" if "singl" is left empty (default) (Ex. 1)
%
% --or--
%
% FULLSAC returns a single full-path filename if "singl" is a SAC
% partial-path filename, e.g., you want the full path on your system
% to 20180811T094852.09_5B6F01F6.MER.DET.WLT5.sac (Ex. 2)
%
% Inputs:
% singl        Single SAC file, possibly with incomplete path, 
%                  to which you wish to have the complete path returned.
%                  Leave empty to return all SAC files in diro (def: [])
% diro         Directory which contains (or whose subdirectories contain)
%                  the SAC files of interest (def: $MERMAID/processed/*)
%                 
% Output:
% s            Full-path SAC file(s) names, either:
%                 A cell array if "singl" is empty (Ex. 1)
%                 A char array if "singl" is input (Ex. 2)
%
% * SAC files are output to the "processed" directory after running
% main.py, which was written by Sebastien Bonnieux and is the core of
% automaid:
%
% https://github.com/earthscopeoceans/automaid
%
% Ex1: (return all SAC files in all subdirs of /processed/)
%    s = FULLSAC([], fullfile(getenv('MERMAID'), 'processed'))
%
% Ex2: (return the complete path to a single SAC file)
%    s = FULLSAC('20180811T094852.09_5B6F01F6.MER.DET.WLT5.sac') 
%
% See also: mermaid_sacf.m
%
% Last modified in Ver. 2017a by jdsimon@princeton.edu, 01-Sep-2018.

% Default is to return all SAC filenames in $MERMAID/processed.
defval('singl', [])
defval('diro', fullfile(getenv('MERMAID'), 'processed'))

% Sanity.
assert(isempty(singl) || issac(singl), ['Input ''singl'' must be ' ...
                    'either a SAC filename or [].']);

if verLessThan('MATLAB','2017b')
    foldercheck = @isdir;
else
    foldercheck = @isfolder;
end
assert(foldercheck(diro), 'Input ''diro'' must be a directory (folder).')


%% Main
if isempty(singl)

    % Nab all SAC files (**/* means search all subfolders).
    d = dir(fullfile(diro, '**/*sac'));

    if ~isempty(d)
        s = fullfile({d.folder}, {d.name});
    else
        s = [];
        warning('No .sac files found in %s', diro)
    end

else

    % Nab a single SAC file.
    d = dir(fullfile(diro, sprintf('**/%s', strippath(strtrim(singl)))));

    if ~isempty(d)
        s = fullfile(d.folder, d.name);     
    else
        s = [];
        warning('%s was not found in %s or any of it''s subfolders.', ...
                singl, diro)
    end
    
end

    
