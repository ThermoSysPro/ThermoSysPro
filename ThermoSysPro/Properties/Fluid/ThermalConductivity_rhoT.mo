within ThermoSysPro.Properties.Fluid;
function ThermalConductivity_rhoT
  "Thermal Conductivity computation for all fluids (inputs: rho,T, fluid)"

  input Modelica.SIunits.Density rho "Density";
  input Modelica.SIunits.Temperature T "Temperature";
  input Modelica.SIunits.AbsolutePressure P "Pressure (Pa)";
  input Integer region "region (valid values: 1,2,4)";
  input Integer fluid
    "<html>Fluid number: <br>1 - Water/Steam  <br>7 - WaterSteamSimple </html>";

  output Modelica.SIunits.ThermalConductivity k "Thermal Conductivity (W/m/K)";

protected
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pro annotation (Placement(
        transformation(extent={{-80,40},{-40,80}}, rotation=0)));

algorithm
  // Water/Steam  ///
  if fluid==1 then
    k := ThermoSysPro.Properties.WaterSteam.IF97.ThermalConductivity_rhoT(rho=rho,T=T,P=P,region=region);

  // Water/Steam Simple
  elseif  fluid==7 then
    k := ThermoSysPro.Properties.WaterSteamSimple.SimpleWater.ThermalConductivity_rhoT(rho=rho,T=T);
    //LogVariable(k);

  else
    assert(false, "incorrect fluid number");  ///
  end if;

end ThermalConductivity_rhoT;
