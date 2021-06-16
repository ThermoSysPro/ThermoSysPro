within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function du1Tp_PT
  "Derivative of inner energy wrt. temperature at constant pressure in liquid region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "temperature";
 output Modelica.SIunits.SpecificHeatCapacity duTp
    "Derivative of density wrt. temperature at constant pressure";
  u1_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  duTp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(
    coef,
    p,
    T);

end du1Tp_PT;
