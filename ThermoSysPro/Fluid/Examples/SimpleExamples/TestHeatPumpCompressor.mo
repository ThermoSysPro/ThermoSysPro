within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestHeatPumpCompressor
  ThermoSysPro.Fluid.Machines.HeatPumpCompressor Compressor(
    Pe(fixed=false, start=100000),
    Ts(fixed=false, start=680)) annotation (Placement(transformation(extent={{
            -52,-52},{48,52}}, rotation=0)));
  BoundaryConditions.SourceQ                     SourceQ1(
    Xso2=0,
    Xco2=0.0,
    Xh2o=0.003,
    Xo2=0.23,
    Q0=420,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.C3H3F5,
    h0=3.e4,
    T0=288,
    option_temperature=false)
    annotation (Placement(transformation(extent={{-104,-10},{-84,10}},
          rotation=0)));

  ThermoSysPro.Fluid.BoundaryConditions.SinkP SinkP1(P0=1580000,
      option_temperature=false)
    annotation (Placement(transformation(
        origin={96,0},
        extent={{10,-10},{-10,10}},
        rotation=180)));
equation
  connect(SourceQ1.C, Compressor.C1)
    annotation (Line(points={{-84,0},{-52,0}}, color={0,0,0}));
  connect(SinkP1.C, Compressor.C2)
    annotation (Line(points={{86,0},{48,0}}, color={0,0,0}));
  annotation (                   Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Polygon(
          origin={8.0,14.0},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestHeatPumpCompressor;
