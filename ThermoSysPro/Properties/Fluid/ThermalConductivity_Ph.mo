within ThermoSysPro.Properties.Fluid;
function ThermalConductivity_Ph
  "Thermal Conductivity computation for all fluids (inputs: P, h, fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.ThermalConductivity k "Thermal Conductivity (W/m/K)";
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro annotation (Placement(
        transformation(extent={{-80,40},{-40,80}}, rotation=0)));

algorithm
  // Water/Steam  /// FONCTIONNE EN DIPHASIQUE ???
  if fluid==1 then
    pro := ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(
      P,
      h,
      mode);
    k := ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rho=pro.d,T=pro.T,P=P,region=mode);

  // C3H3F5
  elseif fluid==2 then
  //   k := ThermoSysPro.Properties.C3H3F5.ThermalConductivity_Ph__NonFonctionnel(
  //     P=P, h=h);
    assert(false, "?????????? fluid = 2: the function ThermalConductivity_Ph is not available; incorrect option ?????????");

  // FlueGas
  elseif fluid==3 then
    assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==2, vérifie que les fractions massiques sont bien fournies en Input)
    k := ThermoSysPro.Properties.FlueGases.FlueGases_k(
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
    k := ThermoSysPro.Properties.MoltenSalt.ThermalConductivity_T(T=
      ThermoSysPro.Properties.MoltenSalt.Temperature_h(h=h));

  // Oil
  elseif fluid==5 then
    k := ThermoSysPro.Properties.Oil_TherminolVP1.ThermalConductivity_T(temp=
      ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h));

  // Dry Air Ideal Gas
  elseif fluid==6 then
    k := ThermoSysPro.Properties.DryAirIdealGas.ThermalConductivity_Trho(
      T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h),
      rho=ThermoSysPro.Properties.DryAirIdealGas.Density_PT(
        P=P, T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h)));

  // Water/Steam Simple
  elseif  fluid==7 then
    pro := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_Ph(
      P,
      h,
      mode);
    k := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.ThermalConductivity_rhoT(rho=pro.d,T=pro.T);

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end ThermalConductivity_Ph;
