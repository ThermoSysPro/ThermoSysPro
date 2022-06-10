within ThermoSysPro.Fluid.Examples.SimpleExamples;
model TestSimpleDynamicCondenser1
  ThermoSysPro.Fluid.Machines.StaticCentrifugalPump staticCentrifugalPump(Pm(displayUnit = "Pa", start=
          355000.00000015664),                                                                         Q(fixed = false), hn(fixed = false, start=
          71.08245675235786),                                                                                                               p_rho(displayUnit = "kg/m3"), rho(displayUnit = "kg/m3"),
    a1(start=-88.67, fixed=false),
    C2(h(start=195297.69906611618), h_vol_1(start=195297.69906611618)),
    Qv(start=0.009081311621074862),
    h(start=193554.9971298399),
    C1(P(start=10000.0)))                                                                                                                                                                             annotation (
    Placement(visible = true, transformation(origin={-10,-60},    extent={{10,-10},
            {-10,10}},                                                                             rotation = 0)));
  ThermoSysPro.Fluid.Machines.StodolaTurbine stodolaTurbine(Pe(displayUnit = "Pa", fixed = true, start = 700000), Ps(displayUnit = "Pa", fixed = false), W_fric = 0, eta_is(fixed = false), eta_is_wet(fixed = false), rhos(displayUnit = "kg/m3", fixed = false),
    xm(fixed=false, start=0.9856238368898451),
    proe(x(start=1, fixed=true)),
    Ce(h_vol_2(start=3128840.013040668), h(start=3128840.0130323363)),
    pros(d(start=0.07018147245152216)))                                                                                                                                                                                                   annotation (
    Placement(visible = true, transformation(origin={-10,60},    extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermoSysPro.Fluid.HeatExchangers.SimpleDynamicCondenser Condenseur(A = 100, D = 0.018,
    dynamic_energy_balance=true,
    P(fixed=false, start=10000),
    P0(displayUnit="Pa") = 1000,                                                                                                                                V = 1000, continuous_flow_reversal = true, lambda = 0.01, ntubes = 28700, rhol(displayUnit = "kg/m3"), rhom(displayUnit = "kg/m3"), rhov(displayUnit = "kg/m3"),                       yNiveau(signal(fixed = false, start = 1.5)),
    steady_state=false,
    proe(d(start=0.7468807684211932)))                                                                                                                                                                                          annotation (
    Placement(visible = true, transformation(origin={40.5,-1},    extent = {{-20.5, -16}, {20.5, 16}}, rotation = 0)));
  ThermoSysPro.Fluid.BoundaryConditions.SinkP puitsPCaloporteur(P0 = 1e5, T0 = 373.05, option_temperature = true) annotation (
    Placement(visible = true, transformation(origin={85,-1},    extent = {{-11, -12}, {11, 12}}, rotation = 0)));
  ThermoSysPro.Fluid.BoundaryConditions.SourceQ sourcePCaloporteur(Q0 = 5, h0 = 113e3) annotation (
    Placement(visible = true, transformation(origin={-24,-1},    extent = {{-10, -9}, {10, 9}}, rotation = 0)));
  Volumes.VolumeATh volumeA(
    P(start=70e5),
    h(start=2.e6),
    dynamic_energy_balance=false)
    annotation (Placement(transformation(extent={{-70,10},{-50,-10}})));
  Thermal.BoundaryConditions.HeatSource heatSource(W0(start={2e6}, each fixed=false),
      option_temperature=2) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-88,12})));
equation
  connect(Condenseur.Cv,stodolaTurbine. Cs) annotation (
    Line(points={{40.5,15},{40.5,60},{0.1,60}},    color = {0, 0, 255}));
  connect(Condenseur.Cse,puitsPCaloporteur. C) annotation (
    Line(points={{61,-4.2},{62,-4.2},{62,-1},{74,-1}},
                                        color = {0, 0, 255}));
  connect(sourcePCaloporteur.C,Condenseur. Cee) annotation (
    Line(points={{-14,-1},{-9,-1},{-9,-4.52},{20,-4.52}},   color = {0, 0, 255}));
  connect(Condenseur.Cl, staticCentrifugalPump.C1) annotation (Line(points={{40.91,
          -17},{40,-17},{40,-60},{0,-60}},   color={28,108,200}));
  connect(staticCentrifugalPump.C2, volumeA.Ce2)
    annotation (Line(points={{-20,-60},{-60,-60},{-60,-10}}, color={28,108,200}));
  connect(volumeA.Cs2, stodolaTurbine.Ce)
    annotation (Line(points={{-60,10},{-60,60},{-20.1,60}},  color={28,108,200}));
  connect(heatSource.C[1], volumeA.Cth) annotation (Line(points={{-78.2,12},{-64,
          12},{-64,0},{-60,0}}, color={0,0,0}));
  annotation (                         Diagram(graphics={
        Text(
          extent={{-94,34},{-64,24}},
          lineColor={28,108,200},
          textString="W: free"),
        Text(
          extent={{-26,-38},{8,-48}},
          lineColor={28,108,200},
          textString="a1: free"),
        Text(
          extent={{-28,94},{8,84}},
          lineColor={28,108,200},
          textString="Pe: fixed"),
        Text(
          extent={{-28,84},{10,72}},
          lineColor={28,108,200},
          textString="proe.x: fixed")}), Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
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
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}),
    experiment(StopTime=1000, __Dymola_Algorithm="Dassl"));
end TestSimpleDynamicCondenser1;
