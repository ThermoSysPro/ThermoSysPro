within ThermoSysPro.Properties.WaterSteamSimple.Entropy;
function ds1ph_Ph
  "Derivative of specific entropy wrt. pressure at constant specific enthalpy in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dsph
    "Derivative of specific entropy wrt. pressure at constant specific enthalpy";
protected
  s1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dsph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    p,
    h);

end ds1ph_Ph;
