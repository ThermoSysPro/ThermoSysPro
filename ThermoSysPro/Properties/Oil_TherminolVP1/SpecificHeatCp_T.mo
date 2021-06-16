within ThermoSysPro.Properties.Oil_TherminolVP1;
function SpecificHeatCp_T
  "Specific heat capacity as function of temperature"
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.SpecificHeatCapacity cp "Viscosity (Pa s)";
protected
    constant Real Cp_c0 = 1981.3598157651504;
    constant Real Cp_c1 = -9.777411226193031;
    constant Real Cp_c2 = 0.04589276204973768;
    constant Real Cp_c3 = -0.0000720330461311355;
    constant Real Cp_c4 = 4.0962689842346755e-8;
algorithm
      cp := Cp_c0 + Cp_c1 * temp + Cp_c2 * temp ^ 2 + Cp_c3 * temp ^ 3 + Cp_c4 * temp ^ 4;
   annotation(inverse(temp = Temperature_cp(cp)), derivative = SpecificHeatCp_derT);
end SpecificHeatCp_T;
