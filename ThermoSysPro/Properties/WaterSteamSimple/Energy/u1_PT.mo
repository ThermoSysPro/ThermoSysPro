within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function u1_PT
  "Specific inner energy in liquid region for given pressure and temperature"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.Temperature T "Temperature";
 output Modelica.SIunits.SpecificEnergy u "Specific inner energy";
  u1_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  u := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    p,
    T);

end u1_PT;
