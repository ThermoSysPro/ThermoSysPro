within ThermoSysPro.Properties.Fluid;
function derDensity_derP_derh
  "der(Density) computation for all fluids (inputs: P, h, der(P), der(h), fluid)"

  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";
  input Real der_P "Pressure time derivative (J/(kg*s))";
  input Real der_h "Specific Enthalpy time derivative (J/(kg*s))";
  input Real der_Xco2=0 "CO2 mass fraction";
  input Real der_Xh2o=0 "H2O mass fraction";
  input Real der_Xo2=0 "O2 mass fraction";
  input Real der_Xso2=0 "SO2 mass fraction";

  output Real der_rho "Density time derivative (kg/(m3*s))";

protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph der_pro annotation (Placement(
        transformation(extent={{-80,40},{-40,80}}, rotation=0)));
protected
  Modelica.SIunits.Temperature T "Temperature (K)";
  Real der_T "Temperature time derivative (K/s)";

///annotation(derivative(order=2)=derderDensity_derderP_derderh);

algorithm
  // Water/Steam
  if fluid==1 then
    der_pro := ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph_der(p=P,h=h,mode=mode,p_der=der_P,h_der=der_h);
    der_rho := der_pro.d;

  // // C3H3F5
  // elseif fluid==2 then
  //   rho := ThermoSysPro.Properties.C3H3F5.Density_Ph(P=P, h=h);
  //
  // // FlueGas
   elseif fluid==3 then
     assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==2, vérifie que les fractions massiques sont bien fournies en Input)
  //   rho := ThermoSysPro.Properties.FlueGases.FlueGases_rho(
  //     PMF=P,
  //     TMF=ThermoSysPro.Properties.FlueGases.FlueGases_T(
  //       PMF=P,
  //       HMF=h,
  //       Xco2=Xco2,
  //       Xh2o=Xh2o,
  //       Xo2=Xo2,
  //       Xso2=Xso2),
  //     Xco2=Xco2,
  //     Xh2o=Xh2o,
  //     Xo2=Xo2,
  //     Xso2=Xso2);

  // MoltenSalt
  //elseif fluid==4 then
  elseif fluid==4 then
    der_T := ThermoSysPro.Properties.MoltenSalt.derTemperature_derh(h=h, der_h=der_h);
    der_rho := ThermoSysPro.Properties.MoltenSalt.derDensity_derT(T=T, der_T=der_T);

  // Oil
  elseif fluid==5 then
    // der_rho := ThermoSysPro.Properties.Oil_TherminolVP1.Density_dert(
    //   temp=ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h),
    //   der_temp=ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_derh(h=h,der_h=der_h));
    T := ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h);
    der_T := ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_derh(h=h,der_h=der_h);
    der_rho := ThermoSysPro.Properties.Oil_TherminolVP1.Density_derT(temp=T, der_temp=der_T);

  // Dry Air Ideal Gas
  elseif fluid==6 then
    der_rho := ThermoSysPro.Properties.DryAirIdealGas.derDensity_derP_derT(P=P,
      T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h),
      der_P=der_P,
      der_T=ThermoSysPro.Properties.DryAirIdealGas.derTemperature_derh(h=h,der_h=der_h));

  // Water/Steam Simple
  elseif  fluid==7 then
    der_pro := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.Water_Ph_der( p=P,h=h,mode=mode,p_der=der_P,h_der=der_h);
    der_rho := der_pro.d;

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end derDensity_derP_derh;
