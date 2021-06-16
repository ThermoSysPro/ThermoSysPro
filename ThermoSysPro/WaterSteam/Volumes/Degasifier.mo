within ThermoSysPro.WaterSteam.Volumes;
model Degasifier "Degasifier"

  ThermoSysPro.WaterSteam.Volumes.DegasifierVolume dega1(
    P0=0.11283e7,
    P(start=0.11283e7),
    steady_state=true,
    h(start=700e3),
    Cs(h_vol(start=700e3)))
                    annotation (Placement(transformation(extent={{-20,20},{20,
            60}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe DPEau(     D=1,
    continuous_flow_reversal=true,
    Q(start=1000),
    Pm(start=1e6),
    lambda=0.01,
    L=1)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}}, rotation=0)));
  Connectors.FluidInletI sourceEau
    annotation (Placement(transformation(extent={{-110,70},{-90,90}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe DPvapeur(
    D=1,
    continuous_flow_reversal=true,
    Q(start=127.81, fixed=false),
    h(start=0.25623e7, fixed=false),
    Pm(start=1.100e6, fixed=false),
    lambda=0.01,
    L=1)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}}, rotation=0)));
  Connectors.FluidInletI sourceVapeur
    annotation (Placement(transformation(extent={{-110,30},{-90,50}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Volumes.DynamicDrum ballon(
    Vertical=false,
    R=4.234,
    L=33,
    Cevap=0.09,
    P0=0.1155e7,
    Tp(start=300),
    steady_state=true,
    hv(start=700e3),
    P(start=0.101283e7),
    zl(start=8))    annotation (Placement(transformation(extent={{-30,-80},{30,
            -20}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe TubeVap(L=0.1,
    D=1,
    continuous_flow_reversal=true,
    Q(fixed=false, start=0),
    lambda=0.01)
    annotation (Placement(transformation(
        origin={30,2},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Connectors.FluidOutletI puitsEauFond   annotation (Placement(transformation(
          extent={{-90,-90},{-110,-70}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe DPvapeur1(
    D=1,
    continuous_flow_reversal=true,
    Q(start=1200),
    h(start=700000),
    Pm(start=1.100e6),
    lambda=0.01,
    L=1)
    annotation (Placement(transformation(extent={{-60,-80},{-80,-60}}, rotation=
           0)));
  Connectors.FluidInletI sourceEauFond
    annotation (Placement(transformation(extent={{90,-90},{110,-70}}, rotation=
            0)));
  Connectors.FluidInletI sourceSup
    annotation (Placement(transformation(extent={{90,70},{110,90}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe DPEau1(    D=1,
    continuous_flow_reversal=true,
    Pm(start=1e6),
    lambda=0.01,
    L=1,
    Q(start=1))
    annotation (Placement(transformation(extent={{60,60},{40,80}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe DPEau2(    D=1,
    continuous_flow_reversal=true,
    Pm(start=1e6),
    lambda=0.01,
    L=1,
    Q(start=1))
    annotation (Placement(transformation(extent={{80,-80},{60,-60}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal yLevel
    annotation (Placement(transformation(extent={{100,-9},{126,10}}, rotation=0)));
equation
  connect(DPEau.C2, dega1.Ce2) annotation (Line(points={{-40,70},{-8,70},{-8,52}},
        color={0,0,255}));
  connect(DPvapeur.C2, dega1.Ce1) annotation (Line(points={{-40,30},{-32.6,30},
          {-32.6,40},{-20,40}}, color={0,0,255}));
  connect(TubeVap.C1,ballon. Cv)
                               annotation (Line(points={{30,-8},{30,-20}}));
  connect(DPvapeur1.C1, ballon.Cd) annotation (Line(points={{-60,-70},{-40,-70},
          {-40,-80},{-30,-80}}));
  connect(sourceEau, DPEau.C1) annotation (Line(points={{-100,80},{-80,80},{-80,
          70},{-60,70}}));
  connect(DPvapeur1.C2,puitsEauFond)  annotation (Line(points={{-80,-70},{-86,
          -70},{-86,-80},{-100,-80}}, color={0,0,255}));
  connect(sourceVapeur, DPvapeur.C1) annotation (Line(points={{-100,40},{-80,40},
          {-80,30},{-60,30}}));
  connect(ballon.Cm, DPEau2.C2) annotation (Line(points={{30,-80},{40,-80},{40,
          -70},{60,-70}}));
  connect(DPEau2.C1, sourceEauFond)
    annotation (Line(points={{80,-70},{86,-70},{86,-80},{100,-80}}));
  connect(dega1.Ce3, DPEau1.C2) annotation (Line(points={{8,52},{8,70},{40,70}}));
  connect(DPEau1.C1, sourceSup) annotation (Line(points={{60,70},{80,70},{80,80},
          {100,80}}));
  connect(dega1.Cs, ballon.Ce1) annotation (Line(points={{-8,28},{-8,20},{-30,
          20},{-30,-20}}, color={0,0,255}));
  connect(dega1.Ce4, TubeVap.C2) annotation (Line(points={{8,28.4},{8,20},{30,
          20},{30,12}}));
  connect(ballon.yLevel, yLevel)
    annotation (Line(points={{33,-50},{80,-50},{80,0.5},{113,0.5}}));
  annotation (Diagram(graphics),
                       Icon(graphics={
        Rectangle(
          extent={{-82,12},{82,-80}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-48,98},{48,20}},
          lineColor={0,0,0},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{20,26},{24,12}},
          lineColor={255,255,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-24,26},{-20,12}},
          lineColor={255,255,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-90,80},{-40,80},{-40,80},{-40,80}}, color={0,0,0}),
        Line(points={{-92,40},{-38,40}}, color={0,0,0}),
        Line(points={{90,80},{40,80}}, color={0,0,0}),
        Rectangle(
          extent={{-82,12},{82,-34}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end Degasifier;
