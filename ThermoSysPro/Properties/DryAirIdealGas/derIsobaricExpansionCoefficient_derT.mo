within ThermoSysPro.Properties.DryAirIdealGas;
function derIsobaricExpansionCoefficient_derT
  "der(Isobaric Expansion Coefficient) computation for Dry Air Ideal Gas (input T, der(T))"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Real der_T "Temperature time derivative (K/s)";

  output Real der_Beta "isobaric expansion coefficient time derivative (1/Ks)";

algorithm
  der_Beta := -1/T^2*der_T;

end derIsobaricExpansionCoefficient_derT;
