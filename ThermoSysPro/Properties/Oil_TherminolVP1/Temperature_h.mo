within ThermoSysPro.Properties.Oil_TherminolVP1;
function Temperature_h
    input Modelica.SIunits.SpecificEnthalpy h "Enthalpy (J/kg)";
    output Modelica.SIunits.Temperature temp "Fluid temperature (K)";
protected
    constant Real Temperature_c0 = 285.5140346333899;
    constant Real Temperature_c1 = 0.0006466731366692376;
    constant Real Temperature_c2 = -3.306821232762644e-10;
    constant Real Temperature_c3 = 2.2587119472463197e-16;
    constant Real Temperature_c4 = -8.27602313932381e-23;
algorithm
      temp := Temperature_c0 + Temperature_c1 * h + Temperature_c2 * h ^ 2 + Temperature_c3 * h ^ 3 + Temperature_c4 * h ^ 4;
  annotation(derivative = Temperature_derh, inverse(h = Enthalpy_T(temp)));
end Temperature_h;
