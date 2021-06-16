within ThermoSysPro.Properties.Oil_TherminolVP1;
function ThermalConductivity_T
  "thermal conductivity as function of fluid temperature"
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.ThermalConductivity k "Viscosity (Pa s)";
protected
    constant Real Conductivity_c0 = 0.1511294630021525;
    constant Real Conductivity_c1 = -0.000010409515731161305;
    constant Real Conductivity_c2 = -1.1882172412077911e-7;
    constant Real Conductivity_c3 = -7.181361572348715e-11;
    constant Real Conductivity_c4 = 3.5395680933870214e-14;
algorithm
      k := Conductivity_c0 + Conductivity_c1 * temp + Conductivity_c2 * temp ^ 2 + Conductivity_c3 * temp ^ 3 + Conductivity_c4 * temp ^ 4;
  annotation(inverse(temp = Temperature_k(k)), derivative = ThermalConductivity_derT);
end ThermalConductivity_T;
