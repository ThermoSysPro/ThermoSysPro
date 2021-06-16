within ThermoSysPro.Properties.WaterSteamSimple.Density;
function dd1ph_Ph
  "Derivative of density wrt. pressure at constant specific enthalpy in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Modelica.SIunits.DerDensityByPressure ddph
    "Derivative of density wrt. pressure at constant specific enthalpy";
protected
  d1_Ph_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  ddph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_x(
    coef,
    p,
    h);

end dd1ph_Ph;
