within ThermoSysPro.Properties.DryAirIdealGas;
function IsobaricExpansionCoefficient_T
  "Isobaric Expansion Coefficient computation for Dry Air Ideal Gas (input T)"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  output Modelica.SIunits.CubicExpansionCoefficient Beta
    "Isobaric Expansion Coefficient (1/K)";

algorithm
  Beta := 1/T;

  annotation(derivative = derIsobaricExpansionCoefficient_derT);
end IsobaricExpansionCoefficient_T;
