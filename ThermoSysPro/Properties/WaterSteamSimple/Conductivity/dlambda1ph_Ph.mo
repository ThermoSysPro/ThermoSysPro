within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function dlambda1ph_Ph
  "Derivative of conductivity wrt. pressure at constant specific enthalpy in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dlambdaph
    "Derivative of conductivity wrt. pressure at constant specific enthalpy";
  lambda1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dlambdaph :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_x(
    coef,
    p,
    h);

end dlambda1ph_Ph;
