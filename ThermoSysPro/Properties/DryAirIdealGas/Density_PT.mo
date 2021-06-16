within ThermoSysPro.Properties.DryAirIdealGas;
function Density_PT "Density computation for Dry Air Ideal Gas (input P, T)"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.Pressure P;
  input Modelica.SIunits.Temperature T "Temperature (K)";

  output Modelica.SIunits.Density rho;

protected
  ThermoSysPro.Properties.DryAirIdealGas.DryAirIdealGas Data;

algorithm
  rho := P / (Data.specificGasConstant * T);

//annotation(inverse(p = Pressure_rhot_calc(rho,temp), temp = Temperature_rhop_calc(rho,p)), derivative = Density_derpt_calc);
annotation(derivative = derDensity_derP_derT);
end Density_PT;
