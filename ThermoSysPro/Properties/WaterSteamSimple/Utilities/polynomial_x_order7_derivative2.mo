within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_x_order7_derivative2
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order7 coef;
  input Real x;
  output Real der2_polynomial_x;

algorithm
  der2_polynomial_x :=coef.c2*2 +
                      coef.c3*3*2*x +
                      coef.c4*4*3*x^2 +
                      coef.c5*5*4*x^3 +
                      coef.c6*6*5*x^4 +
                      coef.c7*7*6*x^5;

end polynomial_x_order7_derivative2;
