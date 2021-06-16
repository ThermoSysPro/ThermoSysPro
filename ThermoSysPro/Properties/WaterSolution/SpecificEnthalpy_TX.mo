within ThermoSysPro.Properties.WaterSolution;
function SpecificEnthalpy_TX
  "Specific enthalpy of the H2O/LiBr solution as a function of T and Xh2o"
  input Modelica.SIunits.Temperature T "Temperature";
  input Real X "Water mass fraction in the solution";

  output Modelica.SIunits.SpecificEnthalpy h
    "Specific enthalpy of the solution";

protected
  Real C1;
  Real C2;
  Real C3;
  Real C4;
  Real C5;
  Real DXi;
  Real Xi "LiBr mass fraction in the solution";
  Modelica.SIunits.Temperature Tc "Temperature in Celsius";
  Modelica.SIunits.SpecificEnthalpy H1
    "Liquid LiBr specific enthalpy on the saturation line";
  Modelica.SIunits.SpecificEnthalpy Hliq
    "Liquid H2O specific enthalpy on the saturation line";
  Modelica.SIunits.SpecificEnthalpy Dh
    "Difference in specific enthalpy wrt. ideal mixing";

algorithm
  /* Liquid H2O specific enthalpy */
  Hliq := ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(15e5, T, 1);

  /* Units conversions */
  Tc := T - 273.15;
  Xi := 1 - X;
  DXi := 2*Xi - 1;

  /* LiBr specific entahlpy */
  H1 := 0.5086682481e3 - 0.1862407335e2*Tc + 0.9859458321e-1*Tc*Tc -
    0.2509791095e-4*Tc*Tc*Tc + 0.4158007710e-7*Tc*Tc*Tc*Tc;

  /* Difference with ideal conditions */
  C1 := -0.1021608631e4 + 0.3687726426e2*Tc - 0.1860514100*Tc*Tc - 0.7512766773e-5*Tc*Tc*Tc;
  C2 := -0.5333082110e3 + 0.4028472553e2*Tc - 0.1911981148*Tc*Tc;
  C3 := 0.4836280661e3 + 0.3991418127e2*Tc - 0.1992131652*Tc*Tc;
  C4 := 0.1155132809e4 + 0.3335722311e2*Tc - 0.1782584073*Tc*Tc;
  C5 := 0.6406219484e3 + 0.1310318363e2*Tc - 0.7751011421e-1*Tc*Tc;
  Dh := (C1 + C2*DXi + C3*DXi*DXi + C4*DXi*DXi*DXi + C5*DXi*DXi*DXi*DXi)*Xi*(1 - Xi);

  /* Specific entahlpy of the solution */
  h := 1000 * (Xi * H1 + (1 - Xi) * Hliq/1000 + Dh);

  annotation (
    smoothOrder = 2,
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end SpecificEnthalpy_TX;
