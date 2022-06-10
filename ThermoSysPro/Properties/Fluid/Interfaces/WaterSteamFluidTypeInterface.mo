within ThermoSysPro.Properties.Fluid.Interfaces;
partial model WaterSteamFluidTypeInterface "Interface to the water/steam fluid type"
  extends FluidTypeColors;
  import ThermoSysPro.Properties.Fluid.Interfaces.FluidType;
  import ThermoSysPro.Properties.Fluid.Interfaces.WaterSteamFluidType;

  parameter WaterSteamFluidType wsftype=WaterSteamFluidType.WaterSteam "Water/steam fluid type" annotation(Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));

protected
  parameter Integer wsfluid=Integer(wsftype) "Fluid number";

protected
  parameter FluidType ftype=cvwsftype(wsftype) annotation(Evaluate=true);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{-80,80}},
          lineColor=DynamicSelect({0,0,255},
          if wsfluid == 1 then line_color_fluid_1
          else if wsfluid == 2 then line_color_fluid_7
          else {0,0,0}),
          fillColor=DynamicSelect({0,0,255},
          if wsfluid == 1 then fill_color_fluid_1
          else if wsfluid == 2 then fill_color_fluid_7
          else {0,0,0}),
          fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2020</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end WaterSteamFluidTypeInterface;
