within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function u2_Ph
  "Specific inner energy in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.SpecificEnergy u "Specific inner energy";
protected
  u2_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  u := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    h);

end u2_Ph;
