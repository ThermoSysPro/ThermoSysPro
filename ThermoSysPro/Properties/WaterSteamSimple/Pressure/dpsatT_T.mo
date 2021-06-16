within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function dpsatT_T "Derivative of saturation pressure wrt. temperature"
 input Modelica.SIunits.Temperature T "Temperature";
 output Real dpT "Derivative of pressure";
  psat_T_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dpT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7_derivative(
    coef, T);

end dpsatT_T;
