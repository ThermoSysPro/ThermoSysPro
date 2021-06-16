within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order5
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order5 coef;
  input Real x;
  input Real y;
  output Real polynomial;

algorithm
  polynomial := coef.c00 +
                coef.c10*x +
                coef.c01*y +
                coef.c20*x^2 +
                coef.c11*x*y +
                coef.c02*y^2 +
                coef.c30*x^3 +
                coef.c21*x^2*y +
                coef.c12*x*y^2 +
                coef.c03*y^3 +
                coef.c40*x^4 +
                coef.c31*x^3*y +
                coef.c22*x^2*y^2 +
                coef.c13*x*y^3 +
                coef.c04*y^4 +
                coef.c50*x^5 +
                coef.c41*x^4*y +
                coef.c32*x^3*y^2 +
                coef.c23*x^2*y^3 +
                coef.c14*x*y^4 +
                coef.c05*y^5;

end polynomial_xy_order5;
