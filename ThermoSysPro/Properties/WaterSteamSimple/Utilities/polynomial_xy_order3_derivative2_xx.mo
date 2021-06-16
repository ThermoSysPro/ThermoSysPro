within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order3_derivative2_xx
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3 coef;
  input Real x;
  input Real y;
  output Real der2_polynomial_xx;

algorithm
  der2_polynomial_xx := coef.c20*2 +
                       coef.c30*6*x +
                       coef.c21*2*y;

end polynomial_xy_order3_derivative2_xx;
