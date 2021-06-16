within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_k "inverse function of ThermalConductivity_t"
  input Modelica.SIunits.ThermalConductivity k "Thermal Conductivity";
  output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
    constant Real Temp_c0 = 475.2525031233294;
    constant Real Temp_c1 = 18070.362425348725;
    constant Real Temp_c2 = -358000.4271142386;
    constant Real Temp_c3 = 2.593882865137215e6;
    constant Real Temp_c4 = -7.422767475383265e6;
algorithm
  temp := Temp_c0 + Temp_c1 * k + Temp_c2 * k ^ 2 + Temp_c3 * k ^ 3 + Temp_c4 * k ^ 4;
  annotation(inverse(k = ThermalConductivity_T(temp)), derivative = Temperature_derk);
end Temperature_k;
