within ThermoSysPro.Examples.Control;
model TemperatureControl "Temperature_Control"
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
    k=k,
    Ti=Ti,
    minval=minval,
    ureset0=0.2)
    annotation (Placement(transformation(
        origin={-10,-57.5},
        extent={{-23.5,-29},{23.5,29}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_1(                              permanent=true,
    Ti=10,
    U0=620)
    annotation (Placement(transformation(extent={{-13,69},{18,99}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add add(                          k1=-1, k2=+1)
                                          annotation (Placement(transformation(
          extent={{49,53},{84,92}}, rotation=0)));
equation
  connect(pIsat.y, SortieReelle1)  annotation (Line(points={{-10,-83.35},{-10,
          -90},{105,-90}}, color={255,0,0}));
  connect(MesureNiveauEau, pT1_1.u) annotation (Line(points={{-105,90},{-38,90},
          {-38,84},{-14.55,84}}, color={127,0,0}));
  connect(ConsigneNiveauEau, add.u2) annotation (Line(points={{-105,-60},{-68,
          -60},{-68,42},{35,42},{35,60.8},{47.25,60.8}}));
  connect(pT1_1.y, add.u1)
    annotation (Line(points={{19.55,84},{32.9,84},{32.9,84.2},{47.25,84.2}}));
  connect(add.y, pIsat.u)
    annotation (Line(points={{85.75,72.5},{96,72.5},{96,-31.65},{-10,-31.65}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}},
        grid={1,1},
        initialScale=0.1), graphics={
        Text(
          extent={{-97,99},{-59,91}},
          lineColor={127,0,0},
          textString="Temperature"),
        Text(
          extent={{-101,-62},{-49,-86}},
          lineColor={127,0,0},
          textString="Temperature Set Point"),
        Text(
          extent={{59,-92},{102,-100}},
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
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-77,55},{85,-36}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Régulation Niveau "),
        Text(
          extent={{-30,-15},{49,-64}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Bache"),
        Text(
          extent={{-98,93},{-60,85}},
          lineColor={127,0,0},
          textString=
               "Niveau ballon"),
        Text(
          extent={{-101,-31},{-52,-64}},
          lineColor={127,0,0},
          textString=
               "Consigne Niveau"),
        Text(
          extent={{64,-86},{102,-94}},
          lineColor={127,0,0},
          textString=
               "Ouv Vanne")}));
end TemperatureControl;
