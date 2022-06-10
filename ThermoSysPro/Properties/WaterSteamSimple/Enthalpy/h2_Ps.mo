within ThermoSysPro.Properties.WaterSteamSimple.Enthalpy;
function h2_Ps
  "Specific enthalpy in vapor region for given pressure and specific entropy"
  input Units.SI.AbsolutePressure p "Pressure";
  input Units.SI.SpecificEntropy s "Specific entropy";
  output Units.SI.SpecificEnthalpy h "Specific enthalpy";
protected
  h2_Ps_coef coef annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
algorithm

  h := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_xy_order5(
    coef,
    ThermoSysPro.Properties.WaterSteamSimple.Utilities.logBase10(p),
    s);

end h2_Ps;
