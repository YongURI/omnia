function A0 = plot_transfer_function(sensortype, sensitivity_frequency, plt)
% A0 = PLOT_TRANSFER_FUNCTION(sensortype, sensitivity_frequency, plt)
%
% Makes a transfer function plot.
%
% Note: no gain is applied.
%
% Input:
% sensortype             E.g., 'PAEv' from Reseay Sismique Polynesien (velocity)
% sensitivity_frequency  Sensitivity frequency in RESP file in Hz
% plt                    true to plot (def: true)
%
% Output:
% A0                     A0 normalization factor in RESP file
%
% NB, from "IRIS: the RESP Format" at https://ds.iris.edu/ds/nodes/dmc/data/formats/resp/
%          A0_disp = A0_vel / (2 * pi * sensitivity_frequency)
%
% And to convert between a velocity (M/S) pole-zero to a displacement
% (M) or, acceleration to velocity, just add an extra set of zeros.
% In the examples below PAE and AFI poles and zeros were both supplied
% to me in VELOCITY (the former, in an email from Olivier Hyvernaud,
% the latter in a RESP file), and to convert them to displacement I
% simply added one extra zero, here.
%
% The pole-zero CONSTANT going from M/S to M is unchanged due to the
% cancellation of 2*pi factor in the math. See the webpage above.
%
% Ex1:
%    figure
%    A0v = PLOT_TRANSFER_FUNCTION('PAEv', 1)
%    figure
%    A0d = PLOT_TRANSFER_FUNCTION('PAEd', 1)
%    A0d - (A0v/(2*pi*1))
%
% E2: see AFI.resp in $MERMAID/events/nearbystations/pz/examples/RESP_example/
%    figure
%    A0v = PLOT_TRANSFER_FUNCTION('AFIv', 0.02)
%    figure
%    A0d = PLOT_TRANSFER_FUNCTION('AFId', 0.02)
%    A0d - (A0v/(2*pi*0.02))
%
% Written by Umair bin Waheed after information from GEOBit
% Last modified by fjsimons-at-alum.mit.edu on 02/04/2020
% Last modified by jdsimon@princeton.edu, 21-Feb-2020

defval('sensitivity_frequency', 1)
defval('plt', true)

% Set the gain to 1 s.t. the NORMALIZATION FACTOR (A0) may be found as
% the inverse
K = 1;

