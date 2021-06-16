within ThermoSysPro.Properties.SolarSalt;
function ThermalConductivity_derT "derivative of ThermalConductivity_T"
  input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
  input Real der_temp "fluid temperature time derivative (K/s)";
  output Real der_k "thermal conductivity time derivative (W/mKs)";
protected
    constant Real Conductivity_c1 = 0.00019;
algorithm
    der_k := Conductivity_c1*der_temp;
end ThermalConductivity_derT;
