within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_dercp "derivative of Temperature_cp"
  input Modelica.SIunits.SpecificHeatCapacity cp
    "Specific Heat Capacity (J/kgK)";
  input Real der_cp "specific heat capacity time derivative (J/kgKs)";
  output Real der_temp "fluid temperature time derivative (K/s)";
protected
  constant Real temp_c0 = -1550.799964717781;
  constant Real temp_c1 = 3.2657321743494627;
  constant Real temp_c2 = -0.0024107039957429613;
  constant Real temp_c3 = 8.707277494347506e-7;
  constant Real temp_c4 = -1.15573614609828e-10;
algorithm
   der_temp :=  temp_c1 * der_cp + 2 * temp_c2 * cp * der_cp + 3 * temp_c3 * cp ^ 2 * der_cp + 4 * temp_c4 * cp ^ 3 * der_cp;
end Temperature_dercp;
