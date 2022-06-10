within ThermoSysPro.Properties.WaterSteamSimple.Conductivity;
function lambda1_Ph
  "Conductivity in liquid region for given pressure and specific enthalpy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEnthalpy h "Specific enthalpy";
  output Units.SI.ThermalConductivity lambda "Thermal conductivity";
protected
  lambda1_Ph_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  lambda :=
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    p,
    h);

end lambda1_Ph;
