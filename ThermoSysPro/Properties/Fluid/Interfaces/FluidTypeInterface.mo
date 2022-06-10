within ThermoSysPro.Properties.Fluid.Interfaces;
partial model FluidTypeInterface "Interface to the fluid type"
  extends FluidTypeColors;
  import ThermoSysPro.Properties.Fluid.Interfaces.FluidType;

  parameter FluidType ftype=FluidType.WaterSteam "Fluid type" annotation(Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));

protected
  parameter Integer fluid=Integer(ftype) "Fluid number";
  parameter Boolean isCompressible=(ftype==FluidType.WaterSteam or ftype==FluidType.FlueGases or ftype==FluidType.DryAirIdealGas or ftype==FluidType.WaterSteamSimple) "Compressible fluid" annotation(Evaluate=true);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{-80,80}},
          lineColor=DynamicSelect({0,0,255},
          if fluid == 1 then line_color_fluid_1
          else if fluid == 2 then line_color_fluid_2
          else if fluid == 3 then line_color_fluid_3
          else if fluid == 4 then line_color_fluid_4
          else if fluid == 5 then line_color_fluid_5
          else if fluid == 6 then line_color_fluid_6
          else if fluid == 7 then line_color_fluid_7
          else {0,0,0}),
          fillColor=DynamicSelect({0,0,255},
          if fluid == 1 then fill_color_fluid_1
          else if fluid == 2 then fill_color_fluid_2
          else if fluid == 3 then fill_color_fluid_3
          else if fluid == 4 then fill_color_fluid_4
          else if fluid == 5 then fill_color_fluid_5
          else if fluid == 6 then fill_color_fluid_6
          else if fluid == 7 then fill_color_fluid_7
          else {0,0,0}),
          fillPattern=FillPattern.Solid)}), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2020</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end FluidTypeInterface;
