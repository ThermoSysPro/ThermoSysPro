within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
function dT1hp_Ph
  "Derivative of temperature wrt. enthalpy at constant pressure in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dThp
    "Derivative of temperature wrt. specific enthalpy at constant pressure";
  T1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dThp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    h);

end dT1hp_Ph;
