within ThermoSysPro.InstrumentationAndControl.Blocks.NonLineaire;
block LimiteurVitesse
  parameter Real dmax=1 "Valeur maximale de la dérivée de la sortie";
  parameter Real dmin=-1 "Valeur minimale de la dérivée de la sortie";
  parameter Real Ti(min=Modelica.Constants.small) = 0.01
    "Constante de temps (s)";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  Continu.Derivee Derivee1(Ti=Ti) annotation (Placement(transformation(extent={
            {-60,-10},{-40,10}}, rotation=0)));
  Continu.Integrateur Integrateur1 annotation (Placement(transformation(extent=
            {{40,-10},{60,10}}, rotation=0)));
  Limiteur Limiteur1(maxval=dmax, minval=dmin)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=0)));
  Sources.Horloge Horloge1 annotation (Placement(transformation(extent={{-80,
            -60},{-60,-40}}, rotation=0)));
  Sources.Constante Constante1(k=0) annotation (Placement(transformation(extent=
           {{-80,-100},{-60,-80}}, rotation=0)));
  Math.Supeg Supeg1 annotation (Placement(transformation(extent={{-40,-80},{-20,
            -60}}, rotation=0)));
  Logique.Edge Edge1 annotation (Placement(transformation(extent={{0,-80},{20,
            -60}}, rotation=0)));
equation
  connect(u, Derivee1.u) annotation (Line(points={{-110,0},{-61,0}}));
  connect(Integrateur1.y, y)
    annotation (Line(points={{61,0},{110,0}}, color={0,0,255}));
  connect(Derivee1.y, Limiteur1.u)
    annotation (Line(points={{-39,0},{-11,0}}, color={0,0,255}));
  connect(Limiteur1.y, Integrateur1.u)
    annotation (Line(points={{11,0},{39,0}}, color={0,0,255}));
  connect(u, Integrateur1.ureset)
    annotation (Line(points={{-110,0},{-80,0},{-80,-20},{28,-20},{28,-8},{39,-8}}));
  connect(Horloge1.y, Supeg1.u1) annotation (Line(points={{-59,-50},{-50,-50},{
          -50,-64},{-41,-64}}, color={0,0,255}));
  connect(Constante1.y, Supeg1.u2) annotation (Line(points={{-59,-90},{-50,-90},
          {-50,-76},{-41,-76}}, color={0,0,255}));
  connect(Supeg1.yL, Edge1.uL) annotation (Line(points={{-19,-70},{-1,-70}}));
  connect(Edge1.yL, Integrateur1.reset)
    annotation (Line(points={{21,-70},{50,-70},{50,-11}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{78,60},{40,60},{-40,-60},{-80,-60}}, color={0,0,0}),
        Line(points={{-86,0},{88,0}}, color={160,160,164}),
        Polygon(
          points={{96,0},{86,-5},{86,5},{96,0}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,84},{-5,74},{5,74},{0,84}},
          lineColor={160,160,164},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid),
        Line(points={{0,-80},{0,74}}, color={160,160,164}),
        Text(
          extent={{-94,-8},{-32,-30}},
          lineColor={160,160,164},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%dmin"),
        Text(
          extent={{30,34},{92,12}},
          lineColor={160,160,164},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "%dmax")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics),
    Window(
      x=0.19,
      y=0.24,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Version 1.7</b></p>
</HTML>
"));
end LimiteurVitesse;
