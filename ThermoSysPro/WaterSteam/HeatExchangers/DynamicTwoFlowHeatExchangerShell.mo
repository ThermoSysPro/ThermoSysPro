within ThermoSysPro.WaterSteam.HeatExchangers;
model DynamicTwoFlowHeatExchangerShell
  "Dynamic exchanger water/steam - water/steam"
  import ThermoSysPro;

  parameter Modelica.SIunits.Length L=1 "Exchanger length";
  parameter Modelica.SIunits.Position z1=0 "Exchanger inlet altitude";
  parameter Modelica.SIunits.Position z2=0 "Exchanger outlet altitude";
  parameter Integer Ns=1 "Numver of segments";
  parameter Modelica.SIunits.Diameter Dint=0.1 "Pipe internal diameter";
  parameter Modelica.SIunits.Diameter Dext=0.11 "Pipe external diameter";
  //parameter Modelica.SIunits.Diameter Ds = 0.39 "shell internal diameter";
  //parameter Modelica.SIunits.Diameter De = 0.019 "tube external diameter";
  parameter Integer Ntubes=1 "Number of pipes in parallel";

  ThermoSysPro.WaterSteam.HeatExchangers.DynamicOnePhaseFlowShell
    DynamicOnePhaseFlowShell(
    Ns=Ns,
    L=L,
    ntubes=Ntubes,
    De=Dext) annotation (Placement(transformation(extent={{-10,30},{10,10}},
          rotation=0)));
  ThermoSysPro.Thermal.HeatTransfer.HeatExchangerWall ExchangerWall(
    L=L,
    D=Dint,
    Ns=Ns,
    ntubes=Ntubes)                       annotation (Placement(transformation(
          extent={{-10,-10},{10,10}}, rotation=0)));
  DynamicOnePhaseFlowPipe OnePhaseFlowPipe(
    L=L,
    D=Dint,
    ntubes=Ntubes,
    Ns=Ns,
    z1=z1,
    z2=z2)
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}}, rotation=
            0)));
  Connectors.FluidInletI Cfg1
    annotation (Placement(transformation(extent={{-10,40},{10,60}}, rotation=0)));
  Connectors.FluidOutletI Cfg2
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}}, rotation=
            0)));
  Connectors.FluidInletI Cws1
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=
           0)));
  Connectors.FluidOutletI Cws2
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
equation
  connect(Cws2,OnePhaseFlowPipe. C2)
                                   annotation (Line(
      points={{100,0},{40,0},{40,-20},{10,-20}},
      color={255,0,0},
      thickness=0.5));
  connect(Cws1,OnePhaseFlowPipe. C1)
    annotation (Line(points={{-100,0},{-20,0},{-20,-20},{-10,-20}}, thickness=
          0.5));
  connect(ExchangerWall.WT1,OnePhaseFlowPipe. CTh)
    annotation (Line(points={{0,-2},{0,-17}}, color={191,95,0}));
  connect(DynamicOnePhaseFlowShell.CTh, ExchangerWall.WT2)
    annotation (Line(points={{0,17},{0,2}}, color={191,95,0}));
  connect(DynamicOnePhaseFlowShell.C2, Cfg2)
                                            annotation (Line(
      points={{10,20},{32,20},{32,-50},{0,-50}},
      color={0,0,0},
      thickness=1));
  connect(DynamicOnePhaseFlowShell.C1, Cfg1)
                                            annotation (Line(
      points={{-10,20},{-26,20},{-26,50},{0,50}},
      color={0,0,0},
      thickness=1));
  annotation (Diagram(graphics),
                       Icon(graphics={
        Rectangle(
          extent={{-100,50},{100,-50}},
          lineColor={0,0,255},
          fillColor={85,85,255},
          fillPattern=FillPattern.Backward),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,127,0}),
        Rectangle(
          extent={{-100,30},{100,-30}},
          lineColor={0,0,0},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,20},{100,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={85,170,255}),
        Line(points={{-60,50},{-60,-50}}),
        Line(points={{-20,50},{-20,-50}}),
        Line(points={{20,50},{20,-50}}),
        Line(points={{60,50},{60,-50}}),
        Line(
          points={{-60,-30},{-60,-50}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{-20,50},{-20,30}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{20,-30},{20,-50}},
          color={255,255,255},
          thickness=1),
        Line(
          points={{60,50},{60,30}},
          color={255,255,255},
          thickness=1)}),
    Documentation(revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Guillaume Larrignon</li>
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
end DynamicTwoFlowHeatExchangerShell;
