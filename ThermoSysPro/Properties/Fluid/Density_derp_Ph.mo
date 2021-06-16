within ThermoSysPro.Properties.Fluid;
function Density_derp_Ph
  "Density derivative w.r.t pressure computation for all fluids (inputs: P, h, fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.DerDensityByPressure ddph
    "density derivative by pressure";

protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro annotation (Placement(
        transformation(extent={{-80,40},{-40,80}}, rotation=0)));

protected
  Modelica.SIunits.AbsolutePressure delta_P = 0.0001*P;

algorithm
  // Water/Steam
  if fluid==1 then
    pro := ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(
      P,
      h,
      mode);
    ddph:=pro.ddph;

  // C3H3F5

  elseif fluid==2 then
    // The properties are independents of the pressure
    // **********************************************
    // u := ThermoSysPro.Properties.C3H3F5.SpecificInternalEnergy_Ph__NonFonctionnel(
    //   P=P, h=h);
    ddph := 1e-8;

  // FlueGas
  elseif fluid==3 then
    assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==2, vérifie que les fractions massiques sont bien fournies en Input)
    ddph := ThermoSysPro.Properties.FlueGases.FlueGases_drhodp(
      PMF=P,
      TMF=ThermoSysPro.Properties.FlueGases.FlueGases_T(
        PMF=P,
        HMF=h,
        Xco2=Xco2,
        Xh2o=Xh2o,
        Xo2=Xo2,
        Xso2=Xso2),
      Xco2=Xco2,
      Xh2o=Xh2o,
      Xo2=Xo2,
      Xso2=Xso2);

  // MoltenSalt
  elseif fluid==4 then
    // The properties are independents of the pressure
    // **********************************************
    //ddph := 1/h;
    ddph := 1e-8;
    // u := ThermoSysPro.Properties.MoltenSalt.SpecificInternalEnergy_T__NonFonctionnel(
    //   T=ThermoSysPro.Properties.MoltenSalt.Temperature_h(h=h));
//
  // Oil
  elseif fluid==5 then
    // The properties are independent of the pressure
    // **********************************************
    ddph := 1e-8;
//    ddph := (ThermoSysPro.Properties.Oil_TherminolVP1.Density_t(temp=ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h))
//        -ThermoSysPro.Properties.Oil_TherminolVP1.Density_t(temp=ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h)))
//      /(2*delta_P) + 0.000001;

  // DryAirIdealGas
  elseif fluid==6 then
    ddph := (ThermoSysPro.Properties.DryAirIdealGas.Density_PT(P=P+delta_P, T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h))
        -ThermoSysPro.Properties.DryAirIdealGas.Density_PT(P=P-delta_P, T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h)))
      /(2*delta_P);

  // Water/Steam Simple
  elseif  fluid==7 then
    pro := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_Ph(
      P,
      h,
      mode);
    ddph:=pro.ddph;

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end Density_derp_Ph;
