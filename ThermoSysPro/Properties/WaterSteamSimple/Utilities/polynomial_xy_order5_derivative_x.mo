within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order5_derivative_x
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5 coef;
  input Real x;
  input Real y;
  output Real der_polynomial_x;

algorithm
  der_polynomial_x := coef.c10 +
                      coef.c20*2*x +
                      coef.c11*y +
                      coef.c30*3*x^2 +
                      coef.c21*2*x*y +
                      coef.c12*y^2 +
                      coef.c40*4*x^3 +
                      coef.c31*3*x^2*y +
                      coef.c22*2*x*y^2 +
                      coef.c13*y^3 +
                      coef.c50*5*x^4 +
                      coef.c41*4*x^3*y +
                      coef.c32*3*x^2*y^2 +
                      coef.c23*2*x*y^3 +
                      coef.c14*y^4;

end polynomial_xy_order5_derivative_x;
