within ThermoSysPro.Properties.MoltenSalt;
function ThermalConductivity_T
  "Thermal Conductivity computation for Salt (input T)"

  input Units.SI.Temperature T "Temperature (K)";
  output Units.SI.ThermalConductivity k "Thermal Conductivity (W/m/K)";

algorithm
  k := 0.3911015 + 0.00019*T;                                // temperature in °K

end ThermalConductivity_T;
