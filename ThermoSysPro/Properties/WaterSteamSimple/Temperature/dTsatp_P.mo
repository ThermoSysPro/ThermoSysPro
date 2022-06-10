within ThermoSysPro.Properties.WaterSteamSimple.Temperature;
function dTsatp_P "Derivative of temperature at saturation wrt. pressure"
  input Units.SI.AbsolutePressure p "Pressure";
  output Real dTp "Derivative of temperature wrt. pressure";
protected
  Tsat_P_coef coef annotation (Placement(transformation(extent={{-100,
            80},{-80,100}})));
algorithm

  dTp := ThermoSysPro.Properties.WaterSteamSimple.Utilities.polynomial_x_order7_derivative(coef, p);

end dTsatp_P;
