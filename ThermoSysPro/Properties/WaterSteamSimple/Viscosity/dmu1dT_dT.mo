within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function dmu1dT_dT
  "Derivative of viscosity wrt. pressure at constant specific enthalpy in liquid region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dmudT
    "Derivative of viscosity wrt. density at constant temperature";
  mu1_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dmudT := 0;

end dmu1dT_dT;
