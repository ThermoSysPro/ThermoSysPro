within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h2_PT
  "Specific enthalpy in vapor region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  h2_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    T);

end h2_PT;
