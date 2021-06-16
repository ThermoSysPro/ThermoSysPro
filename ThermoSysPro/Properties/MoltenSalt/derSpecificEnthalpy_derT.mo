within ThermoSysPro.Properties.MoltenSalt;
function derSpecificEnthalpy_derT
  "der(Specific Enthalpy) computation for Salt (inputs: T, der(T))"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Real der_temp "Temperature time derivative (K/s)";

  output Real der_h "Specific Enthalpy time derivative (J/(kg*s))";

// STEPHANIE SQMSolarSalt
protected
  constant Real Enthalpy_c0 = -809884.394575425;
  constant Real Enthalpy_c1 = 1516.31623195732;

algorithm
  der_h := Enthalpy_c1 * der_temp;

end derSpecificEnthalpy_derT;
