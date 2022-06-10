within ThermoSysPro.Properties.WaterSteamSimple.Density;
function d1_Ps
  "Density in liquid region for given pressure and specific entropy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEntropy s "Specific entropy";
  output Units.SI.Density d "Density";
protected
  d1_Ps_coef coef
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  d := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order3(
    coef,
    p,
    s);

end d1_Ps;
