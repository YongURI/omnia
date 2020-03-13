% STARTUP ---> executes at launch
%
% Joel D. Simon's startup parameters.  In order for MATLAB to execute
% this file at launch you must place it MATLAB's native search path.
% This may be found with the command "userpath".  For me:
%
% '/home/jdsimon/Documents/MATLAB'
%
% Being that I want to push this online and keep it under git vc I
% have placed the original STARTUP file in $OMNIA/omnealiud, and
% symlinked a version to the above path (assuming $OMNIA is set, see
% below):
%
% ln -s $OMNIA/omnealiud/startup.m $HOME/Documents/MATLAB/startup.m
%
% Alternatively, one may simply move this file to the latter path.
%
%_____________________________________________________________%
%
% STARTUP requires the environmental variables OMNIA and IRISFETCH to
% be defined in your preferred shell's config file:
%
% with "export" for bash-like (bash, sh, zsh), -or-
% with "setenv" in csh-like (csh, tsch).
%
% For me:
% export OMNIA=$HOME/github/omnia
% export IRISFETCH=$HOME/github/irisFetch-matlab
%
% Assumes MATLAB is subsequently launched in said shell, such that
% these environmental variables are then known to MATLAB.
%
% See also: userpath.m
%
% Author: Joel D. Simon
% Contact: jdsimon@princeton.edu
% Last modified: 13-Mar-2020, Version 2017b on MACI64

% For my code, and code my code requires.
addpath(genpath(getenv('OMNIA')))

% Remove the paper-specific path, with generic "fig*.m" names.
rmpath(genpath(fullfile(getenv('OMNIA'), 'BSSA2020')))

% For MatTaup.
javaaddpath(fullfile(getenv('OMNIA'), 'notmycode', 'MatTaup', 'lib', ...
                     'matTaup.jar'))

% For irisFetch-Matlab.
addpath(genpath(getenv('IRISFETCH')))
javaaddpath(fullfile(getenv('IRISFETCH'), 'IRIS-WS-2.0.18.jar'))

%________________________________________________________________%
% Any others, specific to JDS.
