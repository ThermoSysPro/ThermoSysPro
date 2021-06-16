within ThermoSysPro.Properties.Fluid;
function DynamicViscosity_rhoT
  "Dynamic Viscosity computation for all fluids (inputs: rho,T,fluid)"

  input Modelica.SIunits.Density rho "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam  <br>7 - WaterSteamSimple </html>";

  output Modelica.SIunits.DynamicViscosity mu "Dynamic Viscosity (Pa.s)";
protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro annotation (Placement(
        transformation(extent={{-80,40},{-40,80}}, rotation=0)));

algorithm
  // Water/Steam  ///
  if fluid==1 then
    mu := ThermoSysPro.Properties.WaterSteam.IF97.DynamicViscosity_rhoT(rho=rho,T=T);

   //LogVariable(mu);

  // Water/Steam  /// Simple
  elseif fluid==7 then
    mu := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.DynamicViscosity_rhoT(rho=rho,T=T);
    //LogVariable(mu);

  else
    assert(false, "incorrect fluid number");  ///

  end if;

  //annotation(derivative=derDynamicViscosity_derT_derrho);
end DynamicViscosity_rhoT;
