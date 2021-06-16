within ThermoSysPro.Properties.Fluid;
function IsentropicExponent_Ph
  "Isentropic Exponent computation for all fluids (inputs: P, h, fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.IsentropicExponent Kappa "Isentropic Exponent (1)";

protected
  ThermoSysPro.Properties.DryAirIdealGas.DryAirIdealGas Data6
    annotation (Placement(transformation(extent={{-20,40},{0,60}}, rotation=0)));

algorithm
  // Water/Steam
  if fluid==1 then
    Kappa := ThermoSysPro.Properties.WaterSteam.IF97_Utilities.Standard.isentropicExponent_ph(p=P, h=h);

  // // C3H3F5
  // elseif fluid==2 then
  //
  // // FlueGas
  // elseif fluid==3 then
  //
  // // MoltenSalt
  // elseif fluid==4 then
  //
  // Oil
  elseif fluid==5 then
    Kappa := 1;

  // Dry Air Ideal Gas
  elseif fluid==6 then
    Kappa := ThermoSysPro.Properties.DryAirIdealGas.SpecificHeatCp_T(T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h))
      / (ThermoSysPro.Properties.DryAirIdealGas.SpecificHeatCp_T(T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h)) - Data6.specificGasConstant);

  // Water/Steam  /// Simple
  elseif fluid==7 then
    //

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end IsentropicExponent_Ph;
