within ThermoSysPro.Properties.DryAirIdealGas;
function derDensity_derP_derT
  "der(Density) computation for Dry Air Ideal Gas (inputs: P, T, der(P), der(T))"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.Pressure P;
  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Real der_P "pressure time derivative (Pa/s)";
  input Real der_T "Temperature time derivative (K/s)";

  output Real der_rho "density time derivative (kg/(m3*s))";

protected
  ThermoSysPro.Properties.DryAirIdealGas.DryAirIdealGas Data;

algorithm
//-> der_density = partial derivative of density with respect to pressure * der_pressure +
//                 partial derivative of density with respect to temperature *der_temperature
  der_rho := (1 / (Data.specificGasConstant * T)) * der_P + (- P / (Data.specificGasConstant * T^2)) * der_T;

end derDensity_derP_derT;
