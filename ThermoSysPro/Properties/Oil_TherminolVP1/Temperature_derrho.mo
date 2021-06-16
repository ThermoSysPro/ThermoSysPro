within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_derrho "derivative of Temperature_rho"
  input Modelica.SIunits.Density rho "Density (kg/m3)";
  input Real der_rho "Density time derivative (kg/(m3*s))";
  output Real der_temp "Fluid temperature time derivative (K/s)";
protected
  constant Real Temp_c0 = 829.2269319387954;
  constant Real Temp_c1 = -0.6032830735166413;
  constant Real Temp_c2 = 0.0023861103439862656;
  constant Real Temp_c3 = -3.586365918195385e-6;
  constant Real Temp_c4 = 1.3461510759998317e-9;
algorithm
  der_temp :=  Temp_c1 * der_rho + 2 * Temp_c2 * rho * der_rho + 3 * Temp_c3 * rho ^ 2 *der_rho + 4 * Temp_c4 * rho ^ 3 * der_rho;
end Temperature_derrho;
