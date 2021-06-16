within ThermoSysPro.Examples.Book.SimpleExamples.Volume;
model TestSteamDryer
  import ThermoSysPro;

  ThermoSysPro.WaterSteam.Junctions.SteamDryer steamDryer(eta=0.9, P(start=
          10000000)) annotation (Placement(transformation(extent={{-10,-8},{10,
            12}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourcePQ sourceQ(P0=10000000, h0=
        2400000)
    annotation (Placement(transformation(extent={{-90,-4},{-70,16}},  rotation=
            0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss2 annotation (Placement(transformation(extent={{-50,-4},
            {-30,16}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sinkP
    annotation (Placement(transformation(extent={{70,-4},{90,16}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss1 annotation (Placement(transformation(extent={{30,-4},
            {50,16}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLoss3(K=1.e-4)
                          annotation (Placement(transformation(extent={{30,-44},
            {50,-24}},
                     rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.Sink sink
    annotation (Placement(transformation(extent={{70,-44},{90,-24}},
                                                                   rotation=0)));
equation
  connect(sourceQ.C,singularPressureLoss2. C1) annotation (Line(points={{-70,6},
          {-50,6}},  color={0,0,255}));
  connect(singularPressureLoss1.C2,sinkP. C)
    annotation (Line(points={{50,6},{70,6}},   color={0,0,255}));
  connect(singularPressureLoss3.C2,sink. C)
    annotation (Line(points={{50,-34},{70,-34}}, color={0,0,255}));
  connect(singularPressureLoss2.C2, steamDryer.Cev) annotation (Line(points={{-30,6},
          {-20,6},{-9.9,6}},                     color={0,0,255}));
  connect(steamDryer.Csv, singularPressureLoss1.C1) annotation (Line(points={{9.9,6},
          {20,6},{30,6}},                    color={0,0,255}));
  connect(steamDryer.Csl, singularPressureLoss3.C1) annotation (Line(points={{0.1,-8},
          {0,-8},{0,-34},{30,-34}},             color={0,0,255}));
  annotation (experiment(StopTime=10), Icon(graphics={
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
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 14.9.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestSteamDryer;
