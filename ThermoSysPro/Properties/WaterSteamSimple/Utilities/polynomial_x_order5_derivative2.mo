within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function polynomial_x_order5_derivative2
  input ThermoSysPro.Properties.WaterSteamSimple.Utilities.coef_x_order5 coef;
  input Real x;
  output Real der2_polynomial_x;

algorithm
  der2_polynomial_x :=coef.c2*2 +
                      coef.c3*3*2*x +
                      coef.c4*4*3*x^2 +
                      coef.c5*5*4*x^3;

end polynomial_x_order5_derivative2;
