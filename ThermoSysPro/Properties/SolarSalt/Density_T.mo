within ThermoSysPro.Properties.SolarSalt;
function Density_T
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.Density rho "Density (kg/m3)";
protected
    constant Real Density_c0 = 2263.7234;                //2090 - 0.636 (-273.15 + T)  = 2090 + 173.7234 - 0.636*T = 2263.7234 - 0.636*T
    constant Real Density_c1 = - 0.636;

algorithm
      rho := Density_c0 + Density_c1 * temp;
  annotation(derivative = Density_derT, inverse(temp = Temperature_rho(rho)));
end Density_T;
