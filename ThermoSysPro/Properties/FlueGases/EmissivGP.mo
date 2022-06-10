within ThermoSysPro.Properties.FlueGases;
function EmissivGP "Flue gases - particles emissivity"
  extends ThermoSysPro.Properties.FlueGases.unsafeForJacobian;
  input Units.SI.Length AL "Equivalent length (radiation)";
  input Units.SI.Temperature TMF "Flue gases average temperature";
  input Units.SI.Temperature TPE "Wall temperature";
  input Units.SI.AbsolutePressure PMEL "Mixture pressure";
  input Units.SI.AbsolutePressure PH2O "H2O partial pressure";
  input Units.SI.AbsolutePressure PCO2 "PCO2 partial pressure";
  input Real FV "Volume concentration of the particles in the flue gases";
  input Units.SI.Length DP "Particles average diameter";
  input Real EPSPAR "Wall emissivity";
  output Real EPSFP "Particles/flue gases emissivity";

external "FORTRAN" emg(AL, TMF, TPE, PMEL, PH2O, PCO2, FV, DP, EPSPAR, EPSFP);
  annotation (             Window(
      x=0.22,
      y=0.22,
      width=0.44,
      height=0.65),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end EmissivGP;
