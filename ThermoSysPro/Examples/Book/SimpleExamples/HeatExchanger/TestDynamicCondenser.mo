within ThermoSysPro.Examples.Book.SimpleExamples.HeatExchanger;
model TestDynamicCondenser

  parameter Real COP1( fixed=false,start=0.7)
    "Corrective terme for heat exchange coefficient or Fouling coefficient";

  //parameter Modelica.SIunits.MassFlowRate QCRF = 20000 "CRF mass flow rate";
  //parameter Modelica.SIunits.Position z=1.05 "Liquid level in Cavity";

  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ Source_Eau(
                h0=50000, Q0=19000)
          annotation (Placement(transformation(extent={{-191,-27},{-133,29}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ Source_vapeur(Q0=310, h0=
        2400e3)
            annotation (Placement(transformation(extent={{-192,144},{-134,200}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ Puit_condenseur1(Q0=310)
             annotation (Placement(transformation(extent={{151,-187},{213,-133}},
          rotation=0)));

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicCondenser DynamicCondenser(
    Dc=0.016,
    ec=0.5e-3,
    ntubest=52176,
    cp=506,
    rho=7780,
    lambda=20,
    Ns=5,
    Rv=8.15,
    Vf0=140/2500,
    Lv=12,
    L2=12,
    Ce2(h_vol(fixed=false, start=55390), h(fixed=false, start=55390)),
    ntubesV=223,
    pipe_3(
      mode=1,
      dynamic_mass_balance=false,
      inertia=false,
      simplified_dynamic_energy_balance=true,
      C2(h(start=55390, fixed=false)),
      P(start={110000,109000,108000,107000,106000,105000,104000}),
      h(start={50000,65000,80000,95000,115000,140000,160000})),
    P0c=3199.2,
    DynamicCondenser(
      steady_state=true,
      Cal_hcond=true,
      Mp=50e3,
      Vertical=true,
      Kpa=0.01,
      zl(fixed=false, start=0.65),
      Qcond(start=380),
      hl(start=105e3),
      hcond=2e3,
      COP=COP1,
      hv(start=115.1e3),
      P(fixed=true, start=3199.2)))
                annotation (Placement(transformation(extent={{-47,-52},{71,64}},
          rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP Puit_Eau(
    option_temperature=2,
    mode=0,
    P0=100000)
             annotation (Placement(transformation(extent={{181,-8},{201,12}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    PressureLoss_VapeurIn(
    Q(start=900),
    K=1e-4,
    Pm(start=10000))      annotation (Placement(transformation(extent={{-100,
            162},{-80,182}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.ControlValve Valve_ext(
    mode=1,
    Q(fixed=false, start=927),
    C1(P(start=10000), Q(start=927)),
    Cvmax=15000,
    Pm(start=10000))      annotation (                          Placement(
        transformation(extent={{50,-164},{70,-144}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Sources.Constante Level(k=0.8)
                          annotation (Placement(transformation(extent={{113,
            -123},{91,-101}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    PressureLoss_VapeurIn_in4(K=1e-4, Q(fixed=false, start=0.01))
                         annotation (Placement(transformation(extent={{-102,83},
            {-82,102}}, rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceQ Source_Vsup1(Q0=0.00001,
      h0=2759.6e3)
          annotation (                           Placement(transformation(
          extent={{-191,65},{-134,119}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps Vapeur_BP(
      Table=[0,310; 22,310; 24,150; 25,80; 28,15; 31,0.000001; 35,0.000001;
        1000,0.000001])
    annotation (Placement(transformation(extent={{-202,182},{-182,202}},
          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    PressureLoss_EauOut(
    K=1e-4,
    Q(start=20000),
    mode=1)              annotation (Placement(transformation(extent={{112,-8},
            {132,12}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.IdealCheckValve PressureLoss_VapeurIn1(
     Q(start=1000))       annotation (Placement(transformation(
        origin={12,96},
        extent={{-6,-9},{6,9}},
        rotation=270)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1DTemps Debit_Eau(Table=[0,
        19000; 8,3000; 9,1500; 9.6,0.000001; 100,0.000001])
    annotation (Placement(transformation(extent={{-202,22},{-182,42}}, rotation=
           0)));
  InstrumentationAndControl.Blocks.Tables.Table1DTemps Vapeur_GCT1(Table=[0,
        0.0001; 22,0.0001; 24,2.02; 25,100; 26,150; 28,300; 29.7,590; 30.2,600;
        30.5,590; 31,570; 35,250; 40,100; 45,15; 47,0.000001; 200,0.000001;
        1000,0.000001])
    annotation (Placement(transformation(extent={{-202,110},{-182,130}},
          rotation=0)));
equation
  connect(Source_vapeur.C, PressureLoss_VapeurIn.C1)
                                               annotation (Line(
      points={{-134,172},{-100,172}},
      color={255,0,0},
      thickness=0.5));
  connect(DynamicCondenser.C2ex, Valve_ext.C1)
    annotation (Line(points={{12,-52},{12,-160},{50,-160}}, color={0,0,255}));
  connect(Valve_ext.C2, Puit_condenseur1.C)
    annotation (Line(points={{70,-160},{151,-160}}, color={0,0,255}));

  connect(Source_Vsup1.C,PressureLoss_VapeurIn_in4. C1)
                                           annotation (Line(
      points={{-134,92},{-100,92},{-100,92.5},{-102,92.5}},
      color={255,0,0},
      thickness=0.5));
  connect(DynamicCondenser.Ce2, PressureLoss_EauOut.C1) annotation (Line(
      points={{70.41,5.42},{112,5.42},{112,2}},
      color={0,0,255},
      thickness=0.5));
  connect(PressureLoss_EauOut.C2, Puit_Eau.C) annotation (Line(
      points={{132,2},{181,2}},
      color={0,0,255},
      thickness=0.5));
  connect(DynamicCondenser.C1vap, PressureLoss_VapeurIn1.C2) annotation (Line(
      points={{12,64},{12,90}},
      color={255,0,0},
      thickness=0.5));
  connect(Source_vapeur.IMassFlow, Vapeur_BP.y)
    annotation (Line(points={{-163,186},{-163,192},{-181,192}}, thickness=0.5));
  connect(Source_Eau.C, DynamicCondenser.Ce1) annotation (Line(
      points={{-133,1},{-49.5,1},{-49.5,5.42},{-47,5.42}},
      color={0,0,255},
      thickness=0.5));
  connect(DynamicCondenser.C2vap, PressureLoss_VapeurIn_in4.C2) annotation (
      Line(
      points={{-19.27,64},{-18,64},{-18,92.5},{-82,92.5}},
      color={255,0,0},
      thickness=0.5));
  connect(Level.y, Valve_ext.Ouv)
    annotation (Line(points={{89.9,-112},{60,-112},{60,-143}}));
  connect(Debit_Eau.y, Source_Eau.IMassFlow)
    annotation (Line(points={{-181,32},{-162,32},{-162,15}}, thickness=0.5));
  connect(PressureLoss_VapeurIn.C2, PressureLoss_VapeurIn1.C1) annotation (Line(
      points={{-80,172},{12,172},{12,102}},
      color={255,0,0},
      thickness=0.5));
  connect(Source_Vsup1.IMassFlow, Vapeur_GCT1.y) annotation (Line(points={{
          -162.5,105.5},{-162.5,120},{-181,120}}, thickness=0.5));
  annotation (Diagram(graphics,
                      coordinateSystem(preserveAspectRatio=false,extent={{-200,
            -200},{200,200}})),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
        info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019 </p>
<p><b>ThermoSysPro Version 3.2 </p>
<p>This model is documented in Sect. 9.5.4.2 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"),
    experiment(StopTime=500),
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
end TestDynamicCondenser;
