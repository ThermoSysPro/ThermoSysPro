within ThermoSysPro.Properties.SolarSalt;
function Temperature_mu "inverse of DynamicViscosity_t"
  input Modelica.SIunits.DynamicViscosity mu "Viscosity (Pa.s)";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
    constant Real viscC0 = 0.07551475951333098;
    constant Real viscC1 = - 0.00027760397992950003;
    constant Real viscC2 = 0.00000034888693;
    constant Real viscC3 = - 0.00000000014739999;
algorithm
    temp := (1/(6*viscC3))*(-2*viscC2 + (2*2^(1/3)*(viscC2^2 - 3*viscC1*viscC3))/(-2*viscC2^3 +
     9*viscC1*viscC2*viscC3 + 27*mu*viscC3^2 - 27*viscC0*viscC3^2 + sqrt(-4*(viscC2^2 - 3*viscC1*viscC3)^3 + (2*viscC2^3 -
     9*viscC1*viscC2*viscC3 + 27*(-mu + viscC0)*viscC3^2)^2))^(1/3) + 2^(2/3)*(-2*viscC2^3 + 9*viscC1*viscC2*viscC3 + 27*mu*viscC3^2 -
     27*viscC0*viscC3^2 + sqrt(-4*(viscC2^2 - 3*viscC1*viscC3)^3 + (2*viscC2^3 - 9*viscC1*viscC2*viscC3 + 27*(-mu + viscC0)*viscC3^2)^2))^(1/3));
  annotation(derivative = Temperature_dermu, inverse(mu = DynamicViscosity_T(temp)));
end Temperature_mu;
