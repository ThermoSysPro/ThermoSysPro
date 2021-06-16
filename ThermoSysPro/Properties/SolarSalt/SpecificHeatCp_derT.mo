within ThermoSysPro.Properties.SolarSalt;
function SpecificHeatCp_derT "derivative of SpecificHeatCp_T"
  input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
  input Real der_temp "fluid temperature time derivative (K/s)";
  output Real der_cp "specific heat capacity time derivative (J/kgKs)";
protected
    constant Real Cp_c1 = 0.172;
algorithm
   der_cp := Cp_c1*der_temp;
end SpecificHeatCp_derT;
