within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function dh2Tp_PT
  "Derivative of specific enthalpy wrt. specific entropy at constant pressure in vapor region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dhTp
    "Derivative of specific enthalpy wrt. temperature at constant pressure";
  h2_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dhTp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    T);

end dh2Tp_PT;
