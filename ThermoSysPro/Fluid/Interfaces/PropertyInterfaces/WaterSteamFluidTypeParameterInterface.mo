within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
partial model WaterSteamFluidTypeParameterInterface "Interface to display the water/steam fluid type after parametrization"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.WaterSteamFluidType;

  parameter WaterSteamFluidType wsftype=WaterSteamFluidType.WaterSteam "Water/steam fluid type" annotation(Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));

protected
  parameter Integer wsfluid=Integer(wsftype) "Fluid number" annotation(Evaluate=true);

protected
  parameter FluidType ftype=cvwsftype(wsftype) annotation(Evaluate=true);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end WaterSteamFluidTypeParameterInterface;
