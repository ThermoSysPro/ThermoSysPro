within ThermoSysPro.FlueGases.TAC;
model GasTurbine "Combustion turbine for CICO and Barilla plants"

  parameter Real comp_tau_n=15 "Nominal compression nominal rate";
  parameter Real comp_eff_n=0.9 "Compressor nominal efficiency";
  parameter Real A0 = 0.1725914;
  parameter Real A1 = 1.46222;
  parameter Real A2 = -0.634857;
  parameter Real A3 = 0;
  parameter Real A4 = 0;
  parameter Real exp_tau_n=0.05 "Turbine nominal expansion rate";
  parameter Real exp_eff_n=0.9 "Turbine nominal efficiency";
  parameter Real TurbQred=0.01 "Turbine reduced mass flow rate";
////old
  //parameter Real B0 = 0.3735955;
  //parameter Real B1 = 1.42460674;
  //parameter Real B2 = -0.80865168;
  parameter Real B0 = 0.95223;
  parameter Real B1 = 0.09555;
  parameter Real B2 = -0.04778;

  parameter Real Kcham = 1 "Chamber pressure loss coefficient";
  parameter Modelica.SIunits.Power Wpth=1e5 "Combustion chamber thermal losses";

  BoundaryConditions.AirHumidity xAIR
                    annotation (Placement(transformation(
        origin={-84,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.FlueGases.Machines.Compressor Compresseur(
    A4=A4,
    A3=A3,
    A2=A2,
    A1=A1,
    A0=A0,
    tau_n=comp_tau_n,
    is_eff_n=comp_eff_n)                   annotation (Placement(transformation(
          extent={{-82,-28},{-32,28}}, rotation=0)));
  Combustion.CombustionChambers.GTCombustionChamber chambreCombustionTAC(
    Acham=1,
    eta_comb=1,
    kcham=Kcham,
    Pea(start=13.8e5),
    Wpth=Wpth,
    Qsf(start=500),
    Qfuel(start=10),
    Psf(start=13.2e5),
    Tsf(start=1495))   annotation (Placement(transformation(extent={{-25,31},{
            25,83}}, rotation=0)));
  ThermoSysPro.FlueGases.Machines.CombustionTurbine TurbineAgaz(
    Te(start=1495),
    Pe(start=13.2e5),
    A2=B2,
    A1=B1,
    A0=B0,
    tau_n=exp_tau_n,
    Qred=TurbQred,
    Ps(fixed=false, start=1.013e5),
    is_eff_n=exp_eff_n,
    Ts(start=894.518, fixed=false))
                                   annotation (Placement(transformation(extent=
            {{47,-22},{79,22}}, rotation=0)));
  Connectors.FlueGasesInletI Entree_air
    annotation (Placement(transformation(extent={{-104,-4},{-96,4}}, rotation=0)));
  Connectors.FlueGasesOutletI Sortie_fumees
    annotation (Placement(transformation(extent={{96,-4},{104,4}}, rotation=0)));
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
equation
  connect(Huminide, xAIR.humidity) annotation (Line(points={{-104,60},{-56,60},
          {-56,30},{-73,30}}));
  connect(TurbineAgaz.MechPower, PuissanceMeca) annotation (Line(points={{80.6,
          -19.8},{90,-19.8},{90,-40},{104,-40}}));
  connect(Compresseur.Power, TurbineAgaz.CompressorPower)
    annotation (Line(points={{-38.25,-8.4},{46,-8.4},{46,-8},{45.4,-8.8}}));
  connect(xAIR.C2, Compresseur.Ce) annotation (Line(
      points={{-84,20},{-84,3.55271e-015},{-75.75,3.55271e-015}},
      color={0,0,0},
      thickness=1));
  connect(TurbineAgaz.Cs, Sortie_fumees) annotation (Line(
      points={{79,0},{100,0}},
      color={0,0,0},
      thickness=1));
  connect(xAIR.C1, Entree_air) annotation (Line(
      points={{-84,40},{-100,40},{-100,0}},
      color={0,0,0},
      thickness=1));
  connect(Compresseur.Cs, chambreCombustionTAC.Ca) annotation (Line(
      points={{-38.25,3.55271e-015},{-32,3.55271e-015},{-32,57},{-22.5,57}},
      color={0,0,0},
      thickness=1));
  connect(chambreCombustionTAC.Cfg, TurbineAgaz.Ce) annotation (Line(
      points={{22.5,57},{32,57},{32,0},{47,0}},
      color={0,0,0},
      thickness=1));
  connect(Entree_eau_combustion, chambreCombustionTAC.Cws)
    annotation (Line(points={{-60,100},{-60,90},{-15,90},{-15,80.4}}));
  connect(chambreCombustionTAC.Cfuel, Entree_combustible) annotation (Line(
        points={{0,33.6},{0,20},{60,20},{60,100}}, color={0,0,0}));
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
          fillColor={170,255,213},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{20,20},{20,-20},{100,-70},{100,70},{20,20}},
          lineColor={0,0,0},
          fillColor={85,255,85},
          fillPattern=FillPattern.Solid),
        Line(points={{-60,96},{-60,60},{-10,60},{-10,20}}, color={0,0,255}),
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
end GasTurbine;
