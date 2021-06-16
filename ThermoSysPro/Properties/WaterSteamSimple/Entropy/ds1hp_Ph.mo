within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function ds1hp_Ph
  "Derivative of specific entropy wrt. specific enthalpy at constant pressure in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dshp
    "Derivative of specific entropy wrt. specific enthalpy at constant pressure";
  s1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dshp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    h);

end ds1hp_Ph;
