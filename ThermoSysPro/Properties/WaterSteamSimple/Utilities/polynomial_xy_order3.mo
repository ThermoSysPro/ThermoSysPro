within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_xy_order3
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_xy_order3 coef;
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
                coef.c03*y^3;

end polynomial_xy_order3;
