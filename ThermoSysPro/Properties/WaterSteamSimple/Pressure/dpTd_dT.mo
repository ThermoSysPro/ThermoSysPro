within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function dpTd_dT
  "Derivative of pressure wrt. specific entropy at constant density in liquid region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dpTd "Derivative of pressure wrt. temperature at constant density";
 p_dT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dpTd :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(
    coef,
    d,
    T);

end dpTd_dT;
