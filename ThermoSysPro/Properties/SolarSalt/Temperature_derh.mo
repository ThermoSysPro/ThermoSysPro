within ThermoSysPro.Properties.SolarSalt;
function Temperature_derh
    input Modelica.SIunits.SpecificEnthalpy h "Enthalpy (J/kg)";
    input Real der_h "Enthalpy time derivative (J/(kg*s))";
    output Real der_temp "Fluid temperature time derivative (K/s)";
protected
    constant Real enthC0 = -798297.6386;
    constant Real enthC1 = 1396.02;
    constant Real enthC2 = 0.086;
algorithm
     der_temp:= 1/sqrt(enthC1^2 - 4*enthC0*enthC2 + 4*enthC2*h)*der_h;
end Temperature_derh;
