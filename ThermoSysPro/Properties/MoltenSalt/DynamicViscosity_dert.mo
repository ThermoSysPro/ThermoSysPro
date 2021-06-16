within ThermoSysPro.Properties.MoltenSalt;
function DynamicViscosity_dert
  "der Dynamic Viscosity computation for Salt (input T)"

  input Modelica.SIunits.Temperature temp "Temperature (K)";
  input Real der_temp "Fluid temperature time derivative (K/s)";
  output Real der_mu "Dynamic Viscosity time derivative(Pa)";

protected
    constant Real Viscosity_c0 = 0.07551475951333098;
    constant Real Viscosity_c1 = - 0.00027760397992950003;
    constant Real Viscosity_c2 = 0.00000034888693;
    constant Real Viscosity_c3 = - 0.00000000014739999;
algorithm
      der_mu := Viscosity_c1*der_temp + 2*Viscosity_c2*temp*der_temp + 3*Viscosity_c3*temp^2*der_temp;

end DynamicViscosity_dert;
