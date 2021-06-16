within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function psat_T "Saturation pressure for given temperature"
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.Pressure p "Pressure";
  psat_T_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  p := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7(
    coef, T);

end psat_T;
