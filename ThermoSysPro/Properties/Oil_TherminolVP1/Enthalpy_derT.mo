within ThermoSysPro.Properties.Oil_TherminolVP1;
function Enthalpy_derT
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    input Real der_temp "Fluid temperature time derivative (K/s)";
    output Real der_h "Enthalpy time derivative (J/(kg*s))";
protected
    constant Real Enthalpy_c0 = -293286.3733909648;
    constant Real Enthalpy_c1 = 431.97125303499524;
    constant Real Enthalpy_c2 = 2.4979677783334653;
    constant Real Enthalpy_c3 = -0.001703284072503929;
    constant Real Enthalpy_c4 = 9.291399490444641e-7;
algorithm
      der_h := Enthalpy_c1 * der_temp + 2 * Enthalpy_c2 * temp * der_temp + 3 * Enthalpy_c3 * temp ^ 2 * der_temp +
               4 * Enthalpy_c4 * temp ^ 3 * der_temp;
end Enthalpy_derT;
