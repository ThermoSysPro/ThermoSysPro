within ThermoSysPro.Properties.MoltenSalt;
function DynamicViscosity_T "Dynamic Viscosity computation for Salt (input T)"

  input Modelica.SIunits.Temperature T "Temperature (K)";
  output Modelica.SIunits.DynamicViscosity mu "Dynamic Viscosity (Pa.s)";

algorithm
  //mu :=( 0.0755147595 - 0.00027760398*T + 3.4888693*1e-7*T^2 - 1.4739999*1e-10*T^3);   // temperature in °K

  //New
//    mu := (22.714 - 0.12*(T - 273.15) + 2.281*1e-7*(T - 273.15)**2 - 1.474*1e-10*(T - 273.15)**3);   // temperature in °C
  mu :=if (T<=873.15) then ( 0.0755147595 - 0.00027760398*T + 3.4888693*1e-7*T^2 - 1.4739999*1e-10*T^3) else 0.0009916065819282893;      // temperature in °K

end DynamicViscosity_T;
