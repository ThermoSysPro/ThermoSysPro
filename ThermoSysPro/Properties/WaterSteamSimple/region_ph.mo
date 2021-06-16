within ThermoSysPro.Properties.WaterSteamSimple;
function region_ph
  "return the current region (valid values: 1,2,4) for given pressure and specific enthalpy"
 input Modelica.SIunits.Pressure p "pressure";
 input Modelica.SIunits.SpecificEnthalpy h "specific enthalpy";
// input Integer phase=0 "phase: 2 for two-phase, 1 for one phase";
 input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
 output Integer region "region (valid values: 1,2,4)";
  // If mode is different from 0, no checking for the region is done and
  // the mode is assumed to be the correct region. This can be used to
  // implement e.g. water-only steamtables when mode == 1
protected
  Modelica.SIunits.SpecificEnthalpy hl "bubble enthalpy";
  Modelica.SIunits.SpecificEnthalpy hv "dew enthalpy";
  Integer phase;
  Boolean supercritical;

algorithm
  if (mode <> 0) then
    region := mode;
  else
    // check for regions 1, 2 and 4
    supercritical := (p > ThermoSysPro.Properties.WaterSteamSimple.critical.PCRIT);
    if supercritical then
      if h < ThermoSysPro.Properties.WaterSteamSimple.critical.HCRIT then
       region:= 1;
      else
       region:= 2;
      end if;
    else
      hl := Enthalpy.h1sat_P(p);
      hv := Enthalpy.h2sat_P(p);
      phase := if ((h < hl) or (h > hv)) then 1 else 2;
      if (phase == 2) then
        region := 4;
      else
        if (h < hl) then
          region:= 1;
        elseif (h>hv) then
          region := 2;
        end if;
      end if;
    end if;
  end if;

end region_ph;
