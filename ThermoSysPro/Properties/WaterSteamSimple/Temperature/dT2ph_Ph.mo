within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
function dT2ph_Ph
  "Derivative of temperature wrt. pressure at constant specific enthalpy in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dTph
    "Derivative of temperature wrt. pressure at constant specific enthalpy";
protected
 T2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dTph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    h);

end dT2ph_Ph;
