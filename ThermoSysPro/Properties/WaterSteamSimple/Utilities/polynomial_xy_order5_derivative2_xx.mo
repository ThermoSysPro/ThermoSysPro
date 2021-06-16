within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order5_derivative2_xx
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5 coef;
  input Real x;
  input Real y;
  output Real der2_polynomial_xx;

algorithm
  der2_polynomial_xx := coef.c20*2 +
                       coef.c30*6*x +
                       coef.c21*2*y +
                       coef.c40*12*x^2 +
                       coef.c31*6*x*y +
                       coef.c22*2*y^2 +
                       coef.c50*20*x^3 +
                       coef.c41*12*x^2*y +
                       coef.c32*6*x*y^2 +
                       coef.c23*2*y^3;

end polynomial_xy_order5_derivative2_xx;
