within ThermoSysPro.Examples.Book.SimpleExamples.CentrifugalPump;
model TestStaticCentrifugalPump

  ThermoSysPro.WaterSteam.Machines.StaticCentrifugalPump StaticCentrifugalPump1
    annotation (Placement(transformation(extent={{-10,-50},{-30,-30}},
                                                                     rotation=0)));
  ThermoSysPro.WaterSteam.Volumes.Tank Bache1(
                                        ze2=10, zs2=10)
    annotation (Placement(transformation(extent={{-30,10},{-10,30}},
                                                                   rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve VanneReglante1
    annotation (Placement(transformation(extent={{30,10},{50,30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Constante1(
                                                  k=0.5) annotation (Placement(
        transformation(extent={{-10,50},{10,70}},
                                                rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Pulse pulse(
    width=200,
    period=500,
    amplitude=1400,
    offset=0)   annotation (Placement(transformation(extent={{-50,-80},{-30,-60}},
          rotation=0)));
equation
  connect(StaticCentrifugalPump1.C2, Bache1.Ce2)
    annotation (Line(points={{-30,-40},{-70,-40},{-70,14},{-30,14}}, color={0,0,
          255}));
  connect(Bache1.Cs2, VanneReglante1.C1)
    annotation (Line(points={{-10,14},{30,14}},
                                              color={0,0,255}));
  connect(VanneReglante1.C2, StaticCentrifugalPump1.C1)
    annotation (Line(points={{50,14},{70,14},{70,-40},{-10,-40}},
                                                                color={0,0,255}));
  connect(Constante1.y, VanneReglante1.Ouv)
    annotation (Line(points={{11,60},{40,60},{40,31}}, color={0,0,255}));
  connect(pulse.y, StaticCentrifugalPump1.rpm_or_mpower)
    annotation (Line(points={{-29,-70},{-20,-70},{-20,-51}}, smooth=Smooth.None));
  annotation (experiment(StopTime=1000),
    Window(
      x=0.32,
      y=0.02,
      width=0.39,
      height=0.47),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
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
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 12.2.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestStaticCentrifugalPump;
