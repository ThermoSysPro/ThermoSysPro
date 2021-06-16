within ThermoSysPro.FlueGases.TAC;
model GTCICOBarilla "Combustion turbine for CICO and Barilla plants"

  parameter Real comp_tau_n=11.5 "Nominal compression nominal rate";
  parameter Real comp_eff_n=0.79257 "Compressor nominal efficiency";
  parameter Real exp_tau_n=0.079255386 "Turbine nominal expansion rate";
  parameter Real exp_eff_n=0.881225 "Turbine nominal efficiency";
  parameter Real TurbQred=0.00449194 "Turbine reduced mass flow rate";
  parameter Modelica.SIunits.Power Wpth=50000
    "Combustion chamber thermal losses";

  BoundaryConditions.AirHumidity xAIR
                    annotation (Placement(transformation(
        origin={-84,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.FlueGases.Machines.Compressor Compresseur(
    tau_n=comp_tau_n,
    is_eff_n=comp_eff_n,
    tau(start=12.92),
    Ps(start=12.92e5, fixed=false),
    Te(start=660.36))                      annotation (Placement(transformation(
          extent={{-80,-10},{-60,10}}, rotation=0)));
  Junctions.Splitter2 separateur_Fumees
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}}, rotation=
            0)));
  ThermoSysPro.Combustion.CombustionChambers.GTCombustionChamber
    chambreCombustionTAC(
    Acham=1,
    eta_comb=1,
    Pea(start=11e5),
    Qsf(start=150),
    Qea(start=151),
    Psf(start=12.6616e5),
    Tsf(start=1350),
    XsfH2O(start=4.59e-2),
    XsfO2(start=1.56e-1),
    XsfSO2(start=5.55e-10),
    exc(start=3.35728),
    Wpth=Wpth)         annotation (Placement(transformation(extent={{-10,40},{
            10,60}}, rotation=0)));
  Junctions.Mixer2 melangeur2_fumees2_1
    annotation (Placement(transformation(extent={{20,-10},{40,10}}, rotation=0)));
  ThermoSysPro.FlueGases.PressureLosses.InvSingularPressureLoss tub_fumees
                                             annotation (Placement(
        transformation(
        origin={26,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ThermoSysPro.FlueGases.Machines.CombustionTurbine TurbineAgaz(
                    Q(start=160),
    Wmech(start=42.3e6),
    Ps(start=1.003e5),
    Ts(start=800.16),
    Qred=TurbQred,
    is_eff_n=exp_eff_n,
    tau_n=exp_tau_n)               annotation (Placement(transformation(extent=
            {{60,-10},{80,10}}, rotation=0)));
  ThermoSysPro.MultiFluids.HeatExchangers.StaticExchangerWaterSteamFlueGases
    KettleBoiler(
    Kdpe=1,
    W(start=1e6),
    Hse(start=2000e3),
    Kdpf=1000,
    EffEch=0.9,
    Tse(start=435),
    Hee(start=4.71e5),
    Qe(start=0.52))
    annotation (Placement(transformation(
        origin={0,-50},
        extent={{-10,10},{10,-10}},
        rotation=270)));
  Connectors.FlueGasesInletI Entree_air
    annotation (Placement(transformation(extent={{-104,-4},{-96,4}}, rotation=0)));
  Connectors.FlueGasesOutletI Sortie_fumees
    annotation (Placement(transformation(extent={{96,-4},{104,4}}, rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI Entree_KB
    annotation (Placement(transformation(extent={{-104,-84},{-96,-76}},
          rotation=0)));
  ThermoSysPro.WaterSteam.Connectors.FluidOutletI Sortie_KB
    annotation (Placement(transformation(extent={{96,-84},{104,-76}}, rotation=
            0)));
  ThermoSysPro.WaterSteam.Connectors.FluidInletI Entree_eau_combustion
    annotation (Placement(transformation(extent={{-64,96},{-56,104}}, rotation=
            0)));
  ThermoSysPro.Combustion.Connectors.FuelInletI Entree_combustible
    annotation (Placement(transformation(extent={{56,96},{64,104}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Huminide
    annotation (Placement(transformation(extent={{-108,56},{-100,64}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal PuissanceMeca
    annotation (Placement(transformation(extent={{100,-44},{108,-36}}, rotation=
           0)));
  InstrumentationAndControl.Blocks.Sources.Constante constante(k=0.90)
    annotation (Placement(transformation(extent={{-50,10},{-40,20}}, rotation=0)));
equation
  connect(xAIR.C1, Entree_air) annotation (Line(
      points={{-84,40},{-100,40},{-100,0}},
      color={0,0,0},
      thickness=1));
  connect(Huminide, xAIR.humidity) annotation (Line(points={{-104,60},{-56,60},
          {-56,30},{-73,30}}));
  connect(tub_fumees.C2, melangeur2_fumees2_1.Ce2) annotation (Line(
      points={{26,-20},{26,-10}},
      color={0,0,0},
      thickness=1));
  connect(constante.y, separateur_Fumees.Ialpha1)
    annotation (Line(points={{-39.5,15},{-34,15},{-34,6},{-29,6}}));
  connect(Entree_KB, KettleBoiler.Cws1) annotation (Line(points={{-100,-80},{
          -40,-80},{-40,-30},{6.12323e-016,-30},{6.12323e-016,-40}}));
  connect(KettleBoiler.Cws2, Sortie_KB) annotation (Line(points={{-6.12323e-016,
          -60},{0,-60},{0,-80},{100,-80}}, color={0,0,255}));
  connect(KettleBoiler.Cfg1, separateur_Fumees.Cs2) annotation (Line(
      points={{-9,-50},{-26,-50},{-26,-10}},
      color={0,0,0},
      thickness=1));
  connect(KettleBoiler.Cfg2, tub_fumees.C1) annotation (Line(
      points={{9,-49.95},{26,-49.95},{26,-40}},
      color={0,0,0},
      thickness=1));
  connect(melangeur2_fumees2_1.Cs, TurbineAgaz.Ce) annotation (Line(
      points={{40,0},{60,0}},
      color={0,0,0},
      thickness=1));
  connect(TurbineAgaz.Cs, Sortie_fumees) annotation (Line(
      points={{80,0},{100,0}},
      color={0,0,0},
      thickness=1));
  connect(TurbineAgaz.MechPower, PuissanceMeca) annotation (Line(points={{81,-9},
          {90,-9},{90,-40},{104,-40}}));
  connect(Compresseur.Ce, xAIR.C2) annotation (Line(
      points={{-77.5,0},{-84,0},{-84,20}},
      color={0,0,0},
      thickness=1));
  connect(separateur_Fumees.Ce, Compresseur.Cs) annotation (Line(
      points={{-40,0},{-62.5,0}},
      color={0,0,0},
      thickness=1));
  connect(Compresseur.Power, TurbineAgaz.CompressorPower)
    annotation (Line(points={{-62.5,-3},{-60,-3},{-60,-20},{56,-20},{56,-4},{59,
          -4}}));
  connect(separateur_Fumees.Cs1, chambreCombustionTAC.Ca) annotation (Line(
      points={{-26,10},{-26,50},{-9,50}},
      color={0,0,0},
      thickness=1));
  connect(chambreCombustionTAC.Cfg, melangeur2_fumees2_1.Ce1) annotation (Line(
      points={{9,50},{26,50},{26,10}},
      color={0,0,0},
      thickness=1));
  connect(chambreCombustionTAC.Cfuel, Entree_combustible) annotation (Line(
        points={{0,41},{0,20},{60,20},{60,100}}, color={0,0,0}));
  connect(Entree_eau_combustion, chambreCombustionTAC.Cws)
    annotation (Line(points={{-60,100},{-60,80},{-6,80},{-6,59}}));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics),
                       Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={
        Polygon(
          points={{-100,72},{-100,-70},{-20,-20},{-20,20},{-100,72}},
          lineColor={0,0,0},
          fillColor={170,255,85},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,0},
          fillColor={255,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,20},{20,-20},{100,-70},{100,70},{20,20}},
          lineColor={0,0,0},
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-60},{20,-100}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-96,-80},{-20,-80},{-10,-68},{10,-94},{20,-80},{96,-80}},
            color={0,0,255}),
        Line(points={{-60,96},{-60,60},{-10,60},{-10,20}}, color={0,0,255}),
        Text(
          extent={{-12,-72},{12,-88}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString=
               "KB"),
        Line(points={{-20,-20},{-20,-60}}, color={0,0,255}),
        Line(points={{20,-20},{20,-60}}, color={0,0,255}),
        Line(points={{60,96},{60,60},{8,60},{8,20}}, color={0,0,127})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end GTCICOBarilla;
