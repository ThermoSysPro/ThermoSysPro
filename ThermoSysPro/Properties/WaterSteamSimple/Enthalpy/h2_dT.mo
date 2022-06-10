within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h2_dT
  "Specific enthalpy in vapor region for given density and temperature"
  input Units.SI.Density d "Density";
  input Units.SI.Temperature T "Temperature";
  output Units.SI.SpecificEnthalpy h "Specific enthalpy";
protected
  h1_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    d,
    T);

end h2_dT;
