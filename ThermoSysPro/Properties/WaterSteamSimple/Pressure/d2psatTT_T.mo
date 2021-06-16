within ThermoSysPro.Properties.WaterSteamSimple.Pressure;
function d2psatTT_T "Second derivative of saturation pressure wrt. temperature"
 input Modelica.SIunits.Temperature T "Temperature";
 output Real d2pTT "Second derivative of pressure";
  psat_T_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d2pTT :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7_derivative2(
    coef, T);

end d2psatTT_T;
