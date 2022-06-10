within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestTankHorizontal

  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe PerteDP1(C1(P(start=
            400000.0)), Q(start=600.0))
    annotation (Placement(transformation(extent={{32,-20},{52,0}},   rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve VanneReglante1(Pm(start=
          200000.0), Q(start=0.0))
    annotation (Placement(transformation(extent={{-50,6},{-30,26}},  rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP SourceP1
                                            annotation (Placement(
        transformation(extent={{-90,0},{-70,20}},  rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{70,-20},{90,0}},   rotation=0)));
  Volumes.TankHorizontal          Tank1(z(fixed=false, start=5), Cs1(Q(start=
            0.0)),
    diffusion=true,
    dynamic_mass_balance=true)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
                                                                  rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Rampe1
    annotation (Placement(transformation(extent={{-90,30},{-70,50}},  rotation=
            0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe PerteDP2
    annotation (Placement(transformation(extent={{32,0},{52,20}},    rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsP2
                                          annotation (Placement(transformation(
          extent={{70,0},{90,20}},    rotation=0)));
equation
  connect(PerteDP1.C2, PuitsP1.C)
    annotation (Line(points={{52,-10},{70,-10}}, color={0,0,255}));
  connect(SourceP1.C, VanneReglante1.C1)
    annotation (Line(points={{-70,10},{-50,10}}, color={0,0,255}));
  connect(Tank1.Cs2, PerteDP1.C1)  annotation (Line(points={{20,-10},{32,-10}},
                          color={0,0,255}));
  connect(Rampe1.y, VanneReglante1.Ouv)
    annotation (Line(points={{-69,40},{-40,40},{-40,27}}));
  connect(VanneReglante1.C2, Tank1.Ce1) annotation (Line(points={{-30,10},{-20,
          10}},                   color={0,0,255}));
  connect(Tank1.Cs1, PerteDP2.C1)
    annotation (Line(points={{20.4,9.8},{20.4,10},{32,10}},
                                                        color={0,0,255}));
  connect(PerteDP2.C2, PuitsP2.C)
    annotation (Line(points={{52,10},{70,10}},         color={0,0,255}));
  annotation (experiment(StopTime=20),
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
end TestTankHorizontal;
