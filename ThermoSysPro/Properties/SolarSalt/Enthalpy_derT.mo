within ThermoSysPro.Properties.SolarSalt;
function Enthalpy_derT
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    input Real der_temp "Fluid temperature time derivative (K/s)";
    output Real der_h "Enthalpy time derivative (J/(kg*s))";
protected
    constant Real Enthalpy_c0 = -798297.6386;
    constant Real Enthalpy_c1 = 1396.02;
    constant Real Enthalpy_c2 = 0.086;
algorithm
    der_h := Enthalpy_c1*der_temp + 2*Enthalpy_c2*temp*der_temp;
end Enthalpy_derT;
