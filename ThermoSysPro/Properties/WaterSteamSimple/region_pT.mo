within ThermoSysPro.Properties.WaterSteamSimple;
function region_pT "Returns the current region (valid values: 1,2) for given pressure and temperature"
  input Units.SI.Pressure p "Pressure";
  input Units.SI.Temperature T "Temperature";
  input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";

  output Integer region "Region (valid values: 1,2)";

protected
  Units.SI.Temperature Tsat "Bubble entropy";
  Units.SI.SpecificEnthalpy sv "Dew entropy";

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
