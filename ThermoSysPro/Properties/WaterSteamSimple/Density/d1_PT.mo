within ThermoSysPro.Properties.WaterSteamSimple.Density;
function d1_PT "Density in liquid region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.Density d "Density";
  d1_PT_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    p,
    T);

end d1_PT;
