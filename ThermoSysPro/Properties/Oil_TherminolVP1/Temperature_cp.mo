within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_cp "inverse function of SpecificHeatCp_t"
  input Modelica.SIunits.SpecificHeatCapacity cp
    "Specific Heat Capacity (J/kgK)";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
  constant Real temp_c0 = -1550.799964717781;
  constant Real temp_c1 = 3.2657321743494627;
  constant Real temp_c2 = -0.0024107039957429613;
  constant Real temp_c3 = 8.707277494347506e-7;
  constant Real temp_c4 = -1.15573614609828e-10;
algorithm
   temp := temp_c0 + temp_c1 * cp + temp_c2 * cp ^ 2 + temp_c3 * cp ^ 3 + temp_c4 * cp ^ 4;
   annotation(inverse(cp = SpecificHeatCp_T(temp)), derivative = Temperature_dercp);
end Temperature_cp;
