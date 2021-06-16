within ThermoSysPro.Properties.MoltenSalt;
function SpecificEnthalpy_T "Specific Enthalpy computation for Salt (input T)"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  output Modelica.SIunits.SpecificEnthalpy h "Specific Enthalpy (J/kg)";

// STEPHANIE SQMSolarSalt
protected
  constant Real Enthalpy_c0 = -809884.394575425;
  constant Real Enthalpy_c1 = 1516.31623195732;
  constant Real enthC0 = -798297.6386;
  constant Real enthC1 = 1396.02;
  constant Real enthC2 = 0.086;

algorithm
  // T in K; h in J/kg ;

  // h = 43801 for T=563K => Error For T= 505 h= -44000
  //  STEPHANIE SQMSolarSalt: properties from manufacturer tables
  // h:=Enthalpy_c0 + Enthalpy_c1 * T;

  //New h = 14919.9 for T=563K => Error For T= 505 h= - ????
  //h := -798297.6386 + 1396.0182*T + 0.086*T^2;
  //h := enthC0 + enthC1*T + enthC2*T^2;

  // T  in K and h in J/kg ;
  //Sam
  ///////////////////////////////////////////////////////////////////////////////////////
  //case(18)    !Nitrate Salt, [kg/m3]
  //xlo=493.; xhi=866.;     : Reduced freezing temp to 220C (493.15K),
  //reference http://www.nrel.gov/csp/troughnet/pdfs/40028.pdf
  //
  ///////////   ********************* Nitrate Salt ***********************   ///////////
  //
  //H_salt = ......;
  h :=1443*(T - 273.16) + 0.086*(T - 273.16)*(T - 273.16);

annotation(derivative = derSpecificEnthalpy_derT, inverse(T = Temperature_h(h)));
end SpecificEnthalpy_T;
