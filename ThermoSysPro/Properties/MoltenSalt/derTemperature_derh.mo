within ThermoSysPro.Properties.MoltenSalt;
function derTemperature_derh
  "der(Temperature) computation for Salt (input der(h))"

  input Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy (J/kg)";
  input Real der_h "Specific Enthalpy time derivative (J/(kg*s))";
  output Real der_T "Fluid temperature time derivative (K/s)";

protected
    constant Real Temperature_c0 = 534.117625216440;
    constant Real Temperature_c1 = 0.000659475113943680;

algorithm
      der_T:= Temperature_c1 * der_h;  // STEPHANIE SQMSolarSalt
end derTemperature_derh;
