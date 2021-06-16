within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_derh
    input Modelica.SIunits.SpecificEnthalpy h "Enthalpy (J/kg)";
    input Real der_h "Enthalpy time derivative (J/(kg*s))";
    output Real der_temp "Fluid temperature time derivative (K/s)";
protected
    constant Real Temperature_c0 = 285.5140346333899;
    constant Real Temperature_c1 = 0.0006466731366692376;
    constant Real Temperature_c2 = -3.306821232762644e-10;
    constant Real Temperature_c3 = 2.2587119472463197e-16;
    constant Real Temperature_c4 = -8.27602313932381e-23;
algorithm
      der_temp := Temperature_c1 * der_h + 2 * Temperature_c2 * h * der_h + 3 * Temperature_c3 * h ^ 2 * der_h + 4 * Temperature_c4 * h ^ 3 * der_h;
end Temperature_derh;
