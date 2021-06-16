within ThermoSysPro.Properties.WaterSteamSimple.Energy;
function du1hp_Ph
  "Derivative of specific inner energy wrt. specific enthalpy at constant pressure in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real duhp(unit = "1")
    "Derivative of specific inner energy wrt. specific enthalpy at constant pressure";
protected
  u1_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  duhp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    h);

end du1hp_Ph;
