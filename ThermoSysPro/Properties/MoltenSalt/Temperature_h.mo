within ThermoSysPro.Properties.MoltenSalt;
function Temperature_h "Temperature computation for Salt (input h)"

  input Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy (J/kg)";
  output Modelica.SIunits.Temperature T "Temperature (K)";

// STEPHANIE SolarSalt
protected
  constant Real enthC0 = -798297.6386;
  constant Real enthC1 = 1396.02;
  constant Real enthC2 = 0.086;

// STEPHANIE SQMSolarSalt
  constant Real Temperature_c0 = 534.117625216440;
  constant Real Temperature_c1 = 0.000659475113943680;

algorithm
  // T in K; h in J/kg ;
  // STEPHANIE SQMSolarSalt: properties from manufacturer tables
  //T := Temperature_c0 + Temperature_c1 * h;  //  STEPHANIE SQMSolarSalt

  //Error T= 563K for h= 43801 => T calculated with the function = 582.3 K(>>)
  //T := (-enthC1 + sqrt(enthC1^2 - 4*enthC0*enthC2 + 4*enthC2*h))/(2*enthC2);  // STEPHANIE SolarSalt
  //T := max((-enthC1 + sqrt(enthC1^2 - 4*enthC0*enthC2 + 4*enthC2*h))/(2*enthC2), 300);  // STEPHANIE SolarSalt

  // T  in K and h in J/kg ;
  //Sam
  ///////////////////////////////////////////////////////////////////////////////////////
  //case(18)    !Nitrate Salt, [kg/m3]
  //xlo=493.; xhi=866.;     : Reduced freezing temp to 220C (493.15K),
  //reference http://www.nrel.gov/csp/troughnet/pdfs/40028.pdf
  //
  ///////////   ********************* Nitrate Salt ***********************   ///////////
  //

  T := (-0.0000000000262 * h^2 + 0.0006923 * h + 0.03058) + 273.16;

  annotation(derivative = derTemperature_derh);
end Temperature_h;
