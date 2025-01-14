function varargout = readfirstarrivalpressure(filename)
% [s, ph, RMS, P, magval, magtype, depth, dist, merlat, merlon, ...
%     evtlat, evtlon, ID, winflag, tapflag, zerflag] = READFIRSTARRIVALPRESSURE(filename)
%
% Reads and parses textfile output by writefirstarrivalpressure.m.
% See there for I/0.
%
% Author: Joel D. Simon
% Contact: jdsimon@alumni.princeton.edu | joeldsimon@gmail.com
% Last modified: 10-Dec-2021, Version 9.3.0.948333 (R2017b) Update 9 on MACI64

% Default.
defval('filename', fullfile(getenv('MERMAID'), 'events', 'reviewed', ...
                            'identified', 'txt', 'firstarrivalpressure.txt'))
% Textfile format.
fmt = ['%44s    ' , ...
       '%11s    ' ,  ...
       '%18.12f    ' , ...
       '%6.2f   ' ,  ...
       '%4.1f    ',  ...
       '%5s    ',    ...
       '%6.2f    ',  ...
       '%7.3f    ' , ...
       '%7.3f    ' , ...
       '%8.3f    ' , ...
       '%7.3f    ' , ...
       '%8.3f    ' , ...
       '%8s   ',     ...
       '%u    ', ...
       '%3s    ', ...
       '%u\n'];

% Read.
fid = fopen(filename, 'r');
lynes = textscan(fid, fmt);
fclose(fid);

% Parse.
s = strtrim(lynes{1});
ph = lynes{2};
RMS = lynes{3};
P = lynes{4};
magval = lynes{5};
magtype = lynes{6};
depth = lynes{7};
dist = lynes{8};
merlat = lynes{9};
merlon = lynes{10};
evtlat = lynes{11};
evtlon = lynes{12};
ID = lynes{13};
winflag = double(lynes{14});
tapflag = str2double(lynes{15});
zerflag = double(lynes{16});

% Collect.
outargs = {s, ph, RMS, P, magval, magtype, depth, dist, merlat, ...
           merlon, evtlat, evtlon, ID, winflag, tapflag, zerflag};
varargout = outargs(1:nargout);
