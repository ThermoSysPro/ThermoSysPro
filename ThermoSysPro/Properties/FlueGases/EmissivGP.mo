within ThermoSysPro.Properties.FlueGases;
function EmissivGP "Flue gases - particles emissivity"
  extends ThermoSysPro.Properties.FlueGases.unsafeForJacobian;
  input Modelica.SIunits.Length AL "Equivalent length (radiation)";
  input Modelica.SIunits.Temperature TMF "Flue gases average temperature";
  input Modelica.SIunits.Temperature TPE "Wall temperature";
  input Modelica.SIunits.AbsolutePressure PMEL "Mixture pressure";
  input Modelica.SIunits.AbsolutePressure PH2O "H2O partial pressure";
  input Modelica.SIunits.AbsolutePressure PCO2 "PCO2 partial pressure";
  input Real FV "Volume concentration of the particles in the flue gases";
  input Modelica.SIunits.Length DP "Particles average diameter";
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
