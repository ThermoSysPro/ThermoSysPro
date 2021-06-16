within ThermoSysPro.Properties.Fluid;
function derSpecificEnthalpy_derP_derT
  "der(Specific enthalpy) computation for all fluids (inputs: P, h, der(P), der(T), fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.Temperature T "Temperature (K)";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";
  input Real der_P "Pressure time derivative";
  input Real der_T "Temperature time derivative";
  input Real der_Xco2=0 "CO2 mass fraction";
  input Real der_Xh2o=0 "H2O mass fraction";
  input Real der_Xo2=0 "O2 mass fraction";
  input Real der_Xso2=0 "SO2 mass fraction";

  output Real der_h "Specific enthalpy time derivative";

protected
  Modelica.SIunits.Duration dt=1;
  Modelica.SIunits.AbsolutePressure delta_P = 0.001*P;
  Modelica.SIunits.TemperatureDifference delta_T = 0.01*T;

/////////////////////////////////////////////////////////////////
  // Water/Steam, C3H3F5, FlueGas, MoltenSalt, Oil, DryAirIdealGas

algorithm
  // // Water/Steam
  if fluid == 1 then
  //   h := ThermoSysPro.Properties.WaterSteam.IF97.SpecificEnthalpy_PT(p=P, T=T, mode=mode);

    der_h :=(ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(
    P=P + delta_P,
    T=T + delta_T,
    fluid=fluid,
    mode=mode,
    Xco2=Xco2,
    Xh2o=Xh2o,
    Xo2=Xo2,
    Xso2=Xso2) - ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(
    P=P - delta_P,
    T=T - delta_T,
    fluid=fluid,
    mode=mode,
    Xco2=Xco2,
    Xh2o=Xh2o,
    Xo2=Xo2,
    Xso2=Xso2))/dt;

  //  LogVariable(der_h);

  // // C3H3F5
  // elseif fluid==2 then
  //   T := ThermoSysPro.Properties.C3H3F5.Temperature_Ph(P=P, h=h);
  //

  // // FlueGas
  elseif fluid==3 then
  //if fluid==3 then
     assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==2, vérifie que les fractions massiques sont bien fournies en Input)
  //   T := ThermoSysPro.Properties.FlueGases.FlueGases_T(
  //     PMF=P,
  //     HMF=h,
  //     Xco2=Xco2,
  //     Xh2o=Xh2o,
  //     Xo2=Xo2,
  //     Xso2=Xso2);

    der_h :=(ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(
    P=P + delta_P,
    T=T + delta_T,
    fluid=fluid,
    mode=mode,
    Xco2=Xco2,
    Xh2o=Xh2o,
    Xo2=Xo2,
    Xso2=Xso2) - ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(
    P=P - delta_P,
    T=T - delta_T,
    fluid=fluid,
    mode=mode,
    Xco2=Xco2,
    Xh2o=Xh2o,
    Xo2=Xo2,
    Xso2=Xso2))/dt;

  // // MoltenSalt
  // elseif fluid==4 then
  //   h := ThermoSysPro.Properties.MoltenSalt.SpecificEnthalpy_T(T=T);
    //der_h :=  1e-9;

  // Oil
  //elseif fluid==5 then
  elseif fluid==5 then
    der_h :=ThermoSysPro.Properties.Oil_TherminolVP1.Enthalpy_derT(temp=T,
      der_temp=der_T);

  // // Dry Air Ideal Gas
  // elseif fluid==6 then
  //   h := ThermoSysPro.Properties.DryAirIdealGas.SpecificEnthalpy_T(T=T);

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end derSpecificEnthalpy_derP_derT;
