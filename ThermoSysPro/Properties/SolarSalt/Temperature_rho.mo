within ThermoSysPro.Properties.SolarSalt;
function Temperature_rho "inverse of function Density_t"
  input Modelica.SIunits.Density rho "Density (kg/m3)";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
  constant Real Temp_c0 = 3559.31;
  constant Real Temp_c1 = - 1.57233;
algorithm
  temp := Temp_c0 + Temp_c1*rho;
 annotation(derivative = Temperature_derrho, inverse(rho = Density_T(temp)));
end Temperature_rho;
