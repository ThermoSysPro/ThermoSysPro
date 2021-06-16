within ThermoSysPro.Properties.Fluid;
function derDynamicViscosity_derrho_derT
  "Dynamic Viscosity computation for all fluids"

  input Modelica.SIunits.Density rho "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam  <br>7 - WaterSteamSimple </html>";
  input Real der_rho "Density time derivative";
  input Real der_T "Temperature time derivative";

  output Real der_mu "Dynamic Viscosity time derivative";

  //Modelica.SIunits.Duration dt=1;
  //Modelica.SIunits.AbsolutePressure delta_rho = 0.01*rho;
  //Modelica.SIunits.SpecificEnthalpy delta_T = 0.01*T;

algorithm
  // Water/Steam  /// FONCTIONNE EN DIPHASIQUE ???
  if fluid==1 then

    der_mu := 0.0;

//     der_mu :=(ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(
//     P=P + delta_P,
//     h=h + delta_h,
//     fluid=fluid,
//     mode=mode,
//     Xco2=Xco2,
//     Xh2o=Xh2o,
//     Xo2=Xo2,
//     Xso2=Xso2) - ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(
//     P=P - delta_P,
//     h=h - delta_h,
//     fluid=fluid,
//     mode=mode,
//     Xco2=Xco2,
//     Xh2o=Xh2o,
//     Xo2=Xo2,
//     Xso2=Xso2))/dt;

  elseif fluid==7 then
    //der_mu := 0.0001;
    //

   //LogVariable(der_mu);
  else
    assert(false, "incorrect fluid number");  ///
  end if;

end derDynamicViscosity_derrho_derT;
