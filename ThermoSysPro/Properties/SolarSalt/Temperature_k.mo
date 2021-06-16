within ThermoSysPro.Properties.SolarSalt;
function Temperature_k "inverse function of ThermalConductivity_t"
  input Modelica.SIunits.ThermalConductivity k "Thermal Conductivity";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
  constant Real tempC0 = -2058.43;
  constant Real tempC1 = 5263.16;
algorithm
  temp := tempC0 + tempC1*k;
  annotation(inverse(k = ThermalConductivity_T(temp)), derivative = Temperature_derk);
end Temperature_k;
