within ThermoSysPro.Examples.Control;
model Condenser_LevelControl "Condenser level control"

  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal MesureDebitVapeur
    annotation (Placement(transformation(extent={{-109,-94},{-99,-84}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal MesureDebitEau
    annotation (Placement(transformation(extent={{-110.5,-34.5},{-100.5,-24.5}},
          rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal MesureNiveauEau
    annotation (Placement(transformation(extent={{-110,85},{-100,95}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal ConsigneNiveauEau
    annotation (Placement(transformation(extent={{-110,25},{-100,35}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal SortieReelle1
    annotation (Placement(transformation(extent={{100,-95},{110,-85}}, rotation=
           0)));

  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add add(                          k1=+1, k2=-1)
                                          annotation (Placement(transformation(
          extent={{63,65},{88,91}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PIsat pIsat(
    permanent=true,
    ureset0=0,
    Ti=10,
    k=10)
    annotation (Placement(transformation(
        origin={76,-78},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add add1(
                             k1=+1, k2=+1)
                                          annotation (Placement(transformation(
        origin={-29,-65},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PIsat pIsat1(
    permanent=false,
    k=1,
    Ti=10,
    ureset0(fixed=true) = 0.8)
    annotation (Placement(transformation(
        origin={-63,-65},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_1(                              permanent=true, U0=1.05)
    annotation (Placement(transformation(extent={{31,71},{51,91}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_2(                              permanent=true, U0=1.05)
    annotation (Placement(transformation(
        origin={-17,13},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_3(                              permanent=true, U0=1.05)
    annotation (Placement(transformation(
        origin={15,13},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Math.Add add2(
                            k1=+1, k2=-1) annotation (Placement(transformation(
        origin={-11,-29},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Edge edge annotation (Placement(
        transformation(extent={{-50,-40},{-40,-30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Echelon echelon
    annotation (Placement(transformation(extent={{-76,-11},{-66,-1}}, rotation=
            0)));
equation
  connect(pIsat.u,add. y) annotation (Line(points={{87,-78},{89,-78},{89,78},{
          89.25,78}}));
  connect(pIsat1.u,add1. y) annotation (Line(points={{-52,-65},{-40,-65}}));
  connect(pT1_1.y,add. u1) annotation (Line(points={{52,81},{57,81},{57,85.8},{
          61.75,85.8}}));
  connect(pT1_2.y,add2. u2) annotation (Line(points={{-17,2},{-17,-8},{-17,-8},
          {-17,-18}}));
  connect(pT1_3.y,add2. u1)
    annotation (Line(points={{15,2},{15,-7},{-5,-7},{-5,-18}}));
  connect(pIsat.y,add1. u1) annotation (Line(points={{65,-78},{19,-78},{19,-71},
          {-18,-71}}));
  connect(pIsat1.y, SortieReelle1) annotation (Line(points={{-74,-65},{-79,-65},
          {-79,-90},{105,-90}}, color={255,0,0}));
  connect(MesureDebitVapeur, pT1_3.u) annotation (Line(points={{-104,-89},{-91,
          -89},{-91,-40},{-64,-40},{-64,29},{15,29},{15,24}}, color={255,0,0}));
  connect(MesureDebitEau, pT1_2.u)
    annotation (Line(points={{-105.5,-29.5},{-79,-29.5},{-79,37},{-17,37},{-17,
          24}}));
  connect(MesureNiveauEau, pT1_1.u) annotation (Line(points={{-105,90},{-38,90},
          {-38,81},{30,81}}, color={127,0,0}));
  connect(ConsigneNiveauEau, add.u2) annotation (Line(points={{-105,30},{-93,30},
          {-93,50},{55,50},{55,70.2},{61.75,70.2}}, color={127,0,0}));
  connect(add2.y, add1.u2) annotation (Line(points={{-11,-40},{-11,-59},{-18,
          -59}}));
  connect(echelon.yL, edge.uL)
    annotation (Line(points={{-65.5,-6},{-60,-6},{-60,-35},{-50.5,-35}}));
  connect(edge.yL, pIsat1.reset)
    annotation (Line(points={{-39.5,-35},{-31,-35},{-31,-46},{-62,-46},{-62,-54}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1},
        initialScale=0.1), graphics={
        Text(
          extent={{-117,102},{-79,94}},
          lineColor={127,0,0},
          textString="Level"),
        Text(
          extent={{-109,56},{-65,28}},
          lineColor={127,0,0},
          textString="Level Set point"),
        Text(
          extent={{-112,-15},{-63,-30}},
          lineColor={127,0,0},
          textString="Water MassFlowrate"),
        Text(
          extent={{-109,-89},{-57,-106}},
          lineColor={127,0,0},
          textString="Vapour Mass Flowrate"),
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
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-44.5,41.5},{42,-3}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Regulation"),
        Text(
          extent={{-29,-5},{20,-38}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Condenser"),
        Text(
          extent={{64,-86},{102,-94}},
          lineColor={127,0,0},
          textString=
               "Ouv Vanne")}));
end Condenser_LevelControl;
