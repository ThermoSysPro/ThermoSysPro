within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestDynamicWaterHeatingOnePipe
  parameter ThermoSysPro.Units.xSI.Cv CvmaxWater(fixed=false, start=68.5297)
    "Maximum CV (active if mode_caract=0)";
  parameter Real LambdaPipe(fixed=false,start=0.003003)
    "Friction pressure loss coefficient (active if lambda_fixed=true)";

  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP(
    option_temperature=false,
    h0=2750.e3,
    P0=40e5)
            annotation (Placement(transformation(extent={{-192,110},{-150,150}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP Puit_condenseur1(
      option_temperature=false, P0(fixed=true) = 10e5)
             annotation (Placement(transformation(extent={{124,-202},{160,-162}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.ControlValve ControlValve_eau(
    mode_caract=0,
    Cvmax=CvmaxWater,
    Q(fixed=false, start=38.0656),
    Pm(start=24.771e5),
    h(start=906345),
    C1(h_vol_1(start=906345), h(start=906345)),
    Cv(start=34.26, fixed=false))
                          annotation (Placement(transformation(extent={{88,-186},
            {108,-166}}, rotation=0)));

  ThermoSysPro.Fluid.HeatExchangers.DynamicWaterHeaterOnePipe WaterHeating(
    ec=2e-3,
    Ns=10,
    Rv=1.2,
    Lc=2.5,
    PasL=0.028,
    PasT=0.024,
    ntubes3=1500,
    Dc=0.018,
    ntubes1=400,
    ntubes2=400,
    L1=11,
    L2=11,
    L3=22,
    C2ex(P(start=3953920.2674434385)),
    Wall_3(
      Tp(start={497.4216192636609,502.69423468274414,506.9759296757205,
            510.4223715331536,513.1750788320363,515.3580718035844,
            517.0775540203194,518.4230303861297,519.4690257033071,
            520.2769753151857,520.8970764101637,521.3700027404278,
            521.7284442755915,521.9984626845046,522.2006676867453,
            522.3512258466948,522.4627164232634,522.5440949624972,
            522.5983494885799,522.6391412946117}),
      Tp1(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4,515,515.4,
            516,516.4,517,517.4,518,518.4,519,519.4}),
      Tp2(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4,515,515.4,
            516,516.4,517,517.4,518,518.4,519,519.4})),
    volumeC(h(start=1083284.4675828198), P(start=22239324.06759518)),
    volumeD(h(start=812750.3853612987), P(start=222.72e5)),
    WaterHeating(
      steady_state=true,
      Vertical=false,
      step_square=true,
      Kvl=1,
      Klp=1500,
      Kvp=1200,
      Kpa=0.2,
      V=70,
      Mp=50000,
      zl(fixed=true, start=0.5),
      P(fixed=true, start=39.5e5),
      Cv(Q(fixed=false, start=35), P(fixed=false, start=39.5e5)),
      hv(start=1431115.3931413875),
      hl(start=1083784.8007690564),
      Pfond(start=39.542e5),
      Tp1(start={500,501,502,503,504,505,506,507,508,510}),
      Tp2(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4}),
      Tp3(start={502.0668232342926,506.5603551100769,510.17517354535573,
            513.0552006761686,515.3300849797615,517.1125155075463,
            518.4982207642074,519.5672140241339,520.3855368446975,
            521.0071208743625,521.475583235511,521.8258726586643,
            522.0857355520467,522.276996946816,522.4166635499804,
            522.5178617542946,522.5906259809204,522.6416937796047,
            522.6717272169116,522.6943081560064}),
      Tp(start=522.7203786935834)),
    pipe_3(
      z2=1,
      Tp(start={492.2865845099074,498.42043682971996,503.43932965553495,
            507.5119139438755,510.7928300582301,513.4186242679523,
            515.5070797958261,517.1581940553467,518.4558696409629,
            519.4698368458761,520.2575667844292,520.866061927203,
            521.3334770960658,521.6905573412918,521.9618953291181,
            522.1670184035046,522.3213189657012,522.4362044759667,
            522.5172341741693,522.5781571584042}),
      h(start={812750.375,863278.0600600096,905331.3426571415,940130.751800155,
            968769.0495620216,992209.8823638612,1011293.6430149649,
            1026746.7829727756,1039192.5095809929,1049161.7546575891,
            1057103.8294379094,1063396.4712379558,1068355.1441001317,
            1072241.5390561111,1075271.2636377309,1077620.734010462,
            1079433.2969658624,1080824.6185597836,1081886.238523024,
            1082684.3963576336,1083284.4675828198,1083284.5}),
      hb(start={813e3,826e3,850e3,865e3,880e3,895e3,905e3,920e3,935e3,950e3,
            965e3,980e3,995e3,1010e3,1120e3,1130e3,1040e3,1050e3,1060e3,1070e3,
            1080e3}),
      Q(start={202.4,202.4,202.4,202.4,202.4,202.4,202.4,202.4,202.4,202.4,
            202.4,202.4,202.4,202.4,202.4,202.4,202.4,202.4,202.4,202.4,202.4}),
      P(start={22269346.0,22267948.39153832,22266544.294239394,
            22265134.171108145,22263718.740660597,22262298.715698708,
            22260874.773397826,22259447.536273584,22258017.56171816,
            22256585.338030815,22255151.28511641,22253715.75831186,
            22252279.054104224,22250841.416797128,22249403.045444023,
            22247964.100585815,22246524.71050402,22245084.976831134,
            22243644.979685582,22242204.783200525,22240764.436308913,22239324.0})),
    P0c=4000000) annotation (Placement(transformation(extent={{-58,-90},{162,96}},
          rotation=0)));

  ThermoSysPro.Fluid.BoundaryConditions.Sink Puit_condenseur2
             annotation (Placement(transformation(extent={{-150,22},{-192,66}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLossWaterIn(                           K=35, Q(fixed=false,
        start=250),
    Pm(start=22270672.891128033))
                             annotation (Placement(transformation(extent={{-99,
            -48},{-79,-28}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLossWaterOut(                           K=30, Q(fixed=false,
        start=250),
    Pm(start=22238086.493105933),
    C2(h_vol_1(start=1082650), h(start=1082650)))
                               annotation (Placement(transformation(extent={{
            -80,34},{-100,54}}, rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceP sourceP1(
    option_temperature=true,
    P0=220e5,
    h0=900e3,
    T0=482.87)
    annotation (Placement(transformation(extent={{-192,-60},{-150,-16}},
          rotation=0)));
  ThermoSysPro.Fluid.BoundaryConditions.RefQ refQ(Q0=53, C1(h_vol_1(start=
            1082.65e3), h(start=1082.65e3)))
    annotation (Placement(transformation(extent={{-115,34},{-135,54}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps Debit_eauA(
      Table=[0,260; 378,260; 390,238; 438,275; 507,135; 936,65; 1404,50; 1872,
        50])       annotation (Placement(transformation(extent={{-195,78},{-175,
            98}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Level(k=0.50)
                          annotation (Placement(transformation(extent={{135,
            -152},{113,-130}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.IdealCheckValve checkValve(Qmin=0.5, C2(h_vol_1(
          start=2750.e3), h(start=2750.e3)))
    annotation (Placement(transformation(extent={{-100,122},{-84,138}},
          rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.SingularPressureLoss
    singularPressureLossPurge(                          K=1e-3,
    T(fixed=false, start=461.56),
    Q(fixed=false, start=35),
    Pm(start=3953920.266328794),
    C2(h_vol_1(start=906340), h(start=906340)))
                         annotation (Placement(transformation(
        origin={54,-138},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    Pression_purge(Table=[0,10e5; 378,10e5; 418,7e5; 1145,3.9e5; 2000,3.9e5])
                   annotation (Placement(transformation(extent={{162,-178},{182,
            -158}}, rotation=0)));
  ThermoSysPro.Fluid.PressureLosses.LumpedStraightPipe PressureLoss_Steam(
    Q(fixed=false, start=35),
    L=10,
    D=0.1,
    lambda=LambdaPipe,
    Pm(start=40.34e5),
    C1(h_vol_1(start=2750e3), h(start=2750e3)))
                         annotation (Placement(transformation(extent={{-48,162},
            {30,98}}, rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Pression_Turbine1(Table=
        [0,41.19e5; 378,41.19e5; 418,21.e5; 1145,5.e5; 2000,5.e5])
                   annotation (Placement(transformation(extent={{-195,160},{
            -175,180}}, rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Pression_eauA2(
                  Table=[0,222.72e5; 378,222.72e5; 438,230e5; 597,217e5; 1000,
        216e5; 1533,214e5; 1863,213.5e5; 2340,213e5; 2500,213e5])
                   annotation (Placement(transformation(extent={{-195,-8},{-175,
            12}}, rotation=0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Temperature_eauA1(Table=
        [0,462; 448,462; 1155,420.0; 2000,420.0])
                   annotation (Placement(transformation(extent={{-196,-84},{
            -176,-64}}, rotation=0)));
equation
  connect(ControlValve_eau.C2, Puit_condenseur1.C)
    annotation (Line(points={{108,-182},{124,-182}}, color={0,0,255}));
  connect(Puit_condenseur2.C,refQ. C2) annotation (Line(
      points={{-150,44},{-135,44}},
      color={255,0,0},
      thickness=0.5));
  connect(refQ.C1, singularPressureLossWaterOut.C2)
    annotation (Line(
      points={{-115,44},{-100,44}},
      color={255,0,0},
      thickness=0.5));
  connect(sourceP1.C, singularPressureLossWaterIn.C1)
                                                annotation (Line(
      points={{-150,-38},{-99,-38}},
      color={0,0,255},
      thickness=0.5));
  connect(singularPressureLossWaterOut.C1, WaterHeating.Ce2)
    annotation (Line(
      points={{-80,44},{-64,44},{-64,43.92},{-58,43.92}},
      color={255,0,0},
      thickness=0.5));
  connect(singularPressureLossWaterIn.C2, WaterHeating.Ce1)
                                                      annotation (Line(
      points={{-79,-38},{-58,-38},{-58,-38.85}},
      color={0,0,255},
      thickness=0.5));
  connect(sourceP.C, checkValve.C1) annotation (Line(
      points={{-150,130},{-100,130}},
      color={127,0,0},
      thickness=1));
  connect(singularPressureLossPurge.C1, WaterHeating.C2ex)
    annotation (Line(points={{54,-128},{54,-90},{52,-90}}));
  connect(Pression_purge.y, Puit_condenseur1.IPressure)
    annotation (Line(points={{183,-168},{196,-168},{196,-182},{151,-182}}));
  connect(checkValve.C2, PressureLoss_Steam.C1)         annotation (Line(
      points={{-84,130},{-48,130}},
      color={127,0,0},
      thickness=1));
  connect(WaterHeating.C1vap, PressureLoss_Steam.C2) annotation (Line(
      points={{52,96},{52,130},{30,130}},
      color={127,0,0},
      thickness=1));
  connect(singularPressureLossPurge.C2, ControlValve_eau.C1) annotation (Line(
        points={{54,-148},{54,-182},{88,-182}}, color={0,0,255}));
  connect(Pression_Turbine1.y, sourceP.IPressure) annotation (Line(points={{
          -174,170},{-174,152},{-190,152},{-190,130},{-181.5,130}}));
  connect(Pression_eauA2.y, sourceP1.IPressure) annotation (Line(points={{-174,
          2},{-174,-10},{-194,-10},{-194,-38},{-181.5,-38}}));
  connect(Debit_eauA.y, refQ.IMassFlow)
    annotation (Line(points={{-174,88},{-125,88},{-125,55}}));
  connect(Level.y, ControlValve_eau.Ouv)
    annotation (Line(points={{111.9,-141},{98,-141},{98,-165}}));
  connect(Temperature_eauA1.y, sourceP1.ISpecificEnthalpyOrTemperature)
    annotation (Line(points={{-175,-74},{-171,-74},{-171,-49}}, color={0,0,255}));
  annotation (Diagram(coordinateSystem(extent={{-200,-200},{200,200}}),
                               graphics={
        Text(
          extent={{-124,206},{130,146}},
          lineColor={0,0,255},
          textString=
              "1 Ouv et 1 Cvmax = false, Qvap et niveau=true ou P cavite"),
        Text(
          extent={{-74,-190},{118,-222}},
          lineColor={0,0,255},
          textString=
               "COP0l_coef_h =false  , T_Dp_purge=true"),
        Text(
          extent={{-186,-198},{-84,-212}},
          lineColor={0,0,255},
          textString=
               "Qvap=true  ==> Erreur"),
        Text(
          extent={{16,170},{130,156}},
          lineColor={0,0,255},
          textString=
               "checkValve  Qmin =0.5"),
        Text(
          extent={{-136,168},{-18,154}},
          lineColor={0,0,255},
          textString="With guess values")}),
    experiment(StopTime=1000, Tolerance=1e-004),
    experimentSetupOutput,
    Icon(graphics={
        Rectangle(
          lineColor={128,128,128},
          extent={{-220,-240},{220,240}},
          radius=25.0),
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end TestDynamicWaterHeatingOnePipe;
