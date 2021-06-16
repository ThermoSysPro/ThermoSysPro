within ThermoSysPro.Properties.DryAirIdealGas;
function DynamicViscosity_Trho
  "Dynamic Viscosity computation for Dry Air Ideal Gas (inputs: T, rho)"
  //valid up to 100MPa and 2000K, according to Kadoya et al. 1985 (Viscosity and Thermal Conductivity of Dry Air in the Gaseous Phase), Journal of Physical and Chemical Reference Data"
  // STEPHANIE Dry Air Ideal Gas

  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Modelica.SIunits.Density rho "Density (kg/m3)";

  output Modelica.SIunits.DynamicViscosity mu "Dynamic Viscosity (Pa.s)";

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
  Real viscosityZeroDensity;
  Modelica.SIunits.Temperature tReduced "dimensionless temperature";
  Modelica.SIunits.Density rhoReduced "dimensionless density";
  Real residualViscosity;

algorithm
 //viscosityZeroDensity:
  tReduced := T/tnorm;
  viscosityZeroDensity := A1*tReduced + A05*sqrt(tReduced) + A0 + A_1*tReduced^(-1) + A_2*tReduced^(-2) + A_3*tReduced^(-3) + A_4*tReduced^(-4);
 //residualViscosity:
  rhoReduced := rho/rhonorm;
  residualViscosity := B1*rhoReduced + B2*rhoReduced^2 + B3*rhoReduced^3 + B4*rhoReduced^4;

  mu := (viscosityZeroDensity + residualViscosity)*H;

  annotation(derivative = derDynamicViscosity_derT_derrho);
end DynamicViscosity_Trho;
