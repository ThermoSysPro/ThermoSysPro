within ThermoSysPro.Properties.Oil_TherminolVP1;
function DynamicViscosity_derT
  input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
  input Real der_temp "Fluid temperature time derivative (K/S)";
  output Real der_mu "dynamic viscosity time derivative (Pa)";
protected
    constant Real Viscosity_cm2 = 66476.1563165124;
    constant Real Viscosity_cm1 = -816.2382525469754;
    constant Real Viscosity_c0 = 4.156281383007535;
    constant Real Viscosity_c1 = -0.011190888024556169;
    constant Real Viscosity_c2 = 0.000016779446462464305;
    constant Real Viscosity_c3 = -1.3274228299674058e-8;
    constant Real Viscosity_c4 = 4.327444414811259e-12;
algorithm
    der_mu := -2 * Viscosity_cm2 * temp ^ (-3) * der_temp - 1 * Viscosity_cm1 * temp ^ (-2) * der_temp  + Viscosity_c1 * der_temp
             + 2 * Viscosity_c2 * temp * der_temp + 3 * Viscosity_c3 * temp ^ 2 * der_temp + 4 * Viscosity_c4 * temp ^ 3 * der_temp;
end DynamicViscosity_derT;
