within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order3_derivative_x
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3 coef;
  input Real x;
  input Real y;
  output Real der_polynomial_x;

algorithm
  der_polynomial_x := coef.c10 +
                      coef.c20*2*x +
                      coef.c11*y +
                      coef.c30*3*x^2 +
                      coef.c21*2*x*y +
                      coef.c12*y^2;

end polynomial_xy_order3_derivative_x;
