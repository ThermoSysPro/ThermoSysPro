within ThermoSysPro.Properties.SolarSalt;
function SpecificHeatCp_T
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.SpecificHeatCapacity cp
    "Specific Heat Capacity (J/kgK)";
protected
    constant Real Cp_c0 = 1396.0182;                                     //1443 + 0.172 (-273.15 + T)
    constant Real Cp_c1 = 0.172;
algorithm
      cp := Cp_c0 + Cp_c1*temp;
  annotation(inverse(temp = Temperature_cp(cp)), derivative = SpecificHeatCp_derT);
end SpecificHeatCp_T;
