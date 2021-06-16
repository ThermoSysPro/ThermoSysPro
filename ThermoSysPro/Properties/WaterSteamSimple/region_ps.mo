within ThermoSysPro.Properties.WaterSteamSimple;
function region_ps
  "return the current region (valid values: 1,2,4) for given pressure and specific entropy"
 input Modelica.SIunits.Pressure p "pressure";
 input Modelica.SIunits.SpecificEntropy s "specific entropy";
 input Integer mode=0 "mode: 0 means check, otherwise assume region=mode";
 output Integer region "region (valid values: 1,2,4)";
  // If mode is different from 0, no checking for the region is done and
  // the mode is assumed to be the correct region. This can be used to
  // implement e.g. water-only steamtables when mode == 1

protected
 Modelica.SIunits.SpecificEntropy sl "bubble entropy";
 Modelica.SIunits.SpecificEntropy sv "dew entropy";

 Integer phase;
 Boolean supercritical;

algorithm
   if (mode <> 0) then
     region := mode;
   else
     // check for regions 1, 2 and 4
     supercritical := (p > ThermoSysPro.Properties.WaterSteamSimple.critical.PCRIT);
     if supercritical then
       if s < ThermoSysPro.Properties.WaterSteamSimple.critical.SCRIT then
        region:= 1;
       else
        region:= 2;
       end if;
     else
       sl := Entropy.s1sat_P(p);
       sv := Entropy.s2sat_P(p);
       phase := if ((s < sl) or (s > sv)) then 1 else 2;
       if (phase == 2) then
         region := 4;
       else
         if (s < sl) then
           region:= 1;
         elseif (s > sv) then
           region := 2;
         end if;
       end if;
     end if;
   end if;

end region_ps;
