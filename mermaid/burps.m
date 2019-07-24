% A list of mysterious MERMAID signals.
%
% Author: Joel D. Simon
% Contact: jdsimon@princeton.edu
% Last modified: 16-Jul-2019, Version 2017b

clear 
close all

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
     '20190512T001016.12_5CD7B492.MER.DET.WLT5.sac', ...
     '20190509T075857.12_5CE1A758.MER.DET.WLT5.sac', ...
     '20190505T223233.12_5CE1A758.MER.DET.WLT5.sac', ...
     '20190511T234031.12_5CE52F28.MER.DET.WLT5.sac', ...
     '20190513T044527.12_5CE1A758.MER.DET.WLT5.sac', ...
     '20190513T115150.12_5CDB0DEA.MER.DET.WLT5.sac', ... % First motion up
     '20190515T141507.12_5CDE37AA.MER.DET.WLT5.sac', ...
     '20190515T142013.12_5CE52F28.MER.DET.WLT5.sac', ...
     '20190515T143757.12_5CDE37AA.MER.DET.WLT5.sac', ...
     '20190515T160840.12_5CE52F28.MER.DET.WLT5.sac', ...
     '20190515T221122.12_5CDE37AA.MER.DET.WLT5.sac', ...
     '20190515T223941.12_5CDE37AA.MER.DET.WLT5.sac', ...
     '20190515T224704.12_5CE52F28.MER.DET.WLT5.sac', ...
     '20190516T065707.12_5CE1A758.MER.DET.WLT5.sac', ...
     '20190516T082322.12_5CDE37AA.MER.DET.WLT5.sac', ...
     '20190516T095202.12_5CE1A758.MER.DET.WLT5.sac', ...
     '20190516T225716.12_5CDE37AA.MER.DET.WLT5.sac', ...
     '20190517T225439.12_5CE52F28.MER.DET.WLT5.sac', ...
     '20190518T040717.12_5CE52F28.MER.DET.WLT5.sac', ...
     '20190518T065102.12_5CE1A758.MER.DET.WLT5.sac', ...
     '20190509T124554.12_5CEA92CE.MER.DET.WLT5.sac', ...
     '20190511T032627.12_5CEA92CE.MER.DET.WLT5.sac', ...
     '20190517T230411.12_5CEA92CE.MER.DET.WLT5.sac', ...
     '20190519T130545.12_5CEA92CE.MER.DET.WLT5.sac', ...
     '20190522T054016.12_5CEA92CE.MER.DET.WLT5.sac', ...
     '20190516T174010.13_5CDF255D.MER.DET.WLT5.sac', ...
     '20190517T154702.13_5CDF255D.MER.DET.WLT5.sac', ...
     '20190521T224107.20_5CE4CB94.MER.DET.WLT5.sac', ...
     '20190507T074508.12_5CEF72F8.MER.DET.WLT5.sac', ...
     '20190508T104721.12_5CEF72F8.MER.DET.WLT5.sac', ...
     '20190509T114646.12_5CEF72F8.MER.DET.WLT5.sac', ...
     '20190511T214302.12_5CEF72F8.MER.DET.WLT5.sac', ...
     '20190515T140833.12_5CEF72F8.MER.DET.WLT5.sac', ...
     '20190517T235848.12_5CEF72F8.MER.DET.WLT5.sac', ...
     '20190526T020815.13_5CEA4559.MER.DET.WLT5.sac', ...
     '20180821T032801.07_5B8DE043.MER.DET.WLT5.sac', ... % Includes positive ID
     '20190506T054711.12_5CF48676.MER.DET.WLT5.sac', ...
     '20190506T181033.12_5CF48676.MER.DET.WLT5.sac', ...
     '20190509T052814.12_5CF48676.MER.DET.WLT5.sac', ... % First motion up
     '20190511T041759.12_5CF48676.MER.DET.WLT5.sac', ...
     '20190516T062518.12_5CF48676.MER.DET.WLT5.sac', ... % Ambiguous; might be event?
     '20190523T181053.20_5CEA9555.MER.DET.WLT5.sac', ...
     '20190602T205647.12_5CF48676.MER.DET.WLT5.sac', ...
     '20190427T141244.20_5CC800B0.MER.DET.WLT5.sac', ...
     '20190511T202305.12_5D035757.MER.DET.WLT5.sac', ...
     '20190530T003901.12_5D035757.MER.DET.WLT5.sac', ...
     '20190603T213531.12_5D030CEE.MER.DET.WLT5.sac', ...
     '20190604T002535.12_5CF7EB2C.MER.DET.WLT5.sac', ...
     '20190604T005859.12_5D030CEE.MER.DET.WLT5.sac', ...
     '20190604T010515.12_5CF7EB2C.MER.DET.WLT5.sac', ...
     '20190604T011118.12_5D030CEE.MER.DET.WLT5.sac', ...
     '20190604T153956.12_5D030CEE.MER.DET.WLT5.sac', ...
     '20190604T173734.12_5CF7EB2C.MER.DET.WLT5.sac', ...
     '20190604T200623.12_5CF7EB2C.MER.DET.WLT5.sac', ...
     '20190605T104134.12_5CF7EB2C.MER.DET.WLT5.sac', ...
     '20190607T045628.12_5D030CEE.MER.DET.WLT5.sac', ...
     '20190607T050956.12_5D030CEE.MER.DET.WLT5.sac', ...
     '20190622T123121.12_5D1089F0.MER.DET.WLT5.sac', ...
     '20190623T061422.12_5D1089F0.MER.DET.WLT5.sac', ...
     '20190623T123421.12_5D1089F0.MER.DET.WLT5.sac', ...
     '20190622T143200.13_5D108BFA.MER.DET.WLT5.sac', ...
     '20190622T152135.13_5D108BFA.MER.DET.WLT5.sac', ...
     '20190623T102111.13_5D108BFA.MER.DET.WLT5.sac', ...
     '20190623T174345.13_5D108BFA.MER.DET.WLT5.sac', ...
     '20190624T030416.13_5D108BFA.MER.DET.WLT5.sac', ...
     '20190622T130604.23_5D185934.MER.DET.WLT5.sac', ...
     '20190625T042625.12_5D20239E.MER.DET.WLT5.sac', ...
     '20190625T045902.12_5D13CB8A.MER.DET.WLT5.sac', ...
     '20190625T091227.12_5D13CB8A.MER.DET.WLT5.sac', ...
     '20190625T213323.12_5D13CB8A.MER.DET.WLT5.sac', ...
     '20190625T220453.12_5D13CB8A.MER.DET.WLT5.sac', ...
     '20190625T222853.12_5D13CB8A.MER.DET.WLT5.sac', ...
     '20190626T042819.12_5D20239E.MER.DET.WLT5.sac', ...
     '20190626T141931.12_5D13CB8A.MER.DET.WLT5.sac', ...
     '20190627T142327.12_5D1BFCC2.MER.DET.WLT5.sac', ...
     '20190627T195023.12_5D1BFCC2.MER.DET.WLT5.sac', ...
     '20190627T204831.12_5D1804FA.MER.DET.WLT5.sac', ...
     '20190627T205314.12_5D1804FA.MER.DET.WLT5.sac', ...
     '20190627T211435.12_5D1804FA.MER.DET.WLT5.sac', ...
     '20190627T231850.12_5D1BFCC2.MER.DET.WLT5.sac', ...
     '20190627T233524.12_5D1804FA.MER.DET.WLT5.sac', ...
     '20190628T013016.12_5D1BFCC2.MER.DET.WLT5.sac', ...
     '20190628T091519.12_5D1804FA.MER.DET.WLT5.sac', ...
     '20190628T102701.12_5D1BFCC2.MER.DET.WLT5.sac', ...
     '20190628T140034.13_5D166BF0.MER.DET.WLT5.sac', ...
     '20190629T191138.12_5D1804FA.MER.DET.WLT5.sac', ...
     '20190630T014059.13_5D1A8F56.MER.DET.WLT5.sac', ...
     '20190702T192737.12_5D1BFCC2.MER.DET.WLT5.sac', ...
     '20190705T230107.12_5D20239E.MER.DET.WLT5.sac', ...
     '20190708T031200.20_5D230275.MER.DET.WLT5.sac', ... % Broad positive anomaly
     '20190708T035244.13_5D2379CC.MER.DET.WLT5.sac', ...
     '20190708T051252.13_5D2379CC.MER.DET.WLT5.sac', ... % First motion up
     '20190708T094343.12_5D235E5A.MER.DET.WLT5.sac', ...
     '20190708T114327.13_5D2379CC.MER.DET.WLT5.sac', ...
     '20190709T162002.12_5D27BD60.MER.DET.WLT5.sac', ...
     '20190709T192156.13_5D267CC6.MER.DET.WLT5.sac', ...
     '20190709T200234.13_5D267CC6.MER.DET.WLT5.sac', ...
     '20190710T064246.13_5D267CC6.MER.DET.WLT5.sac', ...
     '20190710T140851.13_5D267CC6.MER.DET.WLT5.sac', ... % First motion up
     '20190710T141920.13_5D267CC6.MER.DET.WLT5.sac', ...
     '20190710T183416.13_5D267CC6.MER.DET.WLT5.sac', ...
     '20190712T135337.13_5D2982C6.MER.DET.WLT5.sac', ...
     '20190712T160631.13_5D2982C6.MER.DET.WLT5.sac', ...
     '20190712T190227.13_5D2982C6.MER.DET.WLT5.sac', ...
     '20190712T211900.13_5D2982C6.MER.DET.WLT5.sac', ...
     '20190713T013821.13_5D2982C6.MER.DET.WLT5.sac', ...
     '20190710T154147.20_5D2655AB.MER.DET.WLT5.sac', ...
     '20190713T022010.12_5D2ABA7E.MER.DET.WLT5.sac' ,...
     '20190713T233702.12_5D2ABA7E.MER.DET.WLT5.sac', ...
     '20190714T013216.13_5D2C7E0A.MER.DET.WLT5.sac', ...
     '20190714T045936.13_5D2C7E0A.MER.DET.WLT5.sac', ...
     '20190714T060302.13_5D2C7E0A.MER.DET.WLT5.sac', ...
     '20190714T061036.13_5D2C7E0A.MER.DET.WLT5.sac', ...
     '20190714T121726.13_5D2C7E0A.MER.DET.WLT5.sac', ...
     '20190714T122537.13_5D2C7E0A.MER.DET.WLT5.sac', ...
     '20190715T014825.12_5D2EBCB4.MER.DET.WLT5.sac', ...
     '20190715T191421.12_5D2EBCB4.MER.DET.WLT5.sac', ...
     '20190715T224146.12_5D2EBCB4.MER.DET.WLT5.sac', ...
     '20190717T004052.12_5D2EBCB4.MER.DET.WLT5.sac', ...
     '20190711T152538.20_5D2F100C.MER.DET.WLT5.sac', ...
     '20190714T014308.13_5D328998.MER.DET.WLT5.sac', ...
     '20190716T123357.13_5D328998.MER.DET.WLT5.sac', ...
     '20190716T145426.13_5D2F8B3E.MER.DET.WLT5.sac', ...
     '20190716T152345.13_5D328998.MER.DET.WLT5.sac', ...
     '20190716T153259.13_5D328998.MER.DET.WLT5.sac', ...
     '20190716T190136.13_5D2F8B3E.MER.DET.WLT5.sac', ...
     '20190716T212025.13_5D328998.MER.DET.WLT5.sac', ...
     '20190716T213107.13_5D2F8B3E.MER.DET.WLT5.sac', ...
     '20190717T003649.13_5D2F8B3E.MER.DET.WLT5.sac', ...
     '20190717T055115.13_5D2F8B3E.MER.DET.WLT5.sac', ...
     '20190717T063908.20_5D2F100C.MER.DET.WLT5.sac', ...
};

s = unique(s);
s = sort(s);

return

fid = fopen('burps.txt', 'w');
fprintf(fid, '%s\n', s{:});
fclose(fid);