switch sensortype
  case 'RESPv' % Velocity
    Z = [0+0i ...
         0+0i];
    P = [-1.234000E-02+1.234000E-02i ...
         -1.234000E-02-1.234000E-02i ...
         -3.918000E+01+4.912000E+01i ...
         -3.918000E+01-4.912000E+01i];
    stype='Velocity';

  case 'RESPd' % Displacement
    Z = [0+0i ...
         0+0i ... % extra zero
         0+0i];
    P = [-1.234000E-02+1.234000E-02i ...
         -1.234000E-02-1.234000E-02i ...
         -3.918000E+01+4.912000E+01i ...
         -3.918000E+01-4.912000E+01i];
    stype='Displacement';

  case {'PAEv','TVOv','PMORv','VAHv','TBIv','RKTv'} % Velocity
    Z=[0+0i...
       0+0i];
    P=[-4.44-4.44i ...
       -4.44+4.44i];
    stype='Velocity';

  case {'PAEd','TVOd','PMORd','VAHd','TBId','RKTd'} % Displacement
    Z=[0+0i ...
       0+0i ... % extra zero
       0+0i];
    P=[-4.44-4.44i ...
       -4.44+4.44i];
    stype='Displacement';

  case 'PPTF'
    Z = [0+0i ...
         0+0i ...
         0+0i];
    P =  [-1.229700e-02+1.206000e-02i ...
          -1.229700e-02-1.206000e-02i ...
          -3.190240e+01+6.878330e+01i ...
          -3.190240e+01-6.878330e+01i];
    stype = 'Displacement'

  case 'AFIv' % Velocity
    Z = [+0.00000E+00+0.00000E+00i ...
         +0.00000E+00+0.00000E+00i ...
         -9.42478E+00+0.00000E+00i ...
         -6.28319E+02+0.00000E+00i ...
         -5.65487E+02-9.79452E+02i ...
         -5.65487E+02+9.79452E+02i];
    P = [-3.72833E-02-3.67000E-02i ...
         -3.72833E-02+3.67000E-02i ...
         -9.73894E+00+0.00000E+00i ...
         -2.19911E+02-1.38230E+02i ...
         -2.19911E+02+1.38230E+02i ...
         -2.19911E+02-6.84867E+02i ...
         -2.19911E+02+6.84867E+02i];
    stype = 'Velocity';

  case 'AFId' % Displacement
    Z = [+0.00000E+00+0.00000E+00i ...
         +0.00000E+00+0.00000E+00i ...
         +0.00000E+00+0.00000E+00i ...  % (one extra zero)
         -9.42478E+00+0.00000E+00i ...
         -6.28319E+02+0.00000E+00i ...
         -5.65487E+02-9.79452E+02i ...
         -5.65487E+02+9.79452E+02i];
    P = [-3.72833E-02-3.67000E-02i ...
         -3.72833E-02+3.67000E-02i ...
         -9.73894E+00+0.00000E+00i ...
         -2.19911E+02-1.38230E+02i ...
         -2.19911E+02+1.38230E+02i ...
         -2.19911E+02-6.84867E+02i ...
         -2.19911E+02+6.84867E+02i];
    stype = 'Velocity';

  case 'ISOLAv' % $MERMAID/events/nearbystations/pz/notes/ISOLA.doc
    Z = [0.0+0.0i ...
         0.0+0.0i ...
         51.5+0.0i];
    P = [-272+218i ...
         -272-218i ...
         56.5+0i ...
         -0.1111+0.1111i ...
         -0.1111-0.1111i];
    stype = 'Velocity';

  otherwise
  error('Specify valid sensor type')

end

% Zero-pole to transfer function conversion
[b,a]=zp2tf(Z(:),P(:),K);

% Frequency axis creation on logarithmic scale
fminlog=-3;
fmaxlog=+3;
w=2*pi*logspace(fminlog,fmaxlog,1001); % rad/s
w_sensitivity_frequency = 2*pi*sensitivity_frequency; %rad/s

% Frequency response evaluation
H=freqs(b,a,w);

% I also want the response evaluated EXACTLY at the input sensitivity
% frequency.  Because freqs won't allow the passage of a single,
% non-integer frequency as the third argument, make a 1x3 vector of
% nominally spaced frequencies with the center being the one we want to inspect later.
test_freqs = [w_sensitivity_frequency - 1 ...
              w_sensitivity_frequency     ...
              w_sensitivity_frequency + 1];

H_sensitivity_frequency=freqs(b,a,test_freqs);
H_sensitivity_frequency=H_sensitivity_frequency(2); % keep the actual frequency I care about (rad/s)
H_sensitivity_frequency=H_sensitivity_frequency; % Hz


% The normalization factor is the inverse of the (ungained!, K=1)
% transfer function evaluated at the sensitivity frequency.
A0 = 1/abs(H_sensitivity_frequency);

if plt
    % Plot system response

    % MAGNITUDE
    ah(1)=subplot(2,1,1);
    pp(1)=loglog(w/(2*pi),abs(H));
    xl(1)=xlabel('frequency (Hz)');
    yl(1)=ylabel(sprintf('%s magnitude response',stype));
    t=title(sprintf('%s transfer function',sensortype));

    % PHASE
    ah(2)=subplot(2,1,2);
    pp(2)=semilogx(w/(2*pi),phase(H)/pi*180);
    xl(2)=xlabel('frequency (Hz)');
    yl(2)=ylabel(sprintf('%s phase response (degrees)',stype));

    % COSMETICS
    set(ah,'xgrid','on','ygrid','on')
    set(ah,'xlim', 10.^[fminlog fmaxlog])
    set(ah,'xtick',10.^[fminlog:fmaxlog])
    set(pp(1),'Color','b','LineWidth',2)
    set(pp(2),'Color','r','LineWidth',2)
    longticks(ah,2)
end
