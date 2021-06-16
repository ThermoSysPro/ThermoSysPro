within ThermoSysPro.Examples.Book.SimpleExamples.Volume;
model TestVolumeATh

  WaterSteam.Volumes.VolumeATh volumeATh(
    h0=1.2e5,
    V=1,
    P0=300000,
    P(start=300000))
                   annotation (Placement(transformation(extent={{-15,21},{15,-9}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP sink(
    T0=320,
    option_temperature=2,
    h0=200000)
    annotation (Placement(transformation(extent={{64,-4},{84,16}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve1(Cvmax=80)
    annotation (Placement(transformation(extent={{-47,-58},{-27,-38}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe Rampe(Finalvalue=
        0, Initialvalue=1)           annotation (Placement(transformation(
          extent={{-89,-38},{-73,-22}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve controlValve2
    annotation (Placement(transformation(extent={{28,2},{48,22}}, rotation=0)));
  WaterSteam.BoundaryConditions.SourceQ sourceQ
    annotation (Placement(transformation(extent={{-83,-6},{-59,18}}, rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Constante Constant
                                     annotation (Placement(transformation(
          extent={{10,18},{26,34}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP2(
      option_temperature=2)
    annotation (Placement(transformation(extent={{-79,-64},{-59,-44}}, rotation=
           0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe lumpedStraightPipe1(
     L=0.1, D=1)
    annotation (Placement(transformation(extent={{-47,-4},{-27,16}}, rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Table1DTemps(Table=[0,10;
        5,-10; 8,0; 9,0]) annotation (Placement(transformation(extent={{-93,16},
            {-73,36}}, rotation=0)));
equation
  connect(Rampe.y, controlValve1.Ouv)
    annotation (Line(points={{-72.2,-30},{-37,-30},{-37,-37}}));
  connect(Constant.y, controlValve2.Ouv)
    annotation (Line(points={{26.8,26},{38,26},{38,23}}));
  connect(volumeATh.Cs1, controlValve2.C1)
    annotation (Line(points={{15,6},{28,6}}, color={0,0,255}));
  connect(sourceP2.C, controlValve1.C1)
    annotation (Line(points={{-59,-54},{-47,-54}}, color={0,0,255}));
  connect(controlValve1.C2, volumeATh.Ce2)
                                          annotation (Line(points={{-27,-54},{0,
          -54},{0,-9}}, color={0,0,255}));
  connect(sourceQ.C, lumpedStraightPipe1.C1)
    annotation (Line(points={{-59,6},{-47,6}}, color={0,0,255}));
  connect(lumpedStraightPipe1.C2, volumeATh.Ce1)
    annotation (Line(points={{-27,6},{-15,6}}, color={0,0,255}));
  connect(controlValve2.C2, sink.C)
    annotation (Line(points={{48,6},{64,6}}, color={0,0,255}));
  connect(Table1DTemps.y, sourceQ.IMassFlow)
    annotation (Line(points={{-72,26},{-71,26},{-71,12}}));
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
<p>This model is documented in Sect. 14.1.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestVolumeATh;
