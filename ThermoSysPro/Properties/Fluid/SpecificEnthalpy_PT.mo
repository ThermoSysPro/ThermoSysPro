within ThermoSysPro.Properties.Fluid;
function SpecificEnthalpy_PT
  "Specific Enthalpy computation for all fluids (inputs: P, T, fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";

  output Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy (J/kg)";

algorithm
  // Water/Steam
  if fluid==1 then
    h := ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(p=P, T=T, mode=mode);

  // C3H3F5
   elseif fluid==2 then
    assert(false, "?????????? fluid = 2: the function SpecificEnthalpy_PT is not available; incorrect option ?????????");
    //h := ThermoSysPro.Properties.C3H3F5.Enthalpy_PT(P=P, T=T);

    //assert(fluid =2, "Wrong: fluid = 2 ");  /// fluid = 2: the function is not available en Input)

  //
  // FlueGas
   elseif fluid==3 then

    /*
    LogVariable(mode);
    LogVariable(P);
    LogVariable(h);
    LogVariable(Xco2);
    LogVariable(Xh2o);
    LogVariable(Xo2);
    LogVariable(Xso2);
   */
     assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==3, vérifie que les fractions massiques sont bien fournies en Input)
     h := ThermoSysPro.Properties.FlueGases.FlueGases_h(
       PMF=P,
       TMF=T,
       Xco2=Xco2,
       Xh2o=Xh2o,
       Xo2=Xo2,
       Xso2=Xso2);

  // MoltenSalt
  elseif fluid==4 then
    h := ThermoSysPro.Properties.MoltenSalt.SpecificEnthalpy_T(T=T);

  // Oil
  elseif fluid==5 then
    h := ThermoSysPro.Properties.Oil_TherminolVP1.Enthalpy_T(temp=T);

  // Dry Air Ideal Gas
  elseif fluid==6 then
    h := ThermoSysPro.Properties.DryAirIdealGas.SpecificEnthalpy_T(T=T);

  // Water/Steam
  elseif fluid==7 then
    h := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.SpecificEnthalpy_PT(p=P, T=T, mode=mode);

  else
    assert(false, "incorrect fluid number");  ///
  end if;

  annotation(derivative=derSpecificEnthalpy_derP_derT);
end SpecificEnthalpy_PT;
