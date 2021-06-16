within ThermoSysPro.Properties.Oil_TherminolVP1;
function DynamicViscosity_T
    input Modelica.SIunits.Temperature temp "Fluid temperature (K)";
    output Modelica.SIunits.DynamicViscosity mu "Viscosity (Pa.s)";

protected
    constant Real Viscosity_cm2 = 66476.1563165124;
    constant Real Viscosity_cm1 = -816.2382525469754;
    constant Real Viscosity_c0 = 4.156281383007535;
    constant Real Viscosity_c1 = -0.011190888024556169;
    constant Real Viscosity_c2 = 0.000016779446462464305;
    constant Real Viscosity_c3 = -1.3274228299674058e-8;
    constant Real Viscosity_c4 = 4.327444414811259e-12;
algorithm
      mu := Viscosity_cm2 * temp ^ (-2) + Viscosity_cm1 * temp ^ (-1) + Viscosity_c0 + Viscosity_c1 * temp + Viscosity_c2 * temp ^ 2
            + Viscosity_c3 * temp ^ 3 + Viscosity_c4 * temp ^ 4;
   annotation(derivative = DynamicViscosity_derT);
end DynamicViscosity_T;
