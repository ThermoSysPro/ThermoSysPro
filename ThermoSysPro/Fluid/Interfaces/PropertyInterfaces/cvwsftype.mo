within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
function cvwsftype "Converts water/steam fluid type into fluid type"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType;

  input WaterSteamFluidType wsftype;
  output FluidType ftype;

algorithm

  assert((wsftype == WaterSteamFluidType.WaterSteam) or (wsftype == WaterSteamFluidType.WaterSteamSimple), "cvwsftype: wrong fluid type");

  ftype := if wsftype == WaterSteamFluidType.WaterSteam then FluidType.WaterSteam
           else FluidType.WaterSteamSimple;

  annotation (Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end cvwsftype;
