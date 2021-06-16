within ThermoSysPro.Properties.SolarSalt;
function Temperature_derk "derivative of Temperature_k"
  input Modelica.SIunits.ThermalConductivity k "Thermal Conductivity (W/mK)";
  input Real der_k "thermal conductivity time derivative (W/mKs)";
  output Real der_temp "fluid temperature time derivative";
protected
  constant Real tempC1 = 5263.16;
algorithm
   der_temp := tempC1*der_k;
end Temperature_derk;
