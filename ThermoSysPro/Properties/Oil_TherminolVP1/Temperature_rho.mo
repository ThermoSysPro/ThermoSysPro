within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_rho "inverse of function Density_t"
  input Modelica.SIunits.Density rho "Density (kg/m3)";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
  constant Real Temp_c0 = 829.2269319387954;
  constant Real Temp_c1 = -0.6032830735166413;
  constant Real Temp_c2 = 0.0023861103439862656;
  constant Real Temp_c3 = -3.586365918195385e-6;
  constant Real Temp_c4 = 1.3461510759998317e-9;
algorithm
  temp := Temp_c0 + Temp_c1 * rho + Temp_c2 * rho ^ 2 + Temp_c3 * rho ^ 3 + Temp_c4 * rho ^ 4;
 annotation(derivative = Temperature_derrho, inverse(rho = Density_T(temp)));
end Temperature_rho;
