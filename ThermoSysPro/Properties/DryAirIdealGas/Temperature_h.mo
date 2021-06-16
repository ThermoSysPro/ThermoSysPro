within ThermoSysPro.Properties.DryAirIdealGas;
function Temperature_h
  "Temperature computation for Dry Air Ideal Gas (input h)"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy (J/kg)";
  output Modelica.SIunits.Temperature T "Temperature (K)";

protected
  constant Real C[6] = {302.45170074922396, 0.0009955239553877519,-2.3667518904940937e-11,-1.6218505689880788e-16,1.5436079535175405e-22,-4.4309458281550505e-29};
  //constants C[6] obtained from inverting SpecificEnthalpy_t (through polynomial fitting) it's not the exact inverse function!

algorithm
  T := C[1] + C[2]*h + C[3]*h^2 + C[4]*h^3 + C[5]*h^4 + C[6]*h^5;

  annotation(derivative = derTemperature_derh, inverse(h = SpecificEnthalpy_T(T)));
end Temperature_h;
