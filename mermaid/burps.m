% Compiles a list of instrument burps for monitoring purposes.
%
% Author: Joel D. Simon
% Contact: jdsimon@princeton.edu
% Last modified: 14-May-2019, Version 2017b

s = {'20181231T114420.20_5C2A50AD.MER.DET.WLT5.sac', ...
     '20190126T130957.20_5C4CA6CB.MER.DET.WLT5.sac', ...
     '20190128T150507.20_5C54C1B7.MER.DET.WLT5.sac', ...
     '20190208T164850.20_5C5E0156.MER.DET.WLT5.sac', ...
     '20190212T022647.20_5C627CD6.MER.DET.WLT5.sac', ...
     '20190330T015437.13_5C9F1768.MER.DET.WLT5.sac', ...
     '20190419T070307.20_5CC36E5E.MER.DET.WLT5.sac', ...
     '20190419T091818.20_5CC36E5E.MER.DET.WLT5.sac', ...
     '20190419T125353.20_5CC36E5E.MER.DET.WLT5.sac', ...
     '20190428T203950.20_5CC800B0.MER.DET.WLT5.sac', ...
     '20190429T024314.13_5CC6B278.MER.DET.WLT5.sac', ...
     '20190430T022143.20_5CC800B0.MER.DET.WLT5.sac', ...
     '20190503T004418.12_5CCE4325.MER.DET.WLT5.sac', ...
     '20190503T025246.12_5CCE4325.MER.DET.WLT5.sac', ...
     '20190503T102300.12_5CCE4325.MER.DET.WLT5.sac', ...
     '20190504T202757.12_5CCE4325.MER.DET.WLT5.sac', ...
     '20190505T202642.12_5CD1866C.MER.DET.WLT5.sac', ...
     '20190506T050846.12_5CD1866C.MER.DET.WLT5.sac', ...
     '20190506T064332.12_5CD1866C.MER.DET.WLT5.sac', ...
     '20190506T123209.12_5CD1866C.MER.DET.WLT5.sac', ...
     '20190506T162326.12_5CD1866C.MER.DET.WLT5.sac', ...
     '20190509T025243.12_5CD7B492.MER.DET.WLT5.sac', ...
     '20190509T041337.12_5CD4BC52.MER.DET.WLT5.sac', ...
     '20190509T041800.12_5CD4BC52.MER.DET.WLT5.sac', ...
     '20190509T050612.12_5CD4BC52.MER.DET.WLT5.sac', ...
     '20190509T051020.12_5CD4BC52.MER.DET.WLT5.sac', ...
     '20190509T051451.12_5CDB0DEA.MER.DET.WLT5.sac', ...
     '20190509T074458.12_5CD4BC52.MER.DET.WLT5.sac', ...
     '20190509T131808.12_5CDB0DEA.MER.DET.WLT5.sac', ...
     '20190509T133655.12_5CD4BC52.MER.DET.WLT5.sac', ...
     '20190509T180830.12_5CDB0DEA.MER.DET.WLT5.sac', ...
     '20190511T161029.12_5CD7B492.MER.DET.WLT5.sac', ...
     '20190511T184818.12_5CDB0DEA.MER.DET.WLT5.sac', ...
     '20190511T194750.12_5CD7B492.MER.DET.WLT5.sac', ...
     '20190511T225143.12_5CD7B492.MER.DET.WLT5.sac', ...
     '20190512T001016.12_5CD7B492.MER.DET.WLT5.sac'};

s = unique(s);
s = sort(s);
fid = fopen('burps.txt', 'w');
fprintf(fid, '%s\n', s{:});
fclose(fid);
