within ThermoSysPro.Examples.Book.SimpleExamples.HeatExchanger;
model TestSimpleDynamicCondenser

parameter Real L1 = 425 "Longueur de la première chaine de capteurs";
parameter Integer Ns1 = 80
    "Nombre de mailles de la première chaine de capteurs";

parameter Real L2 = 75 "Longueur de la deuxième chaine de capteurs";
parameter Integer Ns2 = 1 "Nombre de mailles de la deuxième chaine de capteurs";

  ThermoSysPro.WaterSteam.BoundaryConditions.SinkP puitsPCaloporteur(
                    mode=0, P0=1e5,
    option_temperature=2) annotation (Placement(transformation(extent={{48,30},
            {88,70}}, rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    PerteChargeCondPompe(                                                          K=1e-6, Q(start=
          0.598447))
    annotation (Placement(transformation(
        origin={-90,-38},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SourceP SourceRechauffeurEau(
    option_temperature=2,
    h0=2401e3,
    P0=15050)                   annotation (Placement(transformation(extent={{-207,
            148},{-183,170}},      rotation=0)));
  ThermoSysPro.WaterSteam.BoundaryConditions.SinkQ PuitsRechauffeurEau(
                  h0=191812, Q0=192)
                          annotation (Placement(transformation(extent={{-184,
            -52},{-208,-24}}, rotation=0)));
  WaterSteam.BoundaryConditions.SourceQ sourcePCaloporteur(Q0=29804.5, h0=113e3)
                                annotation (Placement(transformation(extent={{-212,30},
            {-172,68}},          rotation=0)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    PerteChargeCondPompe1(                                                         K=1e-6)
    annotation (Placement(transformation(
        origin={36,50},
        extent={{6,-10},{-6,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    PerteChargeCondPompe2(                                                         K=1e-6)
    annotation (Placement(transformation(
        origin={-154,49},
        extent={{6,-10},{-6,10}},
        rotation=180)));
  ThermoSysPro.WaterSteam.PressureLosses.SingularPressureLoss
    PerteChargeCondPompe3(K(fixed=false) = 1e-3, Q(start=192, fixed=true))
    annotation (Placement(transformation(
        origin={-120,159},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  WaterSteam.HeatExchangers.SimpleDynamicCondenser Condenseur(    D=0.018,
    V=1000,
    A=100,
    lambda=0.01,
    ntubes=28700,
    continuous_flow_reversal=true,
    yNiveau(signal(fixed=false, start=1.5)),
    Vf0=0.15,
    steady_state=false,
    P(fixed=false, start=10000))
                     annotation (Placement(transformation(extent={{-118,6},{1,
            116}}, rotation=0)));
equation

  connect(sourcePCaloporteur.C, PerteChargeCondPompe2.C1) annotation (Line(
        points={{-172,49},{-160,49}}, color={0,0,255}));
  connect(PerteChargeCondPompe1.C2, puitsPCaloporteur.C) annotation (Line(
        points={{42,50},{48,50}}, color={0,0,255}));
  connect(SourceRechauffeurEau.C, PerteChargeCondPompe3.C1) annotation (Line(
        points={{-183,159},{-130,159}}, color={0,0,255}));
  connect(PuitsRechauffeurEau.C, PerteChargeCondPompe.C2)
    annotation (Line(points={{-184,-38},{-100,-38}}));
  connect(PerteChargeCondPompe2.C2, Condenseur.Cee) annotation (Line(points={{
          -148,49},{-133,49},{-133,48.9},{-118,48.9}}, color={0,0,255}));
  connect(PerteChargeCondPompe.C1, Condenseur.Cl)
    annotation (Line(points={{-80,-38},{-57.31,-38},{-57.31,6}}));
  connect(PerteChargeCondPompe3.C2, Condenseur.Cv) annotation (Line(points={{
          -110,159},{-58.5,159},{-58.5,116}}, color={0,0,255}));
  connect(PerteChargeCondPompe1.C1, Condenseur.Cse)
    annotation (Line(points={{30,50},{15.5,50},{15.5,50},{1,50}}));
  annotation (
    Window(
      x=0.43,
      y=0,
      width=0.57,
      height=0.63),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-250,-60},{130,180}},
        grid={2,2},
        initialScale=0.1), graphics),
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
<p>This model is documented in Sect. 9.5.3.5 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>.</h4>
<p>The results reported in the ThermoSysPro book were computed using Dymola.</h4>
</html>"));
end TestSimpleDynamicCondenser;
