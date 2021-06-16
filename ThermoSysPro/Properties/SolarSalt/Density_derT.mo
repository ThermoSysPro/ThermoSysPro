within ThermoSysPro.Properties.SolarSalt;
function Density_derT
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    input Real der_temp "Fluid temperature time derivative (K/s)";
    output Real der_rho "Density time derivative (kg/(m3*s))";
protected
    constant Real Density_c1 = -0.636;
algorithm
   der_rho := Density_c1*der_temp;
end Density_derT;
