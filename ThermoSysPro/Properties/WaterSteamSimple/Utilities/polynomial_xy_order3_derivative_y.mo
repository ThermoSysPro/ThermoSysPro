within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order3_derivative_y
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3 coef;
  input Real x;
  input Real y;
  output Real der_polynomial_y;

algorithm
  der_polynomial_y := coef.c01 +
                      coef.c11*x +
                      coef.c02*2*y +
                      coef.c21*x^2 +
                      coef.c12*x*2*y +
                      coef.c03*3*y^2;

end polynomial_xy_order3_derivative_y;
