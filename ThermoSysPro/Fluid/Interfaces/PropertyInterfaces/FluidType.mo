within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
type FluidType = enumeration(
    WaterSteam "1 - IF97 water/steam (compressible)",
    C3H3F5 "2 - C3H3F5",
    FlueGases "3 - Flue gases (compressible)",
    MoltenSalt "4 - Molten salt",
    Oil_TherminolVP1 "5 - Oil Therminol VP1",
    DryAirIdealGas "6 - Dry air (compressible)",
    WaterSteamSimple "7 - Simplified water/steam (compressible)") annotation (
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
