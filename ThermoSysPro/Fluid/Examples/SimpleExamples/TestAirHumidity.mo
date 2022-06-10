within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestAirHumidity

  ThermoSysPro.Fluid.BoundaryConditions.AirHumidity airHumidity(hum0=0.9,
    ppvap0(start=2085.0),
    rho_air(start=1.14),
    rho_vap(start=0.015))
    annotation (Placement(transformation(extent={{-10,0},{10,20}},  rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLoss(K=1.e-5, rho(start=1.17))
                                  annotation (Placement(transformation(extent={{40,0},{
            60,20}},        rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.Sink sinkFlueGases
    annotation (Placement(transformation(extent={{80,0},{100,20}},rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourcePQ              sourceFlueGasesPQ(
    option_temperature=true,
    Xco2=0,
    Xh2o=0.0132625,
    Xo2=0.217282,
    ftype=ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType.FlueGases,
    P0=100000,
    T0=293)   annotation (Placement(transformation(extent={{-80,0},{-60,20}},
          rotation=0)));

equation
  connect(airHumidity.C2, singularPressureLoss.C1)
    annotation (Line(points={{10,10},{40,10}}, color={0,0,0}));
  connect(singularPressureLoss.C2, sinkFlueGases.C)
    annotation (Line(points={{60,10},{80,10}},                 color={0,0,0}));
  connect(sourceFlueGasesPQ.C, airHumidity.C1)
    annotation (Line(points={{-60,10},{-10,10}}, color={0,0,0}));
  annotation (experiment(StopTime=1000),
    Icon(graphics={
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
end TestAirHumidity;
