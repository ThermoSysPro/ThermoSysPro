within ThermoSysPro.Properties.Oil_TherminolVP1;
function Density_T "Density as function of temperature"
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.Density rho "Density (kg/m3)";
protected
    constant Real Density_c0 = 1156.4064882506063;
    constant Real Density_c1 = 0.6335655001350703;
    constant Real Density_c2 = -0.005323755286706528;
    constant Real Density_c3 = 8.795308368738059e-6;
    constant Real Density_c4 = -5.647327102558456e-9;
algorithm
        rho := Density_c0 + Density_c1 * temp + Density_c2 * temp ^ 2 + Density_c3 * temp ^ 3 + Density_c4 * temp ^ 4;
   annotation(derivative = Density_derT, inverse(temp = Temperature_rho(rho)));
end Density_T;
