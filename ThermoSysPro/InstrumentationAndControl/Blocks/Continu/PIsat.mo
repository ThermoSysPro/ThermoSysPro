within ThermoSysPro.InstrumentationAndControl.Blocks.Continu;
block PIsat
  parameter Real k=1 "Gain";
  parameter Real Ti=1 "Constante de temps (s)";
  parameter Real maxval=1 "Valeur maximale de la sortie";
  parameter Real minval=0 "Valeur minimale de la sortie";
  parameter Real ureset0=0
    "Valeur de la sortie sur reset (si ureset non connecté)";
  parameter Boolean permanent=false "Calcul du permanent";
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  NonLineaire.Limiteur Limiteur1(maxval=maxval, minval=minval)
    annotation (Placement(transformation(extent={{70,-10},{90,10}}, rotation=0)));
  Math.Add Add2(k1=-1, k2=+1)
                             annotation (Placement(transformation(extent={{40,
            60},{20,80}}, rotation=0)));
  Math.Gain Gain3(Gain=1/k)       annotation (Placement(transformation(extent={
            {0,60},{-20,80}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ureset
                                           annotation (Placement(transformation(
          extent={{-120,-90},{-100,-70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical reset
    annotation (Placement(transformation(
        origin={-10,-110},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Math.Gain Gain(Gain=k) annotation (Placement(transformation(extent={{-46,20},
            {-26,40}}, rotation=0)));
  Math.Feedback Feedback1 annotation (Placement(transformation(extent={{-80,40},
            {-60,20}}, rotation=0)));
  Integrateur Integrateur1(k=1/Ti, permanent=permanent,
    ureset0=ureset0)               annotation (Placement(transformation(extent=
            {{-10,20},{10,40}}, rotation=0)));
  Math.Add Add1 annotation (Placement(transformation(extent={{32,-10},{52,10}},
          rotation=0)));
  Math.Gain Gain1(Gain=k) annotation (Placement(transformation(extent={{-46,-40},
            {-26,-20}}, rotation=0)));
  NonLineaire.Selecteur Selecteur1(C1=0) annotation (Placement(transformation(
          extent={{0,-30},{20,-10}}, rotation=0)));
equation

  if (cardinality(ureset) == 1) then
    Integrateur1.ureset.signal = ureset0;
  end if;

  if (cardinality(reset) == 2) then
    Integrateur1.reset.signal = false;
  end if;

  connect(Limiteur1.y, y) annotation (Line(points={{91,0},{110,0}}));
  connect(Gain3.u, Add2.y) annotation (Line(points={{1,70},{19,70}}));
  connect(u, Feedback1.u1) annotation (Line(points={{-110,0},{-90,0},{-90,30},{
          -81,30}}));
  connect(Limiteur1.y, Add2.u1) annotation (Line(points={{91,0},{94,0},{94,76},
          {41,76}}));
  connect(Gain3.y, Feedback1.u2) annotation (Line(points={{-21,70},{-70,70},{
          -70,41}}));
  connect(Integrateur1.y, Add1.u1)
    annotation (Line(points={{11,30},{20,30},{20,6},{31,6}}));
  connect(ureset, Integrateur1.ureset)
    annotation (Line(points={{-110,-80},{-20,-80},{-20,22},{-11,22}}));
  connect(reset, Integrateur1.reset)
    annotation (Line(points={{-10,-110},{-10,10},{0,10},{0,19}}, pattern=
          LinePattern.Dash));
  connect(Add1.y, Limiteur1.u) annotation (Line(points={{53,0},{69,0}}));
  connect(Add1.y, Add2.u2) annotation (Line(points={{53,0},{60,0},{60,64},{41,
          64}}));
  connect(Feedback1.y, Gain.u) annotation (Line(points={{-59,30},{-47,30}}));
  connect(Gain.y, Integrateur1.u) annotation (Line(points={{-25,30},{-11,30}}));
  connect(u, Gain1.u) annotation (Line(points={{-110,0},{-90,0},{-90,-30},{-47,
          -30}}));
  connect(Selecteur1.y, Add1.u2)
    annotation (Line(points={{21,-20},{26,-20},{26,-6},{31,-6}}));
  connect(Gain1.y, Selecteur1.u2)
    annotation (Line(points={{-25,-30},{-14,-30},{-14,-28},{-1,-28}}));
  connect(reset, Selecteur1.uCond)
    annotation (Line(points={{-10,-110},{-10,-20},{-1,-20}}, pattern=
          LinePattern.Dash));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-74,64},{-74,-80}}, color={192,192,192}),
        Line(points={{-74,-80},{70,-80}}, color={192,192,192}),
        Polygon(
          points={{92,-80},{70,-72},{70,-88},{92,-80}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-68},{-74,2},{30,42}},
          color={0,0,255},
          thickness=0.25),
        Text(
          extent={{-32,70},{0,42}},
          lineColor={192,192,192},
          textString=
               "PI"),
        Line(points={{30,42},{86,42}}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Text(
          extent={{-38,10},{52,-30}},
          lineColor={0,0,0},
          textString=
               "K=%k"),
        Text(
          extent={{-36,-34},{54,-74}},
          lineColor={0,0,0},
          textString=
               "Ti=%Ti"),
        Polygon(
          points={{-74,86},{-82,64},{-66,64},{-74,86}},
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.12,
      y=0.18,
      width=0.56,
      height=0.73),
    Documentation(info="<html>
<p><b>Adapted from the Modelica.Blocks.Continuous library</b> </p>
<p><b>Version 1.7</h4>
</html>"),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics));
end PIsat;
