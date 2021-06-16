within ThermoSysPro.Properties.SolarSalt;
function ThermalConductivity_T
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.ThermalConductivity k "Thermal Conductivity";
protected
    constant Real Conductivity_c0 = 0.3911015;               // 0.443 + 0.00019 (-273.15 + T)
    constant Real Conductivity_c1 = 0.00019;
algorithm
      k := Conductivity_c0 + Conductivity_c1*temp;
  annotation(inverse(temp = Temperature_k(k)), derivative = ThermalConductivity_derT);
end ThermalConductivity_T;
