within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_derk "derivative of Temperature_k"
  input Modelica.SIunits.ThermalConductivity k "Thermal Conductivity (W/mK)";
  input Real der_k "thermal conductivity time derivative (W/mKs)";
  output Real der_temp "fluid temperature time derivative";
protected
    constant Real Temp_c0 = 475.2525031233294;
    constant Real Temp_c1 = 18070.362425348725;
    constant Real Temp_c2 = -358000.4271142386;
    constant Real Temp_c3 = 2.593882865137215e6;
    constant Real Temp_c4 = -7.422767475383265e6;
algorithm
   der_temp := Temp_c1 * der_k + 2 * Temp_c2 * k * der_k + 3 * Temp_c3 * k ^ 2 * der_k + 4 * Temp_c4 * k ^ 3 * der_k;
end Temperature_derk;
