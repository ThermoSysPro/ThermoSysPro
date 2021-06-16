within ThermoSysPro.Properties.SolarSalt;
function Temperature_derrho "derivative of Temperature_rho"
  input Modelica.SIunits.Density rho "Density (kg/m3)";
  input Real der_rho "Density time derivative (kg/(m3*s))";
  output Real der_temp "Fluid temperature time derivative (K/s)";
protected
  constant Real Temp_c1 = - 1.57233;
algorithm
  der_temp := Temp_c1*der_rho;
end Temperature_derrho;
