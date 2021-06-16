within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_x_order5
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5 coef;
  input Real x;
  output Real polynomial;

algorithm
  polynomial := coef.c0 +
                coef.c1*x +
                coef.c2*x^2 +
                coef.c3*x^3 +
                coef.c4*x^4 +
                coef.c5*x^5;

end polynomial_x_order5;
