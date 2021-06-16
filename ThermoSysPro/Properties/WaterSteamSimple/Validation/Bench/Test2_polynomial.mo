within ThermoSysPro.Properties.WaterSteamSimple.Validation.Bench;
model Test2_polynomial
  import ThermoSysPro;
  parameter Integer fluid = 3;

  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP(P0=600000, mode=
       0)                                 annotation (Placement(transformation(
          extent={{80,-10},{100,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(mode=0,
      option_temperature=2,
    P0=1000000)                     annotation (Placement(transformation(extent=
           {{-100,-10},{-80,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeD volumeD(fluid=fluid)
                                                  annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe perteDP(fluid=fluid)
                                        annotation (Placement(transformation(
          extent={{-60,-10},{-40,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe perteDP1(fluid=fluid)
                                         annotation (Placement(transformation(
          extent={{40,-10},{60,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Duration=10000,
    Initialvalue=1e5,
    Finalvalue=4e6) annotation (Placement(transformation(extent={{-118,-40},{
            -98,-20}}, rotation=0)));
equation
  connect(perteDP.C2,volumeD. Ce)
    annotation (Line(points={{-40,0},{-10,0}}, color={0,0,255}));
  connect(sourceP.C, perteDP.C1)
    annotation (Line(points={{-80,0},{-60,0}}, color={0,0,255}));
  connect(perteDP1.C2, puitsP.C)
    annotation (Line(points={{60,0},{80,0}}, color={0,0,255}));
  connect(rampe.y, sourceP.ISpecificEnthalpy)
    annotation (Line(points={{-97,-30},{-90,-30},{-90,-5}}));
  connect(volumeD.Cs3, perteDP1.C1) annotation (Line(points={{10,0},{40,0}},
        color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Window(
      x=0.28,
      y=0.03,
      width=0.5,
      height=0.6),
    experiment(StopTime=10000, __Dymola_NumberOfIntervals=5000),
    __Dymola_experimentSetupOutput,
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end Test2_polynomial;
