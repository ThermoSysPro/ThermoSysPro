within ThermoSysPro.Properties.Fluid;
function Reynolds_vrhoDmu
  "Reynolds number computation for all fluids (inputs: v, rho, D, mu, fluid)"

  input Modelica.SIunits.Velocity v "Mean velocity of fluid flow";
  input Modelica.SIunits.Density rho "Fluid density";
  input Modelica.SIunits.Length D
    "Characteristic dimension (hydraulic diameter of pipes)";
  input Modelica.SIunits.DynamicViscosity mu "Dynamic (absolute) viscosity";

  //  input Integer fluid
  //  "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  // input Integer mode=0 "IF97 region - 0:automatic computation";
  // input Real Xco2=0 "CO2 mass fraction";
  // input Real Xh2o=0 "H2O mass fraction";
  // input Real Xo2=0 "O2 mass fraction";
  // input Real Xso2=0 "SO2 mass fraction";

  output Modelica.SIunits.ReynoldsNumber Re "Reynolds number";

algorithm
  ///////////////////////////////////// FONCTIONNE EN DIPHASIQUE ???
  Re := abs(v)*rho*D/mu;

end Reynolds_vrhoDmu;
