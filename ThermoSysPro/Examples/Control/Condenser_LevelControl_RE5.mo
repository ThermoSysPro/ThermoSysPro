within ThermoSysPro.Examples.Control;
model Condenser_LevelControl_RE5 "Condenser level control"

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
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PIsat pIsat1(
    minval=0.00010,
    k=100,
    Ti=10,
    permanent=false,
    ureset0(fixed=true) = 0.3)
    annotation (Placement(transformation(
        origin={-63,-66},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Continu.PT1 pT1_1(                              permanent=true, U0=0.43,
    k=1,
    Ti=1)
    annotation (Placement(transformation(extent={{31,71},{51,91}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Edge edge annotation (Placement(
        transformation(extent={{-50,-40},{-40,-30}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Logique.Echelon echelon
    annotation (Placement(transformation(extent={{-76,-11},{-66,-1}}, rotation=
            0)));
equation
  connect(pT1_1.y,add. u1) annotation (Line(points={{52,81},{57,81},{57,85.8},{
          61.75,85.8}}));
  connect(pIsat1.y, SortieReelle1) annotation (Line(points={{-74,-66},{-79,-66},
          {-79,-90},{105,-90}}, color={255,0,0}));
  connect(MesureNiveauEau, pT1_1.u) annotation (Line(points={{-105,90},{-38,90},
          {-38,81},{30,81}}, color={127,0,0}));
  connect(ConsigneNiveauEau, add.u2) annotation (Line(points={{-105,30},{-93,30},
          {-93,50},{55,50},{55,70.2},{61.75,70.2}}, color={127,0,0}));
  connect(echelon.yL, edge.uL)
    annotation (Line(points={{-65.5,-6},{-60,-6},{-60,-35},{-50.5,-35}}));
  connect(edge.yL, pIsat1.reset)
    annotation (Line(points={{-39.5,-35},{-31,-35},{-31,-46},{-62,-46},{-62,-55}}));
  connect(add.y, pIsat1.u)
    annotation (Line(points={{89.25,78},{93,78},{93,-66},{-52,-66}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1},
        initialScale=0.1), graphics={
        Text(
          extent={{-97,99},{-59,91}},
          lineColor={127,0,0},
          textString=
               "Niveau ballon"),
        Text(
          extent={{-99,58},{-53,26}},
          lineColor={127,0,0},
          textString=
               "Consigne Niveau"),
        Text(
          extent={{-103,-21},{-65,-29}},
          lineColor={127,0,0},
          textString=
               "Debit Eau"),
        Text(
          extent={{-99,-92},{-61,-100}},
          lineColor={127,0,0},
          textString=
               "Debit Vapeur"),
        Text(
          extent={{64,-92},{102,-100}},
          lineColor={127,0,0},
          textString=
               "Ouv Vanne")}),
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
          extent={{-58,62},{58,-1}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString="Regulation
 Niveau "),
        Text(
          extent={{-33,-23},{33,-61}},
          lineColor={0,0,255},
          fillColor={255,255,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Ballon")}));
end Condenser_LevelControl_RE5;
