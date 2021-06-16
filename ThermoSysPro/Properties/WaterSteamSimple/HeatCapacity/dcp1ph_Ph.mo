within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
function dcp1ph_Ph
  "Derivative of specific heat capacity wrt. pressure at constant specific enthalpy in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dcpph
    "Derivative of specific heat capacity wrt. pressure at constant specific enthalpy";
protected
  cp1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dcpph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    h);

end dcp1ph_Ph;
