within ThermoSysPro.Examples.Control;
model Drum_LevelControl "Drum level control"
  parameter Real k=1 "Gain";
  parameter Real Ti=1 "Time constant (s)";
  parameter Real minval=0.01 "Minimum output value";

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal MesureNiveauEau
    annotation (Placement(transformation(extent={{-110,85},{-100,95}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ConsigneNiveauEau
    annotation (Placement(transformation(extent={{-110,-65},{-100,-55}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReelle1
    annotation (Placement(transformation(extent={{100,-95},{110,-85}}, rotation=
           0)));

  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PIsat pIsat(
    permanent=true,
    ureset0=0.8,
    k=k,
    Ti=Ti,
    minval=minval)
    annotation (Placement(transformation(
        origin={-10,-56.5},
        extent={{-23.5,-29},{23.5,29}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_1(                              permanent=true,
    U0=1.1,
    Ti=10)
    annotation (Placement(transformation(extent={{-13,69},{18,99}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add add(                          k1=-1, k2=+1)
                                          annotation (Placement(transformation(
          extent={{48,53},{83,92}}, rotation=0)));
equation
  connect(pIsat.y, SortieReelle1)  annotation (Line(points={{-10,-82.35},{-10,
          -90},{105,-90}}, color={255,0,0}));
  connect(MesureNiveauEau, pT1_1.u) annotation (Line(points={{-105,90},{-38,90},
          {-38,84},{-14.55,84}}, color={127,0,0}));
  connect(ConsigneNiveauEau, add.u2) annotation (Line(points={{-105,-60},{-68,
          -60},{-68,42},{35,42},{35,60.8},{46.25,60.8}}));
  connect(pT1_1.y, add.u1)
    annotation (Line(points={{19.55,84},{32.9,84},{32.9,84.2},{46.25,84.2}}));
  connect(add.y, pIsat.u)
    annotation (Line(points={{84.75,72.5},{96,72.5},{96,-30.65},{-10,-30.65}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1},
        initialScale=0.1), graphics={
        Text(
          extent={{-103,102},{-62,91}},
          lineColor={127,0,0},
          textString="Measure"),
        Text(
          extent={{-99,-48},{-48.5,-88}},
          lineColor={127,0,0},
          textString="Level Set point"),
        Text(
          extent={{62,-93},{100,-101}},
          lineColor={127,0,0},
          textString="Valve opening")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1},
        initialScale=0.1), graphics={
        Rectangle(extent={{-100,100},{100,-100}}),
        Rectangle(
          extent={{-80,81},{80,-80}},
          lineColor={0,0,255},
          fillColor={127,127,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-35.5,15.5},{29,-14}},
          lineColor={255,0,0},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Regulation")}));
end Drum_LevelControl;
