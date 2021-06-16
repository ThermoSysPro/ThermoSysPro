within ThermoSysPro.Examples.SimpleExamples;
model TestDynamicExchangerWaterSteamFlueGases

  MultiFluids.HeatExchangers.DynamicExchangerWaterSteamFlueGases Echangeur(
    Ns=10,
    TwoPhaseFlowPipe(P(start={130e5,130e5,130e5,130e5,130e5,130e5,130e5,130e5,130e5,130e5,130e5,130e5}),h(start={15e5,15e5,15e5,15e5,15e5,15e5,15e5,15e5,15e5,15e5,15e5,15e5})),
    z2=10,
    Ntubes=1480,
    ExchangerWall(e=0.0026, lambda=47),
    L=21,
    Dint=32e-3,
    ExchangerFlueGasesMetal(
      step_L=0.092,
      step_T=0.087,
      Fa=1,
      Dext=0.0372,
      CSailettes=12,
      Encras(fixed=true) = 1,
      K(fixed=false, start=40)))
                annotation (Placement(transformation(extent={{-60,-58},{60,58}},
          rotation=0)));

  ThermoSysPro.FlueGases.BoundaryConditions.SourcePQ Source_Fumees(
    Xso2=0,
    P0=1.1e5,
    T0=750,
    Xco2=0.06,
    Xh2o=0.06,
    Xo2=0.14,
    Q0=610)
    annotation (Placement(transformation(extent={{-20,38},{0,58}},  rotation=0)));
  ThermoSysPro.FlueGases.BoundaryConditions.Sink Puits_Fumees
    annotation (Placement(transformation(
        origin={10,-50},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  WaterSteam.BoundaryConditions.SourceP Source_WSteam(
    option_temperature=2,
    mode=0,
    h0=1.46e6,
    C(Q(fixed=true, start=150)),
    P0(fixed=false) = 13000000,
    T0=610)
    annotation (Placement(transformation(extent={{-104,-10},{-84,10}},rotation=
            0)));
  WaterSteam.BoundaryConditions.SinkP Puits_WSteam(
    option_temperature=2,
    mode=0,
    P0=13000000)
    annotation (Placement(transformation(
        origin={94,0},
        extent={{10,-10},{-10,10}},
        rotation=180)));
equation
  connect(Source_Fumees.C, Echangeur.Cfg1) annotation (Line(
      points={{0,48},{0,29}},
      color={0,0,0},
      thickness=1));
  connect(Puits_Fumees.C, Echangeur.Cfg2) annotation (Line(
      points={{0.2,-50},{0,-50},{0,-29}},
      color={0,0,0},
      thickness=1));
  connect(Source_WSteam.C, Echangeur.Cws1)
    annotation (Line(points={{-84,0},{-60,0}},                     color={0,0,
          255}));
  connect(Echangeur.Cws2, Puits_WSteam.C)
    annotation (Line(points={{60,0},{84,0}},                   color={255,0,0}));
  annotation (           Icon(graphics={
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
<p><b>ThermoSysPro Version 3.2 </h4>
</html>"));
end TestDynamicExchangerWaterSteamFlueGases;
