within ThermoSysPro.Properties.Fluid;
function IsobaricExpansionCoefficient_Ph
  "Isobaric Expansion Coefficient computation for all fluids (inputs: P, h, fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.CubicExpansionCoefficient Beta
    "Isobaric Expansion Coefficient (1/K)";

algorithm
  // // Water/Steam
  // if fluid==1 then
  //
  // // C3H3F5
  // elseif fluid==2 then
  //
  // // FlueGas
  // elseif fluid==3 then
  //
  // // MoltenSalt
  // elseif fluid==4 then
  //
  // // Oil
  // elseif fluid==5 then

  // Dry Air Ideal Gas
  //elseif fluid==6 then
  if fluid==6 then
    Beta := ThermoSysPro.Properties.DryAirIdealGas.IsobaricExpansionCoefficient_T(
      T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h));

  // Water/Steam  /// Simple
  //elseif fluid==7 then
    //

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end IsobaricExpansionCoefficient_Ph;
