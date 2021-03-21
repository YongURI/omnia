function [s, dates] = bumps(plotit)
% [s, dates] = BUMPS(plotit)
%
% Returns a list of MERMAID glitches(?), and optionally plots their dates.
%
% Input:
% plotit   true to generate stem plot (def: false)
%
% Output:
% s        List of SAC filenames logged her
% dates    Datetime array corresponding to SAC file list
%
% Author: Joel D. Simon
% Contact: jdsimon@alumni.princeton.edu | joeldsimon@gmail.com
% Last modified: 20-Mar-2021, Version 9.3.0.948333 (R2017b) Update 9 on MACI64

defval('plotit', false)

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
     '20190713T022010.12_5D2ABA7E.MER.DET.WLT5.sac', ...
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
     '20190718T001013.12_5D31C6A6.MER.DET.WLT5.sac', ...
     '20190718T014213.12_5D31C6A6.MER.DET.WLT5.sac', ...
     '20190718T030300.12_5D31C6A6.MER.DET.WLT5.sac', ...
     '20190718T032615.12_5D35E242.MER.DET.WLT5.sac', ...
     '20190718T063535.12_5D31C6A6.MER.DET.WLT5.sac', ... % 1x10^9
     '20190718T081723.12_5D31C6A6.MER.DET.WLT5.sac', ...
     '20190718T082826.12_5D31C6A6.MER.DET.WLT5.sac', ...
     '20190718T161303.12_5D38E410.MER.DET.WLT5.sac', ...
     '20190718T170512.12_5D35E242.MER.DET.WLT5.sac', ...
     '20190718T173608.12_5D38E410.MER.DET.WLT5.sac', ... % Questionable
     '20190718T201520.12_5D35E242.MER.DET.WLT5.sac', ...
     '20190719T080409.12_5D35E242.MER.DET.WLT5.sac', ...
     '20190720T084114.12_5D35E242.MER.DET.WLT5.sac', ...
     '20190722T105427.12_5D35E242.MER.DET.WLT5.sac', ...
     '20190712T162741.13_5D3B0A8F.MER.DET.WLT5.sac', ...
     '20190712T164846.13_5D3F807D.MER.DET.WLT5.sac', ...
     '20190714T015745.13_5D37EF35.MER.DET.WLT5.sac', ...
     '20190714T031841.13_5D3B0A8F.MER.DET.WLT5.sac', ...
     '20190714T053137.13_5D3F807D.MER.DET.WLT5.sac', ...
     '20190714T053622.13_5D3B0A8F.MER.DET.WLT5.sac', ...
     '20190714T055852.13_5D37EF35.MER.DET.WLT5.sac', ...
     '20190714T062406.13_5D3F807D.MER.DET.WLT5.sac', ...
     '20190714T220627.13_5D37EF35.MER.DET.WLT5.sac', ...
     '20190716T072845.13_5D37EF35.MER.DET.WLT5.sac', ...
     '20190716T174647.13_5D3B0A8F.MER.DET.WLT5.sac', ...
     '20190716T210701.13_5D37EF35.MER.DET.WLT5.sac', ...
     '20190716T232737.13_5D3B0A8F.MER.DET.WLT5.sac', ...
     '20190717T012755.13_5D3F807D.MER.DET.WLT5.sac', ...
     '20190717T014611.13_5D3F807D.MER.DET.WLT5.sac', ...
     '20190726T130850.12_5D440502.MER.DET.WLT5.sac', ...
     '20190712T112447.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190712T160217.13_5D490D34.MER.DET.WLT5.sac', ...
     '20190712T171319.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190714T004102.13_5D759F18.MER.DET.WLT5.sac', ...
     '20190714T013854.13_5D543048.MER.DET.WLT5.sac', ...
     '20190714T033252.13_5D45CAAC.MER.DET.WLT5.sac', ...
     '20190714T035534.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190714T040922.13_5D428988.MER.DET.WLT5.sac', ...
     '20190714T050333.13_5D428988.MER.DET.WLT5.sac', ...
     '20190714T063032.13_5D490D34.MER.DET.WLT5.sac', ...
     '20190714T115721.13_5D45CAAC.MER.DET.WLT5.sac', ...
     '20190714T121020.13_5D428988.MER.DET.WLT5.sac', ...
     '20190714T130130.13_5D45CAAC.MER.DET.WLT5.sac', ...
     '20190714T131202.13_5D759F18.MER.DET.WLT5.sac', ...
     '20190714T132505.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190714T145418.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190714T160401.13_5D80C4B9.MER.DET.WLT5.sac', ...
     '20190714T162000.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190714T163429.13_5D80C4B9.MER.DET.WLT5.sac', ...
     '20190714T173340.13_5D490D34.MER.DET.WLT5.sac', ...
     '20190714T183700.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190714T183700.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190714T204300.13_5D759F18.MER.DET.WLT5.sac', ...
     '20190714T224407.13_5D543048.MER.DET.WLT5.sac', ...
     '20190714T225211.13_5D490D34.MER.DET.WLT5.sac', ...
     '20190714T233037.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190714T233037.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190715T000709.13_5D8BEFDC.MER.DET.WLT5.sac', ...
     '20190715T001912.13_5D80C4B9.MER.DET.WLT5.sac', ...
     '20190715T001912.13_5D80C4B9.MER.DET.WLT5.sac', ...
     '20190715T031731.13_5D759F18.MER.DET.WLT5.sac', ...
     '20190715T035007.13_5D8BEFDC.MER.DET.WLT5.sac', ...
     '20190715T040652.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190715T043645.13_5D759F18.MER.DET.WLT5.sac', ...
     '20190715T054758.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190715T054758.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190715T065407.13_5D543048.MER.DET.WLT5.sac', ...
     '20190716T063808.13_5D759F18.MER.DET.WLT5.sac', ...
     '20190716T080413.13_5D543048.MER.DET.WLT5.sac', ...
     '20190716T091514.13_5D80C4B9.MER.DET.WLT5.sac', ...
     '20190716T103738.13_5D8BEFDC.MER.DET.WLT5.sac', ...
     '20190716T120742.13_5D428988.MER.DET.WLT5.sac', ...
     '20190716T142819.13_5D45CAAC.MER.DET.WLT5.sac', ...
     '20190716T144428.13_5D8BEFDC.MER.DET.WLT5.sac', ...
     '20190716T180030.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190716T213919.13_5D543048.MER.DET.WLT5.sac', ...
     '20190716T233653.13_5D8BEFDC.MER.DET.WLT5.sac', ...
     '20190716T235701.13_5D428988.MER.DET.WLT5.sac', ...
     '20190717T005557.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190717T021157.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190717T021157.13_5D6A7BCE.MER.DET.WLT5.sac', ...
     '20190717T042854.13_5D80C4B9.MER.DET.WLT5.sac', ...
     '20190717T045954.13_5D80C4B9.MER.DET.WLT5.sac', ...
     '20190717T065424.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190718T143013.13_5D5F5436.MER.DET.WLT5.sac', ...
     '20190718T144849.13_5D543048.MER.DET.WLT5.sac', ...
     '20190718T144849.13_5D543048.MER.DET.WLT5.sac', ...
     '20190721T083446.20_5D348358.MER.DET.WLT5.sac', ...
     '20190721T093159.13_5D8BEFDC.MER.DET.WLT5.sac', ...
     '20190721T094321.20_5D348358.MER.DET.WLT5.sac', ...
     '20190724T080255.20_5D385E00.MER.DET.WLT5.sac', ...
     '20190725T043904.13_5D8BEFDC.MER.DET.WLT5.sac', ...
     '20190802T214140.20_5D44FC82.MER.DET.WLT5.sac', ...
     '20190804T112702.13_5D490D34.MER.DET.WLT5.sac', ...
     '20190804T114358.12_5D471241.MER.DET.WLT5.sac', ...
     '20190805T161857.13_5D8BEFDC.MER.DET.WLT5.sac', ... % First motion up
     '20190805T180526.12_5D51D0C8.MER.DET.WLT5.sac', ...
     '20190805T203836.12_5D4A6046.MER.DET.WLT5.sac', ...
     '20190805T205434.12_5D4A6046.MER.DET.WLT5.sac', ...
     '20190805T211631.12_5D4A6046.MER.DET.WLT5.sac', ...
     '20190806T060000.12_5D51D0C8.MER.DET.WLT5.sac', ...
     '20190806T060341.12_5D4A6046.MER.DET.WLT5.sac', ...
     '20190806T062746.12_5D4A6046.MER.DET.WLT5.sac', ...
     '20190807T001900.12_5D4A6046.MER.DET.WLT5.sac', ...
     '20190821T152910.20_5D5DB190.MER.DET.WLT5.sac', ...
     '20190831T064306.20_5D6A6062.MER.DET.WLT5.sac', ...
     '20190901T155959.20_5D6E43E4.MER.DET.WLT5.sac', ... % Includes ID
     '20190901T185006.20_5D6E43E4.MER.DET.WLT5.sac', ...
     '20190902T014350.20_5D6E43E4.MER.DET.WLT5.sac', ...
     '20190903T050421.20_5D6E43E4.MER.DET.WLT5.sac', ...
     '20190904T045943.20_5D71ECD7.MER.DET.WLT5.sac', ...
     '20190904T061653.20_5D71ECD7.MER.DET.WLT5.sac', ...
     '20190904T221203.20_5D71ECD7.MER.DET.WLT5.sac', ...
     '20190905T234556.20_5D71ECD7.MER.DET.WLT5.sac', ...
     '20190907T115938.12_5D73E860.MER.DET.WLT5.sac', ...
     '20190909T030326.12_5D7B6B28.MER.DET.WLT5.sac', ...
     '20190909T063344.12_5D7B6B28.MER.DET.WLT5.sac', ...
     '20190909T093226.12_5D7B6B28.MER.DET.WLT5.sac', ...
     '20190909T115410.12_5D7B6B28.MER.DET.WLT5.sac', ...
     '20190910T100856.20_5D77C388.MER.DET.WLT5.sac', ...
     '20190912T035349.20_5D82E392.MER.DET.WLT5.sac', ...
     '20190913T043350.12_5D7B6B28.MER.DET.WLT5.sac', ...
     '20190916T165645.12_5D800C46.MER.DET.WLT5.sac', ...
     '20190920T162835.20_5D864B34.MER.DET.WLT5.sac', ...
     '20190920T174822.20_5D864B34.MER.DET.WLT5.sac', ...
     '20190920T210609.12_5D85CC35.MER.DET.WLT5.sac', ...
     '20190921T012217.12_5D85CC35.MER.DET.WLT5.sac', ...
     '20190921T102202.20_5D864B34.MER.DET.WLT5.sac', ...
     '20190925T084458.12_5D8B7892.MER.DET.WLT5.sac', ...
     '20190927T170525.12_5D8E913A.MER.DET.WLT5.sac', ...
     '20190927T223044.08_5D8EDE2E.MER.DET.WLT5.sac', ...
     '20190922T135105.20_5D916CF2.MER.DET.WLT5.sac', ...
     '20190922T205039.20_5D916CF2.MER.DET.WLT5.sac', ...
     '20190923T014712.20_5D916CF2.MER.DET.WLT5.sac', ...
     '20190714T192809.13_5D971598.MER.DET.WLT5.sac', ...
     '20190714T194035.13_5D971598.MER.DET.WLT5.sac', ...
     '20190716T104750.13_5D971598.MER.DET.WLT5.sac', ...
     '20190717T071024.13_5D971598.MER.DET.WLT5.sac', ...
     '20190721T040830.13_5D971598.MER.DET.WLT5.sac', ...
     '20190721T061927.13_5D971598.MER.DET.WLT5.sac', ...
     '20190725T132122.13_5D971598.MER.DET.WLT5.sac', ...
     '20190930T025903.12_5D91BD56.MER.DET.WLT5.sac', ...
     '20190930T200453.20_5D9491FA.MER.DET.WLT5.sac', ... % Maybe very local?
     '20191001T013518.20_5D9491FA.MER.DET.WLT5.sac', ...
     '20191001T021345.20_5D9491FA.MER.DET.WLT5.sac', ...
     '20191001T030052.20_5D9491FA.MER.DET.WLT5.sac', ...
     '20191002T062451.20_5D9491FA.MER.DET.WLT5.sac', ... % First motion up
     '20190930T040502.08_5D9371A0.MER.DET.WLT5.sac', ... % First motion up
     '20191003T054955.20_5D9C0EDC.MER.DET.WLT5.sac', ... % First motion up
     '20191003T123650.20_5D9C0EDC.MER.DET.WLT5.sac', ... % First motion up
     '20191007T224903.20_5D9C0EDC.MER.DET.WLT5.sac', ... % First motion up
     '20190709T132743.13_5DA237B4.MER.DET.WLT5.sac', ... % Very noisy
     '20190716T065509.13_5DA237B4.MER.DET.WLT5.sac', ...
     '20190716T081551.13_5DA237B4.MER.DET.WLT5.sac', ...
     '20190716T142343.13_5DA237B4.MER.DET.WLT5.sac', ...
     '20190716T214531.13_5DA237B4.MER.DET.WLT5.sac', ...
     '20190717T024637.13_5DA237B4.MER.DET.WLT5.sac', ... % First motion up
     '20190717T065950.13_5DA237B4.MER.DET.WLT5.sac', ... % *1
     '20190725T113719.13_5DA237B4.MER.DET.WLT5.sac', ...
     '20191009T053046.20_5D9F3D8C.MER.DET.WLT5.sac', ...
     '20191010T085607.20_5D9F3D8C.MER.DET.WLT5.sac', ... % Archetypal
     '20191006T175336.12_5D9A772A.MER.DET.WLT5.sac', ...
     '20190709T123254.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190709T183003.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190709T192613.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190712T102105.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190715T073753.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190716T081042.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190716T191226.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190721T033726.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20190803T122704.13_5DAD5CD1.MER.DET.WLT5.sac', ...
     '20191011T073001.20_5DA23B0C.MER.DET.WLT5.sac', ...
     '20191011T214032.20_5DA23B0C.MER.DET.WLT5.sac', ...
     '20191012T061609.20_5DA23B0C.MER.DET.WLT5.sac', ...
     '20191012T074859.20_5DA23B0C.MER.DET.WLT5.sac', ...
     '20191012T101005.20_5DA23B0C.MER.DET.WLT5.sac', ...  % Unsure
     '20191012T152225.20_5DA23B0C.MER.DET.WLT5.sac', ...
     '20191014T211222.12_5DA532BE.MER.DET.WLT5.sac', ...
     '20191015T234638.12_5DABC2BD.MER.DET.WLT5.sac', ...
     '20191017T165630.20_5DA8ECCD.MER.DET.WLT5.sac', ...
     '20191019T204138.12_5DABC2BD.MER.DET.WLT5.sac', ...
     '20191020T201046.12_5DAEBFA0.MER.DET.WLT5.sac', ...
     '20191021T205822.12_5DAEBFA0.MER.DET.WLT5.sac', ... % First motion up
     '20191022T003539.12_5DAEBFA0.MER.DET.WLT5.sac', ...
     '20191022T011429.12_5DAEBFA0.MER.DET.WLT5.sac', ...
     '20191022T014716.12_5DAEBFA0.MER.DET.WLT5.sac', ...
     '20191022T030433.12_5DAEBFA0.MER.DET.WLT5.sac', ...
     '20191023T122953.12_5DB1CFFD.MER.DET.WLT5.sac', ...
     '20191023T225833.12_5DB1CFFD.MER.DET.WLT5.sac', ... % First motion up
     '20191023T231819.12_5DB1CFFD.MER.DET.WLT5.sac', ...
     '20191024T064906.12_5DB1CFFD.MER.DET.WLT5.sac', ...
     '20190709T204505.13_5DB88648.MER.DET.WLT5.sac', ...
     '20190712T172951.13_5DB88648.MER.DET.WLT5.sac', ...
     '20190714T052032.13_5DB88648.MER.DET.WLT5.sac', ...
     '20190715T072257.13_5DB88648.MER.DET.WLT5.sac', ...
     '20190716T092012.13_5DB88648.MER.DET.WLT5.sac', ...
     '20190717T015403.13_5DB88648.MER.DET.WLT5.sac', ...
     '20190729T175229.13_5DB88648.MER.DET.WLT5.sac', ... % Crazy
     '20190804T123613.13_5DB88648.MER.DET.WLT5.sac', ...
     '20191025T094437.12_5DB4C864.MER.DET.WLT5.sac', ...
     '20191025T094933.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191025T100016.12_5DB4C864.MER.DET.WLT5.sac', ... % *2
     '20191025T110719.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191025T113002.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191025T132303.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191025T133554.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191025T161057.12_5DB4C864.MER.DET.WLT5.sac', ...
     '20191025T165025.12_5DB4C864.MER.DET.WLT5.sac', ...
     '20191025T170329.12_5DB4C864.MER.DET.WLT5.sac', ... % *2
     '20191025T171117.12_5DB4C864.MER.DET.WLT5.sac', ... % *2
     '20191025T171741.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191026T113451.12_5DB4C864.MER.DET.WLT5.sac', ...
     '20191026T170004.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191018T223717.20_5DB00FD6.MER.DET.WLT5.sac', ...
     '20191018T225328.20_5DB00FD6.MER.DET.WLT5.sac', ...
     '20191019T013045.20_5DB00FD6.MER.DET.WLT5.sac', ...
     '20191019T013507.20_5DB00FD6.MER.DET.WLT5.sac', ... % Questionable (storm?)
     '20191019T014710.20_5DB00FD6.MER.DET.WLT5.sac', ...
     '20191023T030924.20_5DB00FD6.MER.DET.WLT5.sac', ... % *2
     '20191025T190550.12_5DBCEBDE.MER.DET.WLT5.sac', ...
     '20191025T223414.12_5DBCEBDE.MER.DET.WLT5.sac', ...
     '20191028T023332.12_5DBCEBDE.MER.DET.WLT5.sac', ...
     '20191028T172855.12_5DB8D5F8.MER.DET.WLT5.sac', ...
     '20191029T184635.12_5DBCEBDE.MER.DET.WLT5.sac', ...
     '20191105T104704.20_5DC59660.MER.DET.WLT5.sac', ...
     '20191105T063807.20_5DC59660.MER.DET.WLT5.sac', ...
     '20191105T062343.20_5DC59660.MER.DET.WLT5.sac', ...
     '20191104T044500.20_5DBFFA2A.MER.DET.WLT5.sac', ...
     '20191101T204800.12_5DBCEBDE.MER.DET.WLT5.sac', ...
     '20190802T130550.13_5DC3AC44.MER.DET.WLT5.sac', ...
     '20190728T081602.13_5DC3AC44.MER.DET.WLT5.sac', ...
     '20190724T230507.13_5DC3AC44.MER.DET.WLT5.sac', ...
     '20190717T023052.13_5DC3AC44.MER.DET.WLT5.sac', ...
     '20190716T124332.13_5DC3AC44.MER.DET.WLT5.sac', ... % Intense
     '20190715T001437.13_5DC3AC44.MER.DET.WLT5.sac', ... % Great; periodic
     '20190714T174207.13_5DC3AC44.MER.DET.WLT5.sac', ...
     '20190714T005125.13_5DC3AC44.MER.DET.WLT5.sac', ...
     '20191117T211738.20_5DD20710.MER.DET.WLT5.sac', ...
     '20191116T000339.20_5DD20710.MER.DET.WLT5.sac', ...
     '20191115T054423.20_5DD20710.MER.DET.WLT5.sac', ...
     '20191115T053038.20_5DD20710.MER.DET.WLT5.sac', ...
     '20191114T014950.20_5DCD002C.MER.DET.WLT5.sac', ...
     '20191109T142457.20_5DCD002C.MER.DET.WLT5.sac', ...
     '20191109T141912.20_5DCD002C.MER.DET.WLT5.sac', ...
     '20191109T140723.20_5DCD002C.MER.DET.WLT5.sac', ...
     '20190805T235107.13_5DD9FB84.MER.DET.WLT5.sac', ...
     '20190805T144439.13_5DD9FB84.MER.DET.WLT5.sac', ...
     '20190801T005432.13_5DCED564.MER.DET.WLT5.sac', ...
     '20190731T233708.13_5DCED564.MER.DET.WLT5.sac', ...
     '20190727T153808.13_5DD9FB84.MER.DET.WLT5.sac', ...
     '20190725T150011.13_5DD9FB84.MER.DET.WLT5.sac', ... % First motion up
     '20190718T141537.13_5DCED564.MER.DET.WLT5.sac', ...
     '20190717T061913.13_5DCED564.MER.DET.WLT5.sac', ... % First motion up
     '20190717T024233.13_5DD9FB84.MER.DET.WLT5.sac', ...
     '20190717T014124.13_5DD9FB84.MER.DET.WLT5.sac', ...
     '20190716T192013.13_5DCED564.MER.DET.WLT5.sac', ...
     '20190716T095937.13_5DCED564.MER.DET.WLT5.sac', ...
     '20190715T045353.13_5DCED564.MER.DET.WLT5.sac', ...
     '20190712T170615.13_5DD9FB84.MER.DET.WLT5.sac', ... % First motion up?
     '20190710T081746.13_5DCED564.MER.DET.WLT5.sac', ... % First motion up
     '20190709T184412.13_5DD9FB84.MER.DET.WLT5.sac', ...
     '20191122T151249.12_5DD84992.MER.DET.WLT5.sac', ...
     '20190805T082505.13_5DE51EEC.MER.DET.WLT5.sac', ...
     '20190805T065754.13_5DE51EEC.MER.DET.WLT5.sac', ...
     '20190805T061705.13_5DE51EEC.MER.DET.WLT5.sac', ...
     '20190720T223432.13_5DE51EEC.MER.DET.WLT5.sac', ...
     '20190718T142246.13_5DE51EEC.MER.DET.WLT5.sac', ...
     '20190717T002329.13_5DE51EEC.MER.DET.WLT5.sac', ...
     '20190715T050514.13_5DE51EEC.MER.DET.WLT5.sac', ... % First motion up
     '20190709T215321.13_5DE51EEC.MER.DET.WLT5.sac', ...
     '20191202T133315.12_5DE861E2.MER.DET.WLT5.sac', ...
     '20191130T120904.12_5DE2A9F4.MER.DET.WLT5.sac', ...
     '20190716T075146.13_5DF0483E.MER.DET.WLT5.sac', ...
     '20190715T050123.13_5DF0483E.MER.DET.WLT5.sac', ...
     '20190709T201155.13_5DF0483E.MER.DET.WLT5.sac', ...
     '20191223T164150.12_5E030266.MER.DET.WLT5.sac', ...
     '20200107T011611.12_5E143E16.MER.DET.WLT5.sac', ...
     '20200106T113651.12_5E143E16.MER.DET.WLT5.sac', ...
     '20200106T112521.12_5E143E16.MER.DET.WLT5.sac', ...
     '20200106T111829.12_5E143E16.MER.DET.WLT5.sac', ...
     '20200106T030213.12_5E143E16.MER.DET.WLT5.sac', ...
     '20200105T142624.12_5E143E16.MER.DET.WLT5.sac', ...
     '20200111T195241.12_5E1A8CB2.MER.DET.WLT5.sac', ...
     '20200206T060320.23_5E3FC2C0.MER.DET.WLT5.sac', ... % All motions up; odd
     '20201003T185233.16_5F78E771.MER.DET.WLT5.sac', ...
     '20190618T163156.12_5D096135.MER.DET.WLT5.sac', ...
     '20190616T154216.12_5D096135.MER.DET.WLT5.sac', ... % First motion up
     '20201028T143154.24_5F99EC4A.MER.DET.WLT5.sac', ...
     '20201108T211831.21_5FA8992E.MER.DET.WLT5.sac', ... % I'm unsure...
     '20201129T015326.21_5FC33604.MER.DET.WLT5.sac', ... % I'm unsure...
     '20201201T120602.21_5FC66796.MER.DET.WLT5.sac', ... % I'm unsure...
     '20201225T061535.21_5FE5BC2E.MER.DET.WLT5.sac', ... % I'm unsure...
     '20201228T233832.24_5FEABC56.MER.DET.WLT5.sac', ... % I'm unsure...
     '20201230T001646.21_5FEFE5BE.MER.DET.WLT5.sac', ... % I'm unsure...
     '20210101T231641.21_5FEFE5BE.MER.DET.WLT5.sac', ... % I'm unsure...
     '20210102T195635.21_5FF50DA0.MER.DET.WLT5.sac', ... % I'm unsure...
     '20210102T205146.21_5FF50DA0.MER.DET.WLT5.sac', ... % I'm unsure...
     '20210102T232233.21_5FF50DA0.MER.DET.WLT5.sac', ... % I'm unsure...
     '20210105T200616.24_5FF6611E.MER.DET.WLT5.sac', ...
     '20210105T200616.24_5FF6611E.MER.DET.WLT5.sac', ... % I'm unsure...
     '20210107T031228.21_60008B80.MER.DET.WLT5.sac', ... % *
     '20210121T183523.19_6009E7DE.MER.DET.WLT5.sac', ...
     '20210124T081551.21_6014442C.MER.DET.WLT5.sac', ...
     '20210125T064453.21_6014442C.MER.DET.WLT5.sac', ...
     '20210125T072346.21_6014442C.MER.DET.WLT5.sac', ...
     '20210127T213308.19_6011FBFE.MER.DET.WLT5.sac', ...
     '20210130T142919.21_601A65F8.MER.DET.WLT5.sac', ... % Warrants further inspection (all P-21 from this time period, I didn't list 2 or 3 here...)
     '20210130T174922.21_601A65F8.MER.DET.WLT5.sac', ...
     '20210208T050341.23_60211692.MER.DET.WLT5.sac', ... % First motion up
     '20210211T122152.22_602FA41A.MER.DET.WLT5.sac', ...
     '20210212T092655.23_602831FF.MER.DET.WLT5.sac', ... % Quite odd
     '20210215T221315.24_602B40A1.MER.DET.WLT5.sac', ...
     '20210217T190223.21_602DA1E2.MER.DET.WLT5.sac', ...
     '20210218T231046.23_6034498E.MER.DET.WLT5.sac', ... % Odd / unsure
     '20210218T235513.23_6034498E.MER.DET.WLT5.sac', ...
     '20210227T144122.24_603AAA30.MER.DET.WLT5.sac', ...
     '20210224T070933.23_603AE7BC.MER.DET.WLT5.prelim.sac', ...
     '20210224T074350.23_603AE7BC.MER.DET.WLT5.prelim.sac', ...
     '20210224T082744.23_603AE7BC.MER.DET.WLT5.prelim.sac', ...
     '20210228T202117.24_603E8A28.MER.DET.WLT5.prelim.sac', ...
     '20210228T204107.24_603E8A28.MER.DET.WLT5.prelim.sac', ...
     '20210228T220148.24_603E8A28.MER.DET.WLT5.prelim.sac', ...
     '20210301T090431.24_603E8A28.MER.DET.WLT5.prelim.sac', ...
     '20210224T070933.23_603AE7BC.MER.DET.WLT5.sac', ...
     '20210224T074350.23_603AE7BC.MER.DET.WLT5.sac', ...
     '20210224T074350.23_603AE7BC.MER.DET.WLT5.sac', ...
     '20210228T202117.24_603E8A28.MER.DET.WLT5.sac', ... % Real event?
     '20210228T204107.24_603E8A28.MER.DET.WLT5.sac', ...
     '20210228T220148.24_603E8A28.MER.DET.WLT5.sac', ...
     '20210301T090431.24_603E8A28.MER.DET.WLT5.sac', ...
    };

