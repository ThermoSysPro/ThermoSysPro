within ThermoSysPro.Properties.Oil_TherminolVP1;
function SpecificHeatCp_derT "derivative of SpecificHeatCp_t"
  input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
  input Real der_temp "fluid temperature time derivative (K/s)";
  output Real der_cp "specific heat capacity time derivative (J/kgKs)";
protected
    constant Real Cp_c0 = 1981.3598157651504;
    constant Real Cp_c1 = -9.777411226193031;
    constant Real Cp_c2 = 0.04589276204973768;
    constant Real Cp_c3 = -0.0000720330461311355;
    constant Real Cp_c4 = 4.0962689842346755e-8;
algorithm
   der_cp := Cp_c1 * der_temp + 2 * Cp_c2 * temp * der_temp + 3 * Cp_c3 * temp ^ 2 * der_temp + 4 * Cp_c4 * temp ^ 3 * der_temp;
end SpecificHeatCp_derT;
