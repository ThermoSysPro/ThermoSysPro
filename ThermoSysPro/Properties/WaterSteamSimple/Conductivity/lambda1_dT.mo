within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function lambda1_dT
  "Conductivity in liquid region for given density and temperature"
 input Modelica.SIunits.Density d "Density";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.ThermalConductivity  lambda "Thermal conductivity";
protected
  lambda1_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  lambda :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    d,
    T);

end lambda1_dT;
