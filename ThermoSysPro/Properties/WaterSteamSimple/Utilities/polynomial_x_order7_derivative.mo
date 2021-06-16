within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_x_order7_derivative
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7 coef;
  input Real x;
  output Real der_polynomial_x;

algorithm
  der_polynomial_x := coef.c1 +
                      coef.c2*2*x +
                      coef.c3*3*x^2 +
                      coef.c4*4*x^3 +
                      coef.c5*5*x^4 +
                      coef.c6*6*x^5 +
                      coef.c7*7*x^6;

end polynomial_x_order7_derivative;
