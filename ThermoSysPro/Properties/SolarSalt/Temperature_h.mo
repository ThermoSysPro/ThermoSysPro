within ThermoSysPro.Properties.SolarSalt;
function Temperature_h
  input Units.SI.SpecificEnthalpy h "Enthalpy (J/kg)";
  output Units.SI.Temperature temp "Fluid temperature (K)";
protected
    constant Real enthC0 = -798297.6386;
    constant Real enthC1 = 1396.02;
    constant Real enthC2 = 0.086;
algorithm
    temp := (-enthC1 + sqrt(enthC1^2 - 4*enthC0*enthC2 + 4*enthC2*h))/(2*enthC2);
  annotation(derivative = Temperature_derh, inverse(h = Enthalpy_T(temp)));
end Temperature_h;
