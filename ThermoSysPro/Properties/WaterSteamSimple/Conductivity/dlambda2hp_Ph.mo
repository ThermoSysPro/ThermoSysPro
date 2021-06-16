within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function dlambda2hp_Ph
  "Derivative of conductivity wrt. specific enthalpy at constant pressure in vapor region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dlambdahp
    "Derivative of conductivity wrt. specific enthalpy at constant pressure";
  lambda2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dlambdahp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    h);

end dlambda2hp_Ph;
