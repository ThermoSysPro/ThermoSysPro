within ThermoSysPro.Properties.SolarSalt;
function IsobaricExpansionCoefficient_derT
  "derivative of IsobaricExpansionCoefficient_T"
  input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
  input Real der_temp "fluid temperature time derivative (K/s)";
  output Real der_beta "isobaric expansion coefficient time derivative (1/Ks)";
protected
  constant Real betaC0 = 0.636;
  constant Real betaC1 = 2263.72;
  constant Real betaC2 = -0.636;
algorithm
  der_beta := -((betaC0*betaC2)/(betaC1 + betaC2*temp)^2)*der_temp;
end IsobaricExpansionCoefficient_derT;
