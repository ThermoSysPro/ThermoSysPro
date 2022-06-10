within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
partial model FluidTypeColors "Fluid type colors"

protected
  constant Integer line_color_WaterSteam[:] = {0,0,255} "Blue";
  constant Integer line_color_C3H3F5[:] = {238,46,47} "Red";
  constant Integer line_color_FlueGases[:] = {0,140,72} "Green";
  constant Integer line_color_Oil_MoltenSalt[:] = {217,67,180} "Magenta";
  constant Integer line_color_Oil_TherminolVP1[:] = {162,29,33} "Brown";
  constant Integer line_color_DryAirIdealGas[:] = {244,125,35} "Orange";
  constant Integer line_color_WaterSteamSimple[:] = {102,44,145} "Purple";

  constant Integer fill_color_WaterSteam[:] = {0,0,255} "Blue";
  constant Integer fill_color_C3H3F5[:] = {238,46,47} "Red";
  constant Integer fill_color_FlueGases[:] = {0,140,72} "Green";
  constant Integer fill_color_MoltenSalt[:] = {217,67,180} "Magenta";
  constant Integer fill_color_Oil_TherminolVP1[:] = {162,29,33} "Brown";
  constant Integer fill_color_DryAirIdealGas[:] = {244,125,35} "Orange";
  constant Integer fill_color_WaterSteamSimple[:] = {102,44,145} "Purple";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end FluidTypeColors;
