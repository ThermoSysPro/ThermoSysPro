within ThermoSysPro.Properties.Fluid;
function SpecificEnthalpy_PT "Specific Enthalpy computation for all fluids (inputs: P, T, fluid)"

  input Units.SI.AbsolutePressure P "Pressure (Pa)";
  input Units.SI.Temperature T "Temperature (K)";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Units.SI.SpecificEnthalpy h "Specific enthalpy (J/kg)";

algorithm
  // IF97 water/steam
  if fluid == 1 then
    h := ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(p=P, T=T, mode=mode);

  // C3H3F5
  elseif fluid == 2 then
    assert(false, "For fluid = 2 (C3H3F5), function SpecificEnthalpy_PT is not available");
    //h := ThermoSysPro.Properties.C3H3F5.Enthalpy_PT(P=P, T=T);

  // Flue gases
  elseif fluid == 3 then
    /*
    LogVariable(mode);
    LogVariable(P);
    LogVariable(h);
    LogVariable(Xco2);
    LogVariable(Xh2o);
    LogVariable(Xo2);
    LogVariable(Xso2);
   */
     assert(Xco2 + Xh2o + Xo2 + Xso2 > 0, "Wrong mass fraction definition");  // If fluid == 3, check that mass fractions are correctly provided as inputs
     h := ThermoSysPro.Properties.FlueGases.FlueGases_h(
       PMF=P,
       TMF=T,
       Xco2=Xco2,
       Xh2o=Xh2o,
       Xo2=Xo2,
       Xso2=Xso2);

  // Molten salt
  elseif fluid == 4 then
    h := ThermoSysPro.Properties.MoltenSalt.SpecificEnthalpy_T(T=T);

  // Oil
  elseif fluid == 5 then
    h := ThermoSysPro.Properties.Oil_TherminolVP1.Enthalpy_T(temp=T);

  // Dry air ideal gas
  elseif fluid == 6 then
    h := ThermoSysPro.Properties.DryAirIdealGas.SpecificEnthalpy_T(T=T);

  // Simple water/steam
  elseif fluid == 7 then
    h := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.SpecificEnthalpy_PT(p=P, T=T, mode=mode);

  // Wrong fluid number
  else
    assert(false, "SpecificEnthalpy_PT: Incorrect fluid number");  ///
  end if;

  annotation(derivative=derSpecificEnthalpy_derP_derT);
end SpecificEnthalpy_PT;
