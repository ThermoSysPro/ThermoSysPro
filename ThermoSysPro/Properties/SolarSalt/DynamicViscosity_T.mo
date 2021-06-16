within ThermoSysPro.Properties.SolarSalt;
function DynamicViscosity_T
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";   //(22.714 - 0.12*(T - 273.15) + 2.281*10^(-4)*(T - 273.15)^2)/1000 - (1.474*10^(-7)*(T - 273.15)^3)/1000
    output Modelica.SIunits.DynamicViscosity mu "Viscosity (Pa.s)";
protected
    constant Real Viscosity_c0 = 0.07551475951333098;
    constant Real Viscosity_c1 = - 0.00027760397992950003;
    constant Real Viscosity_c2 = 0.00000034888693;
    constant Real Viscosity_c3 = - 0.00000000014739999;
algorithm
    mu := Viscosity_c0 + Viscosity_c1*temp + Viscosity_c2*temp^2 + Viscosity_c3*temp^3;
  annotation(derivative = DynamicViscosity_derT, inverse(temp = Temperature_mu(mu)));
end DynamicViscosity_T;
