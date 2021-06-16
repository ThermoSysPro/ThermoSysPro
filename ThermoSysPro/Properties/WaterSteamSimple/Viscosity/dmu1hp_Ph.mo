within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function dmu1hp_Ph
  "Derivative of viscosity wrt. specific enthalpy at constant pressure in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dmuhp
    "Derivative of viscosity wrt. specific enthalpy at constant pressure";
  mu1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dmuhp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(
    coef,
    p,
    h);

end dmu1hp_Ph;
