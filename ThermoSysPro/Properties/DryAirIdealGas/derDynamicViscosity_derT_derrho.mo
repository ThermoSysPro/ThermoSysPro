within ThermoSysPro.Properties.DryAirIdealGas;
function derDynamicViscosity_derT_derrho
  "der(Dynamic Viscosity) computation for Dry Air Ideal Gas (inputs: T, rho, der(T), der(rho))"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Modelica.SIunits.Density rho "Density (kg/m3)";
  input Real der_T "Temperature time derivative (K/s)";
  input Real der_rho "Density time derivative (kg/m3/s)";

  output Real der_mu "Dynamic Viscosity time derivative (Pa)";

protected
  constant Modelica.SIunits.Temperature tnorm = 132.5 "kritikal temperature";
  constant Modelica.SIunits.Density rhonorm = 314.3 "critical density";
  constant Real H = 6.1609e-6;
  constant Real A1 = 0.128517;
  constant Real A05 = 2.60661;
  constant Real A0 = -1;
  constant Real A_1 = -0.709661;
  constant Real A_2 = 0.662534;
  constant Real A_3 = -0.197846;
  constant Real A_4 = 0.00770147;
  constant Real B1 = 0.465601;
  constant Real B2 = 1.26469;
  constant Real B3 = -0.511425;
  constant Real B4 = 0.2746;

algorithm
    // der_mu = partial derivative of mu with respect to T times der_T + partial derivative of mu with respect to rho times der_rho
    // der_mu = derivative of viscosityZeroDensity*H with respect to T times der_T + derivative of residualViscosity*H with respect to rho times der_rho

    der_mu := (H*(A1/tnorm + A05/(2*sqrt(T/tnorm)*tnorm) - (A_1*tnorm)/T^2 - (2*A_2*tnorm^2)/T^3 - (3*A_3*tnorm^3)/T^4 - (4*A_4*tnorm^4)/T^5))*der_T +
              (H*((4*B4*rho^3)/rhonorm^4 + (3*B3*rho^2)/rhonorm^3 + (2*B2*rho)/rhonorm^2 + B1/rhonorm))*der_rho;

end derDynamicViscosity_derT_derrho;
