within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
function dcp1hp_Ph
  "Derivative of specific heat capacity wrt. specific enthalpy at constant pressure in liquid region for given pressure and specific enthalpy"
 input Modelica.SIunits.AbsolutePressure p "Pressure";
 input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
 output Real dcphp
    "Derivative of specific heat capacity wrt. specific enthalpy at constant pressure";
  cp1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dcphp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5_derivative_y(
    coef,
    p,
    h);

end dcp1hp_Ph;
