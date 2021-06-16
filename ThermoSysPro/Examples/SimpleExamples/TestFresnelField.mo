within ThermoSysPro.Examples.SimpleExamples;
model TestFresnelField

public
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall heatExchangerWall(
    ntubes=1,
    steady_state=true,
    L=54,
    D=0.07,
    e=0.004,
    Ns=30,
    T0=500,
    lambda=20,
    cpw=500,
    rhow=8000,
    Tp(start={628.0843201819387,627.9310075597404,627.8220175907211,
          627.7368992018166,627.6679716601412,627.6112649113921,
          627.5643995456558,627.5258238160011,627.4944728950805,
          627.4695948757801,627.4506537300122,627.4372716636091,
          627.4291939746797,627.426267226699,627.428426585461,627.4356896138493,
          627.4481553612113,627.4660085346942,627.4895290639054,
          627.5191082002851,627.5552734790091,627.5987264837852,
          627.6504001032708,627.7115474128314,627.7838847016081,
          627.8698331666657,627.9729350144038,629.4253815385038,
          633.135688507217,636.2622387488283}),
    Tp1(start={610.2709965207655,610.0984334604643,609.9757644369477,
          609.8799665740102,609.8023932206363,609.7385750723525,
          609.6858335131916,609.6424216866362,609.6071408778737,
          609.5791446660139,609.5578296140685,609.5427704711935,
          609.533680491646,609.5303869740989,609.5328169418054,609.540990157294,
          609.5550181389947,609.5751088339957,609.6015773714007,
          609.6348642175905,609.6755632868924,609.7244644309128,
          609.7826179283193,609.8514345863706,609.9328467812495,
          610.0295806069864,610.1456244663702,611.7808730290952,
          615.9622431406954,619.4903247027197}),
    Tp2(start={644.9596553467713,644.824579502235,644.7285482944553,
          644.6535470354397,644.592810046145,644.5428402353538,
          644.5015416419557,644.4675473586904,644.4399193877858,
          644.4179953736024,644.4013031238645,644.3895098327511,
          644.3823911261306,644.3798118348441,644.3817148399042,644.38811560583,
          644.3991013774125,644.4148348525065,644.4355626048274,
          644.4616292617266,644.4934994867675,644.531791236838,
          644.5773261834961,644.6312079828199,644.6949482231629,
          644.7706792525222,644.8615205623447,646.1407907783827,
          649.404839172216,652.1510013554424}))
    annotation (Placement(transformation(extent={{-40,-36},{40,-2}}, rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.DynamicTwoPhaseFlowPipe
    dynamicTwoPhaseFlowPipe(
    ntubes=1,
    mode=0,
    steady_state=true,
    L=54,
    rugosrel=0.00005,
    dpfCorr=1,
    Ns=30,
    P(start={12512365.778485337,12512269.4730028,12512159.010926897,
          12512028.619141866,12511878.28140543,12511707.984695798,
          12511517.718132183,12511307.472416837,12511077.239500606,
          12510827.012364838,12510556.784871727,12510266.551658653,
          12509956.30806284,12509626.050068311,12509275.774270097,
          12508905.477852736,12508515.15858121,12508104.814803492,
          12507674.445464557,12507224.050132478,12506753.629037917,
          12506263.183129327,12505752.714147368,12505222.224723859,
          12504671.718513375,12504101.200370008,12503510.676589508,
          12502896.415784404,12502231.48634808,12501522.52554151,
          12500776.553197166,12500000.0}),
    h(start={1500000.0,1536254.1810191544,1572547.5410785251,1608868.7411348266,
          1645211.676359884,1681572.2077847784,1717947.2125321354,
          1754334.1766730088,1790730.9833788855,1827135.788296852,
          1863546.9394607474,1899962.9220483964,1936382.3178860326,
          1972803.7739566958,2009225.9764870608,2045647.6282789519,
          2082067.4276265746,2118484.0474634594,2154896.1134394333,
          2191302.179544121,2227700.6996020116,2264089.9923674623,
          2300468.196934767,2336833.213464297,2373182.6211112435,
          2409513.559261445,2445822.5467506223,2482105.1942732874,
          2518015.7979130256,2552967.680496474,2587102.355161259,
          82548.43470391157}),
    D=0.07,
    inertia=false)          annotation (Placement(transformation(extent={{-36,
            -67},{36,-20}}, rotation=0)));
  Solar.Collectors.FresnelField champThermosolaireLFR_N(
    A=5.5e4,
    T0=500,
    Ns=30,
    T(start=fill(500, 30)),
    F12=0.6366)
    annotation (Placement(transformation(extent={{-40,-16},{40,72}}, rotation=0)));
  WaterSteam.BoundaryConditions.SinkP sinkP(
    h0=2000e3, P0=125e5)          annotation (Placement(transformation(extent={
            {48,-54},{68,-34}}, rotation=0)));
  WaterSteam.BoundaryConditions.SourceQ sourceP(Q0=11, h0=1500e3)
               annotation (Placement(transformation(extent={{-69,-53},{-49,-33}},
          rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe DNI(
    Starttime=100,
    Initialvalue=100,
    Duration=3600,
    Finalvalue=900) annotation (Placement(transformation(extent={{72,39},{58,53}},
          rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe Angles(
    Starttime=100,
    Initialvalue=45,
    Finalvalue=45,
    Duration=3600)  annotation (Placement(transformation(extent={{-10,59},{4,72}},
          rotation=0)));
  InstrumentationAndControl.Blocks.Sources.Rampe Q(
    Starttime=100,
    Duration=3600,
    Finalvalue=10,
    Initialvalue=2) annotation (Placement(transformation(extent={{-65,-32},{-51,
            -19}}, rotation=0)));
equation
  connect(champThermosolaireLFR_N.P, heatExchangerWall.WT2)
    annotation (Line(points={{0,1.6},{0,-15.6}}, color={191,95,0}));
  connect(heatExchangerWall.WT1, dynamicTwoPhaseFlowPipe.CTh) annotation (Line(
        points={{0,-22.4},{0,-36.45}}, color={191,95,0}));
  connect(dynamicTwoPhaseFlowPipe.C2, sinkP.C) annotation (Line(points={{36,
          -43.5},{47,-43.5},{47,-44},{48,-44}}, color={0,0,255}));
  connect(champThermosolaireLFR_N.SunDNI, DNI.y)
    annotation (Line(points={{44,45.6},{51,45.6},{51,46},{57.3,46}}));
  connect(champThermosolaireLFR_N.SunG, Angles.y)
    annotation (Line(points={{27.2,58.8},{27.2,65.5},{4.7,65.5}}));
  connect(champThermosolaireLFR_N.SunA, Angles.y)
    annotation (Line(points={{36.8,58.8},{36.8,70},{6,70},{6,65.5},{4.7,65.5}}));
  connect(Q.y, sourceP.IMassFlow)
    annotation (Line(points={{-50.3,-25.5},{-50,-25.5},{-50,-38},{-59,-38}}));
  connect(sourceP.C, dynamicTwoPhaseFlowPipe.C1) annotation (Line(points={{-49,
          -43},{-47.5,-43},{-47.5,-43.5},{-36,-43.5}}, color={0,0,255}));
  annotation (
      Diagram(graphics),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni</li>
</ul>
</html>", info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </h4>
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
end TestFresnelField;
