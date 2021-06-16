within ThermoSysPro.Properties.DryAirIdealGas;
function SpecificHeatCp_derT
  "der(Specific Heat Capacity at fixed P) computation for Dry Air Ideal Gas (inputs: T, der(T))"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Real der_T "Temperature time derivative (K/s)";

  output Real der_Cp "Specific Heat Capacity time derivative (J/kg/K/s)";

protected
  ThermoSysPro.Properties.DryAirIdealGas.DryAirIdealGas Data;

algorithm
  //der_Cp(T) = (-2*a1*T^(-3) - a2*T^(-2) + a4 + 2*a5*T + 3*a6*T^(2) + 4*a7*T^(3))*R*der_temp;
  der_Cp := (-2*Data.alow[1]*T^(-3) - Data.alow[2]*T^(-2) + Data.alow[4] + 2*Data.alow[5]*T + 3*Data.alow[6]*T^(2) + 4*Data.alow[7]*T^(3))*Data.specificGasConstant*der_T;

end SpecificHeatCp_derT;
