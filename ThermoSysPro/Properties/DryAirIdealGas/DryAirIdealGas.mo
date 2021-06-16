within ThermoSysPro.Properties.DryAirIdealGas;
record DryAirIdealGas "Data for Dry Air Ideal Gas from STEPHANIE Library"
  // STEPHANIE Dry Air Ideal Gas
  // "Air Data Package - valid temperature ranges 200K - 1000K and 1000K - 6000K. Source: NASA/TP-2002-211556 Coefficients for Calculating Thermodynamic Properties"

// Data package
  String idealGasName = "Air -N2 78.08 -O2 20.95 -Ar 0.94 -CO2 0.03 percent";
  Real molarMass = 0.0289651;
  Modelica.SIunits.SpecificEnthalpy enthalpyOfFormation = -4333.836;
  Modelica.SIunits.SpecificEnthalpy enthalpyReference = 298609.8443;
  Real limitTemperature = 1000;
  Real alow[:] = {10099.5016,-196.827561,5.00915511,-0.00576101373,1.06685993e-5,-7.94029797e-9,2.18523191e-12};
  Real blow[:] = {-176.796731,-3.921504225};
  Real ahigh[:] = {241521.443,-1257.8746,5.14455867,-0.000213854179,7.06522784e-8,-1.07148349e-11,6.57780015e-16};
  Real bhigh[:] = {6462.26319,-8.147411905};
  Real specificGasConstant = 287.051225;

// extends PartialIdealSingleGas (ie: ajouté à PartialIdealSingleGas)
  String mediumName = "Dry Air";
  Boolean compressible = true;
  Modelica.SIunits.Temperature maximum_temperature = 1000;
  Modelica.SIunits.Temperature minimum_temperature = 200;
  Modelica.SIunits.Temperature reference_temperature = 302.45;
  Modelica.SIunits.Pressure pressure_default = 101325;
  Modelica.SIunits.SpecificEnthalpy enthalpy_default = 300415.551249572
    "Default value for enthalpy (@ 323ºC) of medium (for initialization)";
    //=ThermoSysPro.Properties.DryAirIdealGas.SpecificEnthalpy_T(T=(323+273.15))

end DryAirIdealGas;
