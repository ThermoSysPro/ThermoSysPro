within ThermoSysPro.Properties.SolarSalt;
function Temperature_dercp "derivative of Temperature_cp"
  input Modelica.SIunits.SpecificHeatCapacity cp
    "Specific Heat Capacity (J/kgK)";
  input Real der_cp "specific heat capacity time derivative (J/kgKs)";
  output Real der_temp "fluid temperature time derivative (K/s)";
protected
  constant Real tempC1 = 5.81395;
algorithm
   der_temp :=  tempC1*der_cp;
end Temperature_dercp;
