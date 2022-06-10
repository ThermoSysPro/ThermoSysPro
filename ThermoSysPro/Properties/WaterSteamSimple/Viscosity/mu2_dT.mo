within ThermoSysPro.Properties.WaterSteamSimple.Viscosity;
function mu2_dT "Viscosity in vapor region for given density and temperature"
  input Units.SI.Density d "Density";
  input Units.SI.Temperature T "Temperature";
  output Units.SI.DynamicViscosity mu "Dynamic viscosity";
protected
  mu2_dT_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  mu := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    d,
    T);

end mu2_dT;
