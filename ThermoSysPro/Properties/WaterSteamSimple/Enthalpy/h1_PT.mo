within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h1_PT
  "Specific enthalpy in liquid region for given pressure and temperature"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.Temperature T "Temperature";
  output Units.SI.SpecificEnthalpy h "Specific enthalpy";
protected
  h1_PT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    p,
    T);

end h1_PT;
