within ThermoSysPro.Properties.DryAirIdealGas;
function SpecificEnthalpy_T
  "Specific Enthalpy computation for Dry Air Ideal Gas (input T)"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.Temperature T "Temperature (K)";
  output Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy (J/kg)";

protected
  ThermoSysPro.Properties.DryAirIdealGas.DryAirIdealGas Data;

algorithm
 //H(T)/RT = -a1*T^(-2) + a2*lnT/T + a3 + a4*T/2 + a5*T^(2)/3 + a6*T^(3)/4 + a7*T^(4)/5 + b1/T
   h := (-Data.alow[1]*T^(-2) + Data.alow[2]*Modelica.Math.log(T)/T + Data.alow[3] + Data.alow[4]*T/2 + Data.alow[5]*T^(2)/3 + Data.alow[6]*T^(3)/4 + Data.alow[7]*T^(4)/5 + Data.blow[1]/T)*T*Data.specificGasConstant;

  annotation(derivative = derSpecificEnthalpy_derT, inverse(T = Temperature_h(h)));
end SpecificEnthalpy_T;
