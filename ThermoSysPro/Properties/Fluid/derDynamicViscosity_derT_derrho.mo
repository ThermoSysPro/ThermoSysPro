within ThermoSysPro.Properties.Fluid;
function derDynamicViscosity_derT_derrho
  "Dynamic Viscosity computation for all fluids"

  input Modelica.SIunits.Density rho "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam <br>2 - C3H3F5 <br>3 - FlueGases <br>4 - MoltenSalt <br>5 - Oil <br>6 - DryAirIdealGas <br>7 - WaterSteamSimple </html>";
  input Integer mode "IF97 region - 0:automatic computation";
  input Real Xco2 "CO2 mass fraction";
  input Real Xh2o "H2O mass fraction";
  input Real Xo2 "O2 mass fraction";
  input Real Xso2 "SO2 mass fraction";
  input Real der_rho "Density time derivative";
  input Real der_T "Temperature time derivative";
  input Real der_Xco2=0 "CO2 mass fraction";
  input Real der_Xh2o=0 "H2O mass fraction";
  input Real der_Xo2=0 "O2 mass fraction";
  input Real der_Xso2=0 "SO2 mass fraction";

  output Real der_mu "Dynamic Viscosity time derivative";

  constant Real Viscosity_c0 = 0.07551475951333098;
  constant Real Viscosity_c1 = - 0.00027760397992950003;
  constant Real Viscosity_c2 = 0.00000034888693;
  constant Real Viscosity_c3 = - 0.00000000014739999;

  //Modelica.SIunits.Duration dt=1;
  //Modelica.SIunits.AbsolutePressure delta_rho = 0.01*rho;
  //Modelica.SIunits.SpecificEnthalpy delta_T = 0.01*T;

algorithm
  // Water/Steam  /// FONCTIONNE EN DIPHASIQUE ???
  //if fluid==1 then




    //der_mu := 0.0;




  // C3H3F5
  // elseif fluid==2 then
  //   mu := ThermoSysPro.Properties.C3H3F5.DynamicViscosity_Ph__NonFonctionnel(P=
  //     P, h=h);

  // FlueGas
  // elseif fluid==3 then
  if fluid==3 then
     assert(Xco2+Xh2o+Xo2+Xso2>0, "Wrong mass fraction definition");  /// Commentaire ajouté (si fluid==2, vérifie que les fractions massiques sont bien fournies en Input)
  //   mu := ThermoSysPro.Properties.FlueGases.FlueGases_mu(
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
  // elseif fluid==4 then
  //   mu := ThermoSysPro.Properties.MoltenSalt.DynamicViscosity_T(T=
  //     ThermoSysPro.Properties.MoltenSalt.Temperature_h(h=h));

  // Oil
  //elseif fluid==5 then
  elseif fluid==4 then
    //der_mu := Viscosity_c1*ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_derh(h=h,der_h=der_h) + 2*Viscosity_c2*ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h)*ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_derh(h=h,der_h=der_h) + 3*Viscosity_c3*(ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h))^2*ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_derh(h=h,der_h=der_h);
/*    der_mu := ThermoSysPro.Properties.MoltenSalt.DynamicViscosity_dert(
      temp=ThermoSysPro.Properties.MoltenSalt.Temperature_h(h=h),
      der_temp=ThermoSysPro.Properties.MoltenSalt.Temperature_derh(h=h,der_h=der_h));
*/
  elseif fluid==5 then
/*    der_mu := ThermoSysPro.Properties.Oil_TherminolVP1.DynamicViscosity_dert(
      temp=ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_h(h=h),
      der_temp=ThermoSysPro.Properties.Oil_TherminolVP1.Temperature_derh(h=h,der_h=der_h));
*/
  // Dry Air Ideal Gas
  // elseif fluid==6 then
  //   mu := ThermoSysPro.Properties.DryAirIdealGas.DynamicViscosity_Trho(
  //     T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h),
  //     rho=ThermoSysPro.Properties.DryAirIdealGas.Density_PT(
  //       P=P, T=ThermoSysPro.Properties.DryAirIdealGas.Temperature_h(h=h)));

  elseif fluid==7 then
    //der_mu := 0.0001;
    //

   //LogVariable(der_mu);
  else
    assert(false, "incorrect fluid number");  ///
  end if;

end derDynamicViscosity_derT_derrho;
