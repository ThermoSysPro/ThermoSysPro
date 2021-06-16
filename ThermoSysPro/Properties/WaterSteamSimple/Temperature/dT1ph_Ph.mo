within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
function dT1ph_Ph
  "Derivative of temperature wrt. pressure at constant specific enthalpy in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dTph
    "Derivative of temperature wrt. pressure at constant specific enthalpy";
protected
  T1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dTph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    p,
    h);

end dT1ph_Ph;
