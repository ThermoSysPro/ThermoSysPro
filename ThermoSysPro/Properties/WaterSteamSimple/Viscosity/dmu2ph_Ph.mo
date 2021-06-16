within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function dmu2ph_Ph
  "Derivative of viscosity wrt. pressure at constant specific enthalpy in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dmuph
    "Derivative of viscosity wrt. pressure at constant specific enthalpy";
  mu2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dmuph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    p,
    h);

end dmu2ph_Ph;
