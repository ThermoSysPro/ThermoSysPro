within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order5_derivative2_xy
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5 coef;
  input Real x;
  input Real y;
  output Real der2_polynomial_xy;

algorithm
  der2_polynomial_xy := coef.c11 +
                        coef.c21*2*x +
                        coef.c12*2*y +
                        coef.c31*3*x^2 +
                        coef.c22*2*x*2*y +
                        coef.c13*3*y^2 +
                        coef.c41*4*x^3 +
                        coef.c32*3*x^2*2*y +
                        coef.c23*2*x*3*y^2 +
                        coef.c14*4*y^3;

end polynomial_xy_order5_derivative2_xy;
