within ThermoSysPro.Examples.Book.SimpleExamples.CombustionChamber;
model TestGenericCombustion1D "TestGenericCombustion1D"

  parameter Integer NCEL = 7;

  Combustion.CombustionChambers.GenericCombustion1D genericCombustionCCS(
    NCEL=7,
    Qm(fixed=false),
    Qsf(fixed=false),
    kcham(fixed=true) = 0.1,
    Acham=275,
    Xbf=0,
    ImbCV=0.05,
    EPSPAR=0.7,
    Kec=8.8,
    SM={639.92,198.58,466.48,466.48,466.48,358.56,358.56},
    ImbBF=0.0,
    Psf(start=113275))
    annotation (Placement(transformation(extent={{-62,-56},{62,72}}, rotation=0)));
  Combustion.BoundaryConditions.FuelSourcePQ fuelSourcePQ(
    Xn=0.0208,
    Xashes=0.136,
    Cp=1200,
    rho=1100,
    LHV=29245e3,
    Xc=0.719,
    Xh=0.0414,
    Xo=0.086,
    Xs=0.0044,
    Vol=0.286,
    Q0=57.20,
    T0=358.15,
    Hum=0.08)
    annotation (Placement(transformation(extent={{-106,-43},{-72,-5}}, rotation=
           0)));
  FlueGases.BoundaryConditions.SourcePQ sourceAir(
    Xso2=0,
    Q0=609.29,
    Xh2o=0.01,
    Xo2=0.230,
    Xco2=0,
    P0=191000,
    T0=524.89)
    annotation (Placement(transformation(extent={{-44,-98},{0,-58}}, rotation=0)));
  FlueGases.BoundaryConditions.Sink sink annotation (Placement(transformation(
          extent={{0,70},{44,112}}, rotation=0)));
  WaterSteam.BoundaryConditions.SourcePQ SourcePQ_Water(Q0=0, P0=100000)
    annotation (Placement(transformation(extent={{-107,23},{-71,57}}, rotation=
            0)));
  WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe              PipeWaterSteam(
    Ns=7,
    z2=56,
    rugosrel=5e-5,
    ntubes=403,
    L=58,
    D=0.0327,
    C2(Q(fixed=false, start=486.69), P(
        fixed=false,
        start=1.96318e+07,
        displayUnit="Pa")),
    dpfCorr=3.5)
    annotation (Placement(transformation(
        origin={91,8},
        extent={{49,16},{-49,-16}},
        rotation=270)));
  Thermal.HeatTransfer.HeatExchangerWall              paroiEcrans(
    Ns=7,
    lambda=40,
    steady_state=true,
    ntubes=403,
    L=58,
    D=0.0327,
    e=0.001)
    annotation (Placement(transformation(
        origin={73,7.5},
        extent={{51.5,-15},{-51.5,15}},
        rotation=270)));
  WaterSteam.BoundaryConditions.SinkP              sinkWaterSteam2(
    option_temperature=2,
    Q(start=486.69, fixed=true),
    h0=2.5e+06,
    mode=0,
    P0(fixed=false) = 19621600)
    annotation (Placement(transformation(
        origin={90,90.5},
        extent={{14.5,-15},{-14.5,15}},
        rotation=270)));
  WaterSteam.BoundaryConditions.SourceP              sourceEcrans(
    h0=1.292e+06,
    option_temperature=2,
    mode=0,
    P0=20112000)
    annotation (Placement(transformation(
        origin={91,-81},
        extent={{15,-15},{-15,15}},
        rotation=270)));
equation
  connect(fuelSourcePQ.C, genericCombustionCCS.Cfuel)
    annotation (Line(points={{-72,-24},{-55.8,-24}}, color={0,0,0}));
  connect(genericCombustionCCS.Cfg, sink.C) annotation (Line(
      points={{0,65.6},{0,91},{0.44,91}},
      color={0,0,0},
      thickness=1));
  connect(genericCombustionCCS.Ca, sourceAir.C) annotation (Line(
      points={{0,-49.6},{0,-78}},
      color={0,0,0},
      thickness=1));
  connect(SourcePQ_Water.C, genericCombustionCCS.Cws)
    annotation (Line(points={{-71,40},{-55.8,40}}, color={0,0,255}));
  connect(genericCombustionCCS.Cth,paroiEcrans. WT2) annotation (Line(points={{55.8,8},
          {68,8},{68,7.5},{76,7.5}},         color={191,95,0}));
  connect(paroiEcrans.WT1,PipeWaterSteam. CTh) annotation (Line(points={{70,7.5},
          {71,7.5},{71,8},{86.2,8}}, color={191,95,0}));
  connect(sourceEcrans.C,PipeWaterSteam. C1)
    annotation (Line(points={{91,-66},{91,-41}},   color={0,0,255}));
  connect(PipeWaterSteam.C2,sinkWaterSteam2. C) annotation (Line(points={{91,57},
          {91,76},{90,76}},       color={0,0,255}));
  annotation (Diagram(graphics),
                       Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
        info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 8.2.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"),
    Icon(graphics={
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end TestGenericCombustion1D;
