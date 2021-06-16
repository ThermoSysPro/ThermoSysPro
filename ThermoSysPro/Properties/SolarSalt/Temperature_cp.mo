within ThermoSysPro.Properties.SolarSalt;
function Temperature_cp "inverse function of SpecificHeatCp_t"
  input Modelica.SIunits.SpecificHeatCapacity cp
    "Specific Heat Capacity (J/kgK)";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
  constant Real tempC0 = -8116.38;
  constant Real tempC1 = 5.81395;
algorithm
   temp := tempC0 + tempC1*cp;
   annotation(inverse(cp = SpecificHeatCp_T(temp)), derivative = Temperature_dercp);
end Temperature_cp;
