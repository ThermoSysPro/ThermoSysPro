within ThermoSysPro.Properties.MoltenSalt;
function Density_T "Density computation for Salt (input T)"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  output Modelica.SIunits.Density rho "Density (kg/m3)";

algorithm
  rho := 2263.87142553064 - 0.636188210739603*T;  // Stephanie SQMSolarSalt
  //rho := 2263.7234 - 0.636*T;  // Stephanie SolarSalt

  annotation(derivative = derDensity_derT);
end Density_T;
