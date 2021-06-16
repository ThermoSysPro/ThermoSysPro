within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
function dcv1ph_Ph
  "Derivative of specific heat capacity wrt. pressure at constant specific enthalpy in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dcvph
    "Derivative of specific heat capacity wrt. pressure at constant specific enthalpy";
  cv1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dcvph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    h);

end dcv1ph_Ph;
