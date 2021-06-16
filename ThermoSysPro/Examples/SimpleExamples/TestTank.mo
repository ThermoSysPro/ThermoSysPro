within ThermoSysPro.Examples.SimpleExamples;
model TestTank

  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PerteDP1
    annotation (Placement(transformation(extent={{30,-50},{50,-30}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve VanneReglante1
    annotation (Placement(transformation(extent={{-50,2},{-30,22}},  rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP SourceP1
                                            annotation (Placement(
        transformation(extent={{-90,-4},{-70,16}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{70,-50},{90,-30}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.Tank Tank1(z(fixed=false, start=5))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                                                                  rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Rampe1
    annotation (Placement(transformation(extent={{-90,30},{-70,50}},  rotation=
            0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PerteDP2
    annotation (Placement(transformation(extent={{30,-4},{50,16}},   rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP PuitsP2
                                          annotation (Placement(transformation(
          extent={{70,-4},{90,16}},   rotation=0)));
equation
  connect(PerteDP1.C2, PuitsP1.C)
    annotation (Line(points={{50,-40},{70,-40}}, color={0,0,255}));
  connect(SourceP1.C, VanneReglante1.C1)
    annotation (Line(points={{-70,6},{-50,6}},   color={0,0,255}));
  connect(Tank1.Cs2, PerteDP1.C1)  annotation (Line(points={{10,-6},{20,-6},{20,
          -40},{30,-40}}, color={0,0,255}));
  connect(Rampe1.y, VanneReglante1.Ouv)
    annotation (Line(points={{-69,40},{-40,40},{-40,23}}));
  connect(VanneReglante1.C2, Tank1.Ce1) annotation (Line(points={{-30,6},{-20,6},
          {-10,6}},               color={0,0,255}));
  connect(Tank1.Cs1, PerteDP2.C1)
    annotation (Line(points={{10.2,6},{20,6},{30,6}},   color={0,0,255}));
  connect(PerteDP2.C2, PuitsP2.C)
    annotation (Line(points={{50,6},{50,6},{70,6}},    color={0,0,255}));
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
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end TestTank;
