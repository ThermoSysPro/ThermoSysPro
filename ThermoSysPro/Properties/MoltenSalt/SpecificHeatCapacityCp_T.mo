within ThermoSysPro.Properties.MoltenSalt;
function SpecificHeatCapacityCp_T
  "Specific Heat Capacity at fixed P computation for Salt (input T)"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  output Modelica.SIunits.SpecificHeatCapacity Cp
    "Specific Heat Capacity (J/kg/K)";

algorithm
  //Cp := 1396.11639230963 + 0.171740545944394*T;              // temperature in K

  // New
    Cp := 1443 + 0.172*(T - 273.15);
    //Cp := 1448;

end SpecificHeatCapacityCp_T;
