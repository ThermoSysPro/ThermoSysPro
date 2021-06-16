within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order3_derivative2_xy
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3 coef;
  input Real x;
  input Real y;
  output Real der2_polynomial_xy;

algorithm
  der2_polynomial_xy := coef.c11 +
                        coef.c21*2*x +
                        coef.c12*2*y;

end polynomial_xy_order3_derivative2_xy;