s = unique(s);
s = sort(s);
s = s(:);

% * I stopped writing "I'm unsure" because that is true for basically all
% signals here

dates = cellfun(@(xx) datetime(xx(1:8), 'InputFormat', 'uuuuMMdd', 'TimeZone', 'UTC'), s, 'UniformOutput', true);
floats = cellfun(@(xx) str2num(xx(17:18)), s, 'UniformOutput', true);
floatnum = unique(floats);

if plotit
    figure
    ha = krijetem(subnum(length(floatnum), 1));
    shrink(ha, 1, 1.5)
    hold(gca, 'on')
    for i = 1:length(floatnum)
        idx = find(floats == floatnum(i));
        axes(ha(i))
        stem(dates(idx), ones(length(dates(idx))));
        box(ha(i), 'on')
        ha(i).XLim = [min(dates) max(dates)];
        ha(i).YLim = [0 1.5];
        ha(i).Title.String = sprintf('MERMAID %i, n = %i', floatnum(i), length(idx));
        ha(i).YTick = [];

    end
    xticklabels(ha(1:end-1), [])
    fig2print(gcf, 'flandscape')
    longticks(ha, 4);
    latimes
    axesfs([], 10, 10)
    savepdf('bumps')

    filename = 'bumps.txt';
    fid = fopen(filename, 'w');
    fprintf(fid, '%s\n', s{:});
    fprintf('Wrote: %s\n', filename)
    fclose(fid);
end

%______________________________________________________________________________%

% *1 Beautifully shows deflection of MERMAID up/down, with final slow
% and controlled return to mean (from high pressure, i.e., rising back
% to 1500 m after being pushed down, on the order of 3e7 counts, or
% ~1.75 cm).
%
% *2 Shows fast (step discontinuity) deflection up (pressure does
% down) and slower return to cruising depth.
