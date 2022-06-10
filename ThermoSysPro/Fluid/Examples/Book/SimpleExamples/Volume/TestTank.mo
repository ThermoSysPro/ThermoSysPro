within ThermoSysPro.Fluid.Examples.Book.SimpleExamples.Volume;
model TestTank

  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe PerteDP1
    annotation (Placement(transformation(extent={{30,-50},{50,-30}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve VanneReglante1
    annotation (Placement(transformation(extent={{-50,2},{-30,22}},  rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP SourceP1
                                            annotation (Placement(
        transformation(extent={{-90,-4},{-70,16}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsP1
                                          annotation (Placement(transformation(
          extent={{70,-50},{90,-30}}, rotation=0)));
  ThermoSysPro.Fluid.Volumes.Tank Tank1(z(fixed=false, start=5))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                                                                  rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Rampe1
    annotation (Placement(transformation(extent={{-90,30},{-70,50}},  rotation=
            0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe PerteDP2
    annotation (Placement(transformation(extent={{30,-4},{50,16}},   rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP PuitsP2
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
<h4>Copyright &copy; EDF 2002 - 2021 </h4>
<h4>ThermoSysPro Version 4.0 </h4>
<p>This model is documented in Sect. 14.5.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
<p>The results reported in the ThermoSysPro book were computed using Dymola. </p>
</html>"));
end TestTank;
