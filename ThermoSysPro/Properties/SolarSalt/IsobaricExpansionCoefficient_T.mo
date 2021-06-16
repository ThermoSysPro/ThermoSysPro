within ThermoSysPro.Properties.SolarSalt;
function IsobaricExpansionCoefficient_T
  "beta as function of temperature"
  input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
  output Modelica.SIunits.CubicExpansionCoefficient beta
    "isobaric expansion coefficient (1/K)";
protected
  constant Real betaC0 = 0.636;
  constant Real betaC1 = 2263.72;
  constant Real betaC2 = -0.636;
algorithm
   beta := betaC0/(betaC1 + betaC2*temp);
 annotation(inverse(temp = Temperature_beta(beta)),derivative = IsobaricExpansionCoefficient_derT);
end IsobaricExpansionCoefficient_T;
