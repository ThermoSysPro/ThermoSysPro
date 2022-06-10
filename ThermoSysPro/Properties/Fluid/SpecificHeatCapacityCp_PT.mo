within ThermoSysPro.Properties.Fluid;
function SpecificHeatCapacityCp_PT
  "Specific Heat Capacity at constant P computation for all fluids (inputs: P, T, fluid)"

  input Units.SI.AbsolutePressure P "Pressure (Pa)";
  input Units.SI.Temperature T "Temperature";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Units.SI.SpecificHeatCapacity cp
    "Specific Heat Capacity at constant P (J/kg/K)";

// fluid==1 - Water/Steam
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_pT pro annotation (Placement(
        transformation(extent={{-80,40},{-40,80}}, rotation=0)));

algorithm
  // Water/Steam
  if fluid==1 then
    pro := ThermoSysPro.Properties.WaterSteam.IF97.Water_PT(P, T, mode);
    cp := pro.cp;

  // C3H3F5
  elseif fluid==2 then
  //   cp :=
  //     ThermoSysPro.Properties.C3H3F5.SpecificHeatCapacityCp_Ph__NonFonctionnel(
  //     P=P, h=h);
    assert(false, "?????????? fluid = 2: the function SpecificHeatCapacityCp_PT is not available; incorrect option ?????????");

  // FlueGas
  elseif fluid==3 then
    assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==2, vérifie que les fractions massiques sont bien fournies en Input)
    cp := ThermoSysPro.Properties.FlueGases.FlueGases_cp(
      PMF=P,
      TMF=T,
      Xco2=Xco2,
      Xh2o=Xh2o,
      Xo2=Xo2,
      Xso2=Xso2);

  // MoltenSalt
  elseif fluid==4 then
    cp := ThermoSysPro.Properties.MoltenSalt.SpecificHeatCapacityCp_T(T=T);

  // Oil
  elseif fluid==5 then
    cp := ThermoSysPro.Properties.Oil_TherminolVP1.SpecificHeatCp_T(temp=T);

  // Water/Steam
  elseif fluid==7 then
    pro := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_PT(P, T, mode);
    cp := pro.cp;

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end SpecificHeatCapacityCp_PT;
