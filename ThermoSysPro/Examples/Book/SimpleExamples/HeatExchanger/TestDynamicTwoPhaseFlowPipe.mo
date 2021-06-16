within ThermoSysPro.Examples.Book.SimpleExamples.HeatExchanger;
model TestDynamicTwoPhaseFlowPipe

  WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe dynamicTwoPhaseFlowPipe1(
    L=10,
    D=0.03,
    dpfCorr(fixed=false,
      start=0.23963336533422905)=
                           1,
    P(start={2000000.0,1999571.707027408,1999140.94021676,1998707.6248918818,
          1998271.6837222823,1997833.0364982954,1997391.599890757,
          1996715.8221090273,1995640.018272837,1994163.014585635,
          1992283.4952231126,1990000.0}))
                            annotation (Placement(transformation(extent={{-40,-48},
            {40,10}},      rotation=0)));
  WaterSteam.BoundaryConditions.SourceP sourceP1(
    C(Q(fixed=true, start=1)),
    option_temperature=2,
    mode=0,
    h0=800e3,
    P0=2000000)
    annotation (Placement(transformation(extent={{-90,-28},{-70,-8}}, rotation=
            0)));
  WaterSteam.BoundaryConditions.SinkP sinkP1(
    option_temperature=2,
    h0=2000e3,
    mode=0,
    P0=19.9e5)
    annotation (Placement(transformation(extent={{70,-28},{90,-8}}, rotation=0)));
  Thermal.BoundaryConditions.HeatSource heatSource1(
    option_temperature=2,
    T0={1000,1100,1200,1300,1400,1500,1600,1700,1800,1900},
    W0={2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4,2e4})
    annotation (Placement(transformation(extent={{-10,31},{10,51}}, rotation=0)));
  Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall1(            Ns=10,
    L=10,
    lambda=10,
    cpw=460,
    rhow=7900,
    e=0.005,
    D=0.03)
    annotation (Placement(transformation(extent={{-40,-28},{40,52}},rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe rampe(
    Initialvalue=20e5,
    Starttime=300,
    Duration=600,
    Finalvalue=19.8e5)
                     annotation (Placement(transformation(extent={{-74,-4},{-86,
            7}}, rotation=0)));
equation
  connect(sourceP1.C, dynamicTwoPhaseFlowPipe1.C1) annotation (Line(points={{-70,-18},
          {-42,-18},{-42,-22},{-42,-20},{-42,-19},{-40,-19}},          color={0,
          0,255}));
  connect(dynamicTwoPhaseFlowPipe1.C2, sinkP1.C) annotation (Line(points={{40,-19},
          {40,-19},{40,-18},{70,-18}},      color={0,0,255}));
  connect(heatSource1.C, heatExchangerWall1.WT2)
    annotation (Line(points={{0,31.2},{0,18},{0,20}},    color={191,95,0}));
  connect(heatExchangerWall1.WT1, dynamicTwoPhaseFlowPipe1.CTh)
    annotation (Line(points={{0,4},{0,-10.3}},   color={191,95,0}));
  connect(rampe.y, sourceP1.IPressure)
    annotation (Line(points={{-86.6,1.5},{-92,1.5},{-92,-18},{-85,-18}}));
  annotation (experiment(StopTime=1500), Icon(graphics={
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
<p>This model is documented in Sect. 9.4.2.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestDynamicTwoPhaseFlowPipe;
