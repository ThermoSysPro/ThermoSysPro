within ThermoSysPro.Properties.SolarSalt;
function Temperature_beta "inverse function of IsobaricExpansionCoefficient_t"
  input Modelica.SIunits.CubicExpansionCoefficient beta
    "isobaric expansion coefficient (1/K)";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
  constant Real betaC0 = 0.636;
  constant Real betaC1 = 2263.72;
  constant Real betaC2 = -0.636;
algorithm
      temp := (betaC0 - beta*betaC1)/(beta*betaC2);
   annotation(inverse(beta = IsobaricExpansionCoefficient_T(temp)), derivative = Temperature_derbeta);
end Temperature_beta;
