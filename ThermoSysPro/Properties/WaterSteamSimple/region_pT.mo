within ThermoSysPro.Properties.WaterSteamSimple;
function region_pT
  "return the current region (valid values: 1,2) for given pressure and temperature"
 input Modelica.SIunits.Pressure p "pressure";
 input Modelica.SIunits.Temperature T "temperature";
 input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
 output Integer region "region (valid values: 1,2)";

protected
  Modelica.SIunits.Temperature Tsat "bubble entropy";
  Modelica.SIunits.SpecificEnthalpy sv "dew entropy";
algorithm
  Tsat := ThermoSysPro.Properties.WaterSteamSimple.Temperature.Tsat_P(p);
  if (mode <> 0) then
    region := mode;
  else
    if T > Tsat then
      region:= 2;
    else
      region := 1;
    end if;
  end if;

end region_pT;
