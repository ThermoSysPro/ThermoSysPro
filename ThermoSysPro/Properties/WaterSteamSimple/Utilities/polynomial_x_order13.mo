within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_x_order13
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order13 coef;
  input Real x;
  output Real polynomial;

algorithm
  polynomial := coef.c0 +
                coef.c1*x +
                coef.c2*x^2 +
                coef.c3*x^3 +
                coef.c4*x^4 +
                coef.c5*x^5 +
                coef.c6*x^6 +
                coef.c7*x^7 +
                coef.c8*x^8 +
                coef.c9*x^9 +
                coef.c10*x^10 +
                coef.c11*x^11 +
                coef.c12*x^12 +
                coef.c13*x^13;

end polynomial_x_order13;
