within ThermoSysPro.Properties.DryAirIdealGas;
function ThermalConductivity_Trho
  "Thermal Conductivity computation for Dry Air Ideal Gas (inputs: T, rho)"
  //valid up to 100MPa and 2000K, according to Kadoya et al. 1985 (Viscosity and Thermal Conductivity of Dry Air in the Gaseous Phase), Journal of Physical and Chemical Reference Data
  // STEPHANIE Dry Air Ideal Gas

    input Modelica.SIunits.Temperature T "Temperature (K)";
    input Modelica.SIunits.Density rho "Density (kg/m3)";

    output Modelica.SIunits.ThermalConductivity k
    "Thermal Conductivity (W/m/K)";

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
    Modelica.SIunits.Temperature tReduced "dimensionless temperature";
    Modelica.SIunits.Density rhoReduced "dimensionless density";
    Real diluteConductivity;
    Real residualConductivity;

algorithm
     //dilute conductivity
     tReduced := T/tnorm;
     diluteConductivity := C1*tReduced + C05*sqrt(tReduced) + C0 + C_1*tReduced^(-1) + C_2*tReduced^(-2) + C_3*tReduced^(-3) + C_4*tReduced^(-4);
     //residual conductivity
     rhoReduced := rho/rhonorm;
     residualConductivity := D1*rhoReduced + D2*rhoReduced^2 + D3*rhoReduced^3 + D4*rhoReduced^4 + D5*rhoReduced^5;

     k := (diluteConductivity + residualConductivity)*lambda;

  annotation(derivative = derThermalConductivity_derT_derrho);
end ThermalConductivity_Trho;
