within ThermoSysPro.Fluid.Interfaces.PropertyInterfaces;
partial model FlueGasesFluidTypeParameterInterface
  "Interface to display the  flue gases fluid type after parametrization"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FlueGasesFluidType;

  parameter FlueGasesFluidType fgftype=FlueGasesFluidType.FlueGases "Flue gases fluid type" annotation(Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));

protected
  parameter Integer fgfluid=Integer(fgftype) "Fluid number" annotation(Evaluate=true);

protected
  parameter FluidType ftype=cvfgftype(fgftype) annotation(Evaluate=true);
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
                                            Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end FlueGasesFluidTypeParameterInterface;
