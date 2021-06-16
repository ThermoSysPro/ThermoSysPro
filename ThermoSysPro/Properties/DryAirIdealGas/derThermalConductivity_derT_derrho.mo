within ThermoSysPro.Properties.DryAirIdealGas;
function derThermalConductivity_derT_derrho
  "der(Thermal Conductivity) computation for Dry Air Ideal Gas (inputs: T, rho, der(T), der(rho))"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Modelica.SIunits.Density rho "Density (kg/m3)";
  input Real der_T "Temperature time derivative (K/s)";
  input Real der_rho "Density time derivative (kg/m3/s)";

  output Real der_k "thermal conductivity time derivative (W/m/K/s)";

protected
    constant Modelica.SIunits.Temperature tnorm = 132.5 "critical temperature";
    constant Modelica.SIunits.Density rhonorm = 314.3 "critical density";
    constant Real lambda = 25.9778e-3;
    constant Real C1 = 0.239503;
    constant Real C05 = 0.00649768;
    constant Real C0 = 1;
    constant Real C_1 = -1.92615;
    constant Real C_2 = 2.00383;
    constant Real C_3 = -1.07553;
    constant Real C_4 = 0.229414;
    constant Real D1 = 0.402287;
    constant Real D2 = 0.356603;
    constant Real D3 = -0.163159;
    constant Real D4 = 0.138059;
    constant Real D5 = -0.0201725;

algorithm
  // der_k = partial derivative of k with respect to T times der_T + partial derivative of k with respect to rho times der_rho
  // der_k = derivative of diluteConductivity*lambda with respect to T times der_T + derivative of residualConductivity*lambda with respect to rho times der_rho

    der_k := (lambda*(C1/tnorm + C05/(2*sqrt(T/tnorm)*tnorm) - (C_1*tnorm)/T^2 - (2*C_2*tnorm^2)/T^3 - (3*C_3*tnorm^3)/T^4 - (4*C_4*tnorm^4)/T^5))*der_T +
             (lambda*((5*D5*rho^4)/rhonorm^5 + (4*D4*rho^3)/rhonorm^4 + (3*D3*rho^2)/rhonorm^3 + (2*D2*rho)/rhonorm^2 + D1/rhonorm))*der_rho;

end derThermalConductivity_derT_derrho;
