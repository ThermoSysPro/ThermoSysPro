within ThermoSysPro.Properties.SolarSalt;
function Temperature_derbeta "derivative of Temperature_beta"
  input Modelica.SIunits.CubicExpansionCoefficient beta
    "isobaric expansion coefficient (1/K)";
  input Real der_beta "isobaric expansion coefficient time derivative (1/Ks)";
  output Real der_temp "fluid temperature time derivative (K/s)";
protected
  constant Real betaC0 = 0.636;
  constant Real betaC1 = 2263.72;
  constant Real betaC2 = -0.636;
algorithm
  der_temp := (-(betaC1/(beta*betaC2)) - (betaC0 - beta*betaC1)/(beta^2*betaC2))*der_beta;
end Temperature_derbeta;
