within ThermoSysPro.Properties.SolarSalt;
function Enthalpy_T
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.SpecificEnthalpy h "Enthalpy (J/kg)";
protected
    constant Real Enthalpy_c0 = -798297.6386;
    constant Real Enthalpy_c1 = 1396.0182;
    constant Real Enthalpy_c2 = 0.086;
algorithm
     h := Enthalpy_c0 + Enthalpy_c1*temp + Enthalpy_c2*temp^2;
  annotation(derivative = Enthalpy_derT, inverse(temp = Temperature_h(h)));
end Enthalpy_T;
