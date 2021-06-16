within ThermoSysPro.Properties.Oil_TherminolVP1;
function Enthalpy_T
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.SpecificEnthalpy h "Enthalpy (J/kg)";
protected
    constant Real Enthalpy_c0 = -293286.3733909648;
    constant Real Enthalpy_c1 = 431.97125303499524;
    constant Real Enthalpy_c2 = 2.4979677783334653;
    constant Real Enthalpy_c3 = -0.001703284072503929;
    constant Real Enthalpy_c4 = 9.291399490444641e-7;
algorithm
      h := Enthalpy_c0 + Enthalpy_c1 * temp + Enthalpy_c2 * temp ^ 2 + Enthalpy_c3 * temp ^ 3 + Enthalpy_c4 * temp ^ 4;
   annotation(derivative = Enthalpy_derT, inverse(temp = Temperature_h(h)));
end Enthalpy_T;
