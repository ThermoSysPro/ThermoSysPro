within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order5_derivative_y
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5 coef;
  input Real x;
  input Real y;
  output Real der_polynomial_y;

algorithm
  der_polynomial_y := coef.c01 +
                      coef.c11*x +
                      coef.c02*2*y +
                      coef.c21*x^2 +
                      coef.c12*x*2*y +
                      coef.c03*3*y^2 +
                      coef.c31*x^3 +
                      coef.c22*x^2*2*y +
                      coef.c13*x*3*y^2 +
                      coef.c04*4*y^3 +
                      coef.c41*x^4 +
                      coef.c32*x^3*2*y +
                      coef.c23*x^2*3*y^2 +
                      coef.c14*x*4*y^3 +
                      coef.c05*5*y^4;

end polynomial_xy_order5_derivative_y;
