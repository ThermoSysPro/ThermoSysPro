within ThermoSysPro.Properties.DryAirIdealGas;
function derTemperature_derh
  "der(Temperature) computation for Dry Air Ideal Gas (inputs: h, der(h))"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy (J/kg)";
  input Real der_h "Specific Enthalpy time derivative (J/(kg*s))";

  output Real der_T "Fluid temperature time derivative (K/s)";

protected
  constant Real C[6] = {302.45170074922396, 0.0009955239553877519,-2.3667518904940937e-11,-1.6218505689880788e-16,1.5436079535175405e-22,-4.4309458281550505e-29};
  //constants C[6] obtained from inverting SpecificEnthalpy_t (through polynomial fitting) it's not the exact inverse function!

algorithm
  der_T := (C[2] + 2*C[3]*h + 3*C[4]*h^2 + 4*C[5]*h^3 + 5*C[6]*h^4)*der_h;

end derTemperature_derh;
