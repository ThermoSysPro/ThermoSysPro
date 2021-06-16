within ThermoSysPro.Properties.Oil_TherminolVP1;
function ThermalConductivity_derT "derivative of ThermalConductivity_T"
  input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
  input Real der_temp "fluid temperature time derivative (K/s)";
  output Real der_k "thermal conductivity time derivative (W/mKs)";
protected
    constant Real Conductivity_c0 = 0.1511294630021525;
    constant Real Conductivity_c1 = -0.000010409515731161305;
    constant Real Conductivity_c2 = -1.1882172412077911e-7;
    constant Real Conductivity_c3 = -7.181361572348715e-11;
    constant Real Conductivity_c4 = 3.5395680933870214e-14;
algorithm
    der_k := Conductivity_c1 * der_temp + 2 * Conductivity_c2 * temp * der_temp + 3 * Conductivity_c3 * temp ^ 2 * der_temp
             + 4 * Conductivity_c4 * temp ^ 3 * der_temp;
end ThermalConductivity_derT;
