within ThermoSysPro.Examples.Book.SimpleExamples.SteamTurbine;
model TestStodolaTurbine

  ThermoSysPro.WaterSteam.Machines.StodolaTurbine stodolaTurbine(Cst=2e6,
      eta_is_nom=0.94)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsP(                 mode=0, P0=
        10000000)
    annotation (Placement(transformation(extent={{30,-10},{50,10}},rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    option_temperature=2,
    mode=2,
    P0=27000000,
    h0=3475.e3)
             annotation (Placement(transformation(extent={{-50,-10},{-30,10}},
          rotation=0)));
equation
  connect(sourceP.C, stodolaTurbine.Ce)
    annotation (Line(points={{-30,0},{-10.1,0}},   color={0,0,255}));
  connect(stodolaTurbine.Cs, puitsP.C)
    annotation (Line(points={{10.1,0},{30,0}},     color={0,0,255}));
  annotation (experiment(StopTime=1000),
    Window(
      x=0.32,
      y=0.02,
      width=0.39,
      height=0.47),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(
          extent={{-64,-14},{-16,-26}},
          lineColor={0,0,255},
          textString=
               "Supercritrical at the inlet")}),
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
<p>This model is documented in Sect. 10.2.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestStodolaTurbine;
