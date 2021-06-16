within ThermoSysPro.Properties.WaterSteamSimple.Validation.Bench;
model Test1_polynomial
  import ThermoSysPro;
  parameter Integer fluid = 3;

  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP(
                                  P0=6e5) annotation (Placement(transformation(
          extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(mode=0,
      option_temperature=2)         annotation (Placement(transformation(extent=
           {{-104,-10},{-84,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump staticCentrifugalPump1(fluid=fluid)
    annotation (Placement(transformation(extent={{-20,30},{0,50}}, rotation=0)));
  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump staticCentrifugalPump2(fluid=fluid)
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeD volumeD(fluid=fluid)
                                                  annotation (Placement(
        transformation(extent={{-46,-10},{-26,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.IdealCheckValve idealCheckValve1
    annotation (Placement(transformation(extent={{14,30},{34,50}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.IdealCheckValve idealCheckValve2
    annotation (Placement(transformation(extent={{12,-50},{32,-30}}, rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.VolumeC volumeC(fluid=fluid)
                                                  annotation (Placement(
        transformation(extent={{34,-10},{54,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe perteDP(fluid=fluid)
                                        annotation (Placement(transformation(
          extent={{-76,-10},{-56,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe perteDP1(fluid=fluid)
                                         annotation (Placement(transformation(
          extent={{64,-10},{84,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Duration=10000,
    Initialvalue=1e5,
    Finalvalue=4e6) annotation (Placement(transformation(extent={{-128,-42},{
            -108,-22}}, rotation=0)));
equation
  connect(volumeD.Cs1,staticCentrifugalPump1. C1) annotation (Line(points={{-36,
          10},{-36,40},{-20,40}}, color={0,0,255}));
  connect(volumeD.Cs2,staticCentrifugalPump2. C1) annotation (Line(points={{-36,
          -9.8},{-36,-40},{-20,-40}}, color={0,0,255}));
  connect(staticCentrifugalPump1.C2,idealCheckValve1. C1) annotation (Line(
        points={{0,40},{14,40}}, color={0,0,255}));
  connect(idealCheckValve1.C2,volumeC. Ce2) annotation (Line(points={{34,40},{
          44,40},{44,9}}, color={0,0,255}));
  connect(idealCheckValve2.C2,volumeC. Ce3) annotation (Line(points={{32,-40},{
          44,-40},{44,-10}}, color={0,0,255}));
  connect(staticCentrifugalPump2.C2,idealCheckValve2. C1) annotation (Line(
        points={{0,-40},{12,-40}}, color={0,0,255}));
  connect(perteDP.C2,volumeD. Ce)
    annotation (Line(points={{-56,0},{-46,0}}, color={0,0,255}));
  connect(volumeC.Cs,perteDP1. C1)
    annotation (Line(points={{54,0},{64,0}}, color={0,0,255}));
  connect(sourceP.C, perteDP.C1)
    annotation (Line(points={{-84,0},{-76,0}}, color={0,0,255}));
  connect(perteDP1.C2, puitsP.C)
    annotation (Line(points={{84,0},{90,0}}, color={0,0,255}));
  connect(rampe.y, sourceP.ISpecificEnthalpy)
    annotation (Line(points={{-107,-32},{-94,-32},{-94,-5}}));
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
end Test1_polynomial;
