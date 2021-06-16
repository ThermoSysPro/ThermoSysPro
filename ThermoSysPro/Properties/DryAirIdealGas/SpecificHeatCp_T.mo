within ThermoSysPro.Properties.DryAirIdealGas;
function SpecificHeatCp_T
  "Specific Heat Capacity at fixed P computation for Dry Air Ideal Gas (input T)"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.Temperature T "Temperature (K)";
  output Modelica.SIunits.SpecificHeatCapacity Cp
    "Specific Heat Capacity (J/kg/K)";

protected
  ThermoSysPro.Properties.DryAirIdealGas.DryAirIdealGas Data;

algorithm
  //Cp(T)/R = a1*T^(-2) + a2*T^(-1) + a3 + a4*T + a5*T^(2) + a6*T^(3) + a7*T^(4)
  Cp := Data.specificGasConstant*(Data.alow[1]*T^(-2) + Data.alow[2]*T^(-1) + Data.alow[3] + Data.alow[4]*T + Data.alow[5]*T^(2) + Data.alow[6]*T^(3) + Data.alow[7]*T^(4));

  //annotation(inverse(temp = Temperature_cp(cp)), derivative = SpecificHeatCp_dert);
  annotation(derivative = SpecificHeatCp_derT);
end SpecificHeatCp_T;
