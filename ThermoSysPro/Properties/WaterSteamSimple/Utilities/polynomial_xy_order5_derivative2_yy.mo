within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order5_derivative2_yy
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5 coef;
  input Real x;
  input Real y;
  output Real der2_polynomial_yy;

algorithm
  der2_polynomial_yy := coef.c02*2 +
                       coef.c12*x*2 +
                       coef.c03*6*y +
                       coef.c22*x^2*2 +
                       coef.c13*x*6*y +
                       coef.c04*12*y^2 +
                       coef.c32*x^3*2 +
                       coef.c23*x^2*6*y +
                       coef.c14*x*12*y^2 +
                       coef.c05*20*y^3;

end polynomial_xy_order5_derivative2_yy;
