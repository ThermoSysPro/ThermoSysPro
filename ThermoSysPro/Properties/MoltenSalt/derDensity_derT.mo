within ThermoSysPro.Properties.MoltenSalt;
function derDensity_derT "der(Density) computation for Salt (input der(T))"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Real der_T "Temperature time derivative (K/s)";
  output Real der_rho "Density time derivative (kg/(m3*s))";

protected
    constant Real Density_c0 = 2263.87142553064;
    constant Real Density_c1 = -0.636188210739603;

algorithm
  der_rho:= Density_c1 * der_T;  // STEPHANIE SQMSolarSalt

end derDensity_derT;
