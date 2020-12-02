within ThermoSysPro.FlueGases.Sensors;
model TemperatureSensor "Temperature sensor"

public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal Mesure
    annotation (Placement(transformation(
        origin={0,102},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Connectors.FlueGasesInlet C1
                          annotation (Placement(transformation(extent={{-110,
            -90},{-90,-70}}, rotation=0)));
  Connectors.FlueGasesOutlet C2
                          annotation (Placement(transformation(extent={{90,-90},
            {110,-70}}, rotation=0)));
equation

  C1.P = C2.P;
  C1.T = C2.T;
  C1.Q = C2.Q;
  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2  = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  /* Sensor signal */
  Mesure.signal = C1.T;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,92},{60,-28}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Backward),
        Line(points={{0,-30},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(
          extent={{-60,60},{60,0}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid,
          textString=
               "T")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-60,92},{60,-28}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Backward),
        Line(points={{0,-30},{0,-80}}),
        Line(points={{-98,-80},{102,-80}}),
        Text(extent={{-60,60},{60,0}}, textString=
                                            "T")}),
    Window(
      x=0.22,
      y=0.21,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end TemperatureSensor;
