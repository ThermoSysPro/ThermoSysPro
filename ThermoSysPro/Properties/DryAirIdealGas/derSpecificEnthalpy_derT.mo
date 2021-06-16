within ThermoSysPro.Properties.DryAirIdealGas;
function derSpecificEnthalpy_derT
  "der(SpecificEnthalpy) computation for Dry Air Ideal Gas (inputs: T, der(T))"
  // STEPHANIE Dry Air Ideal Gas

    input Modelica.SIunits.Temperature T "Temperature (K)";
    input Real der_T "Temperature time derivative (K/s)";

    output Real der_h "Specific Enthalpy time derivative (J/(kg*s))";

protected
    ThermoSysPro.Properties.DryAirIdealGas.DryAirIdealGas Data;

algorithm
   // ideal gas: dh/dT = cp     ->  der_h = cp(T)*der_T
   der_h := Data.specificGasConstant*(Data.alow[1]*T^(-2) + Data.alow[2]*T^(-1) + Data.alow[3] + Data.alow[4]*T + Data.alow[5]*T^(2) + Data.alow[6]*T^(3) + Data.alow[7]*T^(4))*der_T;

end derSpecificEnthalpy_derT;
