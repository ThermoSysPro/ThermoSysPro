within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h2_dT
  "Specific enthalpy in vapor region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  h1_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    d,
    T);

end h2_dT;
