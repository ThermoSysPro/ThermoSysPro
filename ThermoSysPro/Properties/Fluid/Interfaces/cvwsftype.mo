within ThermoSysPro.Properties.Fluid.Interfaces;
function cvwsftype "Converts water/steam fluid type into fluid type"
  import ThermoSysPro.Properties.Fluid.Interfaces.FluidType;
  import ThermoSysPro.Properties.Fluid.Interfaces.WaterSteamFluidType;

  input WaterSteamFluidType wsftype;
  output FluidType ftype;

algorithm
  ftype := if wsftype == WaterSteamFluidType.WaterSteam then FluidType.WaterSteam
           else FluidType.WaterSteamSimple;

end cvwsftype;
