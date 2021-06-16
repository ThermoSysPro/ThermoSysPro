within ThermoSysPro.Properties.Oil_TherminolVP1;
function Density_derT
  "Returns density time derivative as function of temperature and its derivative"
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    input Real der_temp "Fluid temperature time derivative (K/s)";
    output Real der_rho "Density time derivative (kg/(m3*s))";
protected
    constant Real Density_c0 = 1156.4064882506063;
    constant Real Density_c1 = 0.6335655001350703;
    constant Real Density_c2 = -0.005323755286706528;
    constant Real Density_c3 = 8.795308368738059e-6;
    constant Real Density_c4 = -5.647327102558456e-9;
algorithm
        der_rho := Density_c1 * der_temp + 2 * Density_c2 * temp * der_temp + 3 * Density_c3 * temp ^ 2 * der_temp + 4 * Density_c4 * temp ^ 3 * der_temp;
end Density_derT;
