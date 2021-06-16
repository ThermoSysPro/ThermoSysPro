within ThermoSysPro.Examples.Book.SimpleExamples.HeatExchanger.DynamicWaterHeater;
model NegativeFlow

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP(
    option_temperature=2,
    mode=0,
    P0=22.733e5,
    h0=2650.6e3)
            annotation (Placement(transformation(extent={{-192,110},{-150,150}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP Puit_condenseur1(
      option_temperature=2, P0(fixed=true) = 10e5)
             annotation (Placement(transformation(extent={{124,-202},{160,-162}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve ControlValve_eau(
    Q(fixed=false, start=56),
    Cvmax(fixed=false) = 354.534,
    mode_caract=0,
    Cv(start=70, fixed=false),
    C1(h_vol(start=800e3), h(start=800e3)))
                          annotation (Placement(transformation(extent={{88,-186},
            {108,-166}}, rotation=0)));

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicWaterHeating WaterHeating(
    Dc=0.016,
    Lc=2.56,
    PasL=0.027,
    PasT=0.02338,
    ec=2e-3,
    Rv=1.130514,
    Ns=10,
    DpfCorr=1.1136,
    cp=506,
    rho=7780,
    lambda=35,
    COP0l(fixed=false) = 1.23,
    C2ex(P(start=2220000)),
    ntubes1=351,
    ntubes2=351,
    ntubes3=1319,
    L3=26.4,
    L2=13.2,
    L1=13.2,
    Wall_1(
      Tp(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4}),
      Tp1(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4}),
      Tp2(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4})),
    Wall_2(
      Tp(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4}),
      Tp1(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4}),
      Tp2(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4})),
    Wall_3(
      Tp(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4,   515,515.4,516,516.4,517,517.4,518,518.4,519,519.4}),
      Tp1(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4,   515,515.4,516,516.4,517,517.4,518,518.4,519,519.4}),
      Tp2(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4,   515,515.4,516,516.4,517,517.4,518,518.4,519,519.4})),
    volumeC(h(start=1000.65e3), P(start=68.48e5)),
    WaterHeating(
      steady_state=true,
      Vertical=false,
      step_square=true,
      zl(fixed=true, start=0.43),
      Kvl=1,
      V=53,
      Cv(P(fixed=false, start=21.867e5), Q(fixed=false, start=52.6)),
      Mp=53227,
      Klp=1500,
      Kvp=1200,
      Kpa=0.2,
      P(fixed=true, start=2216584),
      hl(start=806345),
      hv(start=1063490),
      Tp1(start={500,501,502,503,504,505,506,507,508,510}),
      Tp2(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4}),
      Tp3(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4,515,515.4,516,516.4,517,517.4,518,518.4,
            519,519.4}),
      Tp(start=509)),
    Ce1(P(start=7100000)),
    pipe_1(
      z2=0.3,
      mode=1,
      dynamic_mass_balance=true,
      simplified_dynamic_energy_balance=false,
      h(start={813e3,826e3,850e3,865e3,880e3,895e3,905e3,920e3,935e3,950e3,
            965e3,980e3}),
      hb(start={813e3,826e3,850e3,865e3,880e3,895e3,905e3,920e3,935e3,950e3,
            965e3}),
      Q(start={132,132,132,132,132,132,132,132,132,132,132}),
      advection=false,
      P(start={6870000,6869000,6868000,6867000,6866000,6865000,6864000,6863000,
            6862000,6861000,6860000,6859000}),
      Tp(start={500,501,502,503,504,505,506,507,508,510})),
    pipe_2(
      z2=0.4,
      mode=1,
      dynamic_mass_balance=true,
      simplified_dynamic_energy_balance=false,
      h(start={965e3,980e3,995e3,1010e3,1120e3,1130e3,1040e3,1050e3,1060e3,
            1070e3,1080e3,1080e3}),
      hb(start={965e3,980e3,995e3,1010e3,1120e3,1130e3,1040e3,1050e3,1060e3,
            1070e3,1080e3}),
      Q(start={132,132,132,132,132,132,132,132,132,132,132}),
      advection=false,
      P(start={6859000,6859000,6858000,6857000,6856000,6855000,6854000,6853000,
            6852000,6851000,6850000,6848000}),
      Tp(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4})),
    volumeD1(h(start=953939), P(start=6848000)),
    volumeD(
      h(start=812750),
      dynamic_mass_balance=false,
      P(start=6872000)),
    P0c=2200000,
    pipe_3(
      steady_state=true,
      mode=1,
      z2=0.7,
      dynamic_mass_balance=true,
      simplified_dynamic_energy_balance=false,
      h(start={813e3,826e3,850e3,865e3,880e3,895e3,905e3,920e3,935e3,950e3,
            965e3,980e3,995e3,1010e3,1120e3,1130e3,1040e3,1050e3,1060e3,1070e3,
            1080e3,1080e3}),
      hb(start={813e3,826e3,850e3,865e3,880e3,895e3,905e3,920e3,935e3,950e3,
            965e3,980e3,995e3,1010e3,1120e3,1130e3,1040e3,1050e3,1060e3,1070e3,
            1080e3}),
      Q(start={492,492,492,492,492,492,492,492,492,492,492,492,492,492,492,492,
            492,492,492,492,132}),
      advection=false,
      inertia=true,
      P(start={6870000,6869000,6868000,6867000,6866000,6865000,6864000,6863000,
            6862000,6861000,6860000,6859000,6858000,6857000,6856000,6855000,
            6854000,6853000,6852000,6851000,6850000,6848000}),
      Tp(start={510,510.4,511,511.4,512,512.4,513,513.4,514,514.4,515,515.4,516,
            516.4,517,517.4,518,518.4,519,519.4})))
    annotation (Placement(transformation(extent={{-58,-90},{162,96}}, rotation=
            0)));

  ThermoSysPro.WaterSteam.BoundaryConditions.Sink Puit_condenseur2(h0=940.000e3)
             annotation (Placement(transformation(extent={{-150,22},{-192,66}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossWaterIn(Q(fixed=false, start=650), K=35)
                         annotation (Placement(transformation(extent={{-99,-48},
            {-79,-28}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossWaterOut(Q(fixed=false, start=650), K=30,
    C2(h_vol(start=927700), h(start=927700)))
                         annotation (Placement(transformation(extent={{-80,34},
            {-100,54}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    Pression_eauA(Table=[0,71.29e5; 3000,71.29e5])
                   annotation (Placement(transformation(extent={{-194,-8},{-172,
            14}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    Temperature_eauA(Table=[0,454.46; 448,454.46; 1155,407.76; 2000,407.76])
                   annotation (Placement(transformation(extent={{-196,-88},{
            -176,-68}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP sourceP1(
    P0=71.29e5,
    h0=772.09e3,
    T0=454.46,
    option_temperature=1)
    annotation (Placement(transformation(extent={{-192,-16},{-150,-60}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.RefQ refQ(Q0=53)
    annotation (Placement(transformation(extent={{-115,34},{-135,54}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps Debit_eauA(Table=[0,
        624.97; 300,624.97; 2000,-200; 3000,-200])
                   annotation (Placement(transformation(extent={{-196,78},{-176,
            98}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    Pression_Turbine(Table=[0,22.733e5; 378,22.733e5; 418,11.18e5; 1145,3.e5;
        2000,3.e5])
                   annotation (Placement(transformation(extent={{-194,154},{
            -174,174}}, rotation=0)));
  ThermoSysPro.Examples.Control.Condenser_LevelControl_RE5 regulation_Niveau(
      add(k1=+1, k2=-1), pIsat1(Limiteur1(u(signal(start=0.8))))) annotation (
      Placement(transformation(extent={{140,-146},{102,-110}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Level(k=0.43)
                          annotation (Placement(transformation(extent={{191,
            -140},{169,-118}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.IdealCheckValve checkValve(C2(h_vol(start=2600e3), h(start=2600e3)))
    annotation (Placement(transformation(extent={{-100,122},{-84,138}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    singularPressureLossPurge(Q(fixed=false, start=56), K=1e-3,
    T(fixed=true, start=461.56),
    Pm(start=2220000))   annotation (Placement(transformation(
        origin={54,-138},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    Pression_purge(Table=[0,10e5; 378,10e5; 418,7e5; 1145,2.9e5; 2000,2.9e5])
                   annotation (Placement(transformation(extent={{162,-178},{182,
            -158}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.LumpedStraightPipe PressureLoss_Steam(
    Q(fixed=false, start=650),
    lambda(fixed=false) = 0.03,
    L=48.72,
    D=0.387)             annotation (Placement(transformation(extent={{-48,162},
            {30,98}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps
    Pression_eauA1(Table=[0,71.29e5; 378,71.29e5; 438,77e5; 597,73.8e5; 1533,
        69.8e5; 2340,68.8e5; 2500,68.8e5])
                   annotation (Placement(transformation(extent={{-196,-154},{
            -174,-132}}, rotation=0)));
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
  connect(Pression_eauA.y, sourceP1.IPressure)
                                              annotation (Line(points={{-170.9,
          3},{-172,3},{-172,-10},{-196,-10},{-196,-38},{-181.5,-38}}));
  connect(sourceP1.C, singularPressureLossWaterIn.C1)
                                                annotation (Line(
      points={{-150,-38},{-99,-38}},
      color={0,0,255},
      thickness=0.5));
  connect(Debit_eauA.y,refQ. IMassFlow) annotation (Line(points={{-175,88},{
          -124,88},{-124,55},{-125,55}}));
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
  connect(Level.y, regulation_Niveau.ConsigneNiveauEau) annotation (Line(points=
         {{167.9,-129},{157.45,-129},{157.45,-122.6},{140.95,-122.6}}));
  connect(WaterHeating.sortieReelle, regulation_Niveau.MesureNiveauEau)
    annotation (Line(points={{164.2,-67.68},{184,-67.68},{184,-111.8},{140.95,
          -111.8}}));
  connect(regulation_Niveau.SortieReelle1, ControlValve_eau.Ouv)
    annotation (Line(points={{101.05,-144.2},{98,-144.2},{98,-165}}));
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-200,
            -200},{200,200}}), graphics={
        Text(
          extent={{-130,218},{124,158}},
          lineColor={0,0,255},
          textString=
               "1 Ouv et 1 Cvmax =false  , Qvap et niveau=true ou P cavite"),
        Text(
          extent={{-90,-188},{102,-220}},
          lineColor={0,0,255},
          textString=
               "COP0l_coef_h =false  , T_Dp_purge=true"),
        Text(
          extent={{-202,-196},{-100,-210}},
          lineColor={0,0,255},
          textString=
               "Qvap=true  ==> Erreur"),
        Text(
          extent={{-118,152},{-62,138}},
          lineColor={0,0,255},
          textString=
               "Qmin = 0")}), experiment(StopTime=3000),
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 7.2.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end NegativeFlow;
