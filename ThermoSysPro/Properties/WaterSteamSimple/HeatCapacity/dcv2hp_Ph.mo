within ThermoSysPro.Properties.WaterSteamSimple.HeatCapacity;
function dcv2hp_Ph
  "Derivative of specific heat capacity wrt. specific enthalpy at constant pressure in vapor region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";
  output Real dcvhp
    "Derivative of specific heat capacity wrt. specific enthalpy at constant pressure";
protected
  cv2_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  dcvhp :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3_derivative_y(
    coef,
    p,
    h);

end dcv2hp_Ph;
