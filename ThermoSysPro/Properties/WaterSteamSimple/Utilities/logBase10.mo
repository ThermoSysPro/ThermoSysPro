within ThermoSysPro.Properties.WaterSteamSimple.Utilities;
function logBase10
  input Real x;
  output Real y;
algorithm
  //y:= log10(x);
  y:=log10(abs(x)+1e-10);
end logBase10;
