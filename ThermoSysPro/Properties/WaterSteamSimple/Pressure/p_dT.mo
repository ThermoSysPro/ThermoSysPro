within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function p_dT "Pressure in liquid region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.Pressure p "Pressure";
protected
  p_dT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  p := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    d,
    T);

end p_dT;
