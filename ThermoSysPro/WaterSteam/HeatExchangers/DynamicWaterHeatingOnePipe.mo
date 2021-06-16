within ThermoSysPro.WaterSteam.HeatExchangers;
model DynamicWaterHeatingOnePipe "Dynamic WaterHeating"
  //parameter Modelica.SIunits.Volume Vc=4510 "Cavity total volume";
  parameter Real Vf0=0.066
    "Fraction of initial liquid volume in the Cavity (0 < Vf0 < 1)";
  parameter Modelica.SIunits.Pressure P0c=1e5 "INitial pressure in the Cavity";
  //parameter Modelica.SIunits.Area Ac=200 "Cavity cross-sectional area";
  parameter Modelica.SIunits.Radius Rv=1.0
    "Radius of the Cavity cross-sectional area";
  parameter Modelica.SIunits.Length L1=12.5
    " Length of drowned pipes in liquid (pipes 1)";
  parameter Modelica.SIunits.Length L2=12.5 " Length of Pipe 2 (in steam)";
  parameter Modelica.SIunits.Length L3=25 " Length of Pipe 3 (in steam)";
  parameter Modelica.SIunits.Length Lc=2.5
    "support plate spacing in cooling zone(Chicanes)";
  parameter Modelica.SIunits.Diameter Dc=0.016
    "Internal diameter of the cooling pipes";
  parameter Modelica.SIunits.Thickness ec=2.e-3
    " Thickness of the cooling pipes";
  parameter Modelica.SIunits.Diameter DIc=1.390 "Internal calendre diameter";
  parameter Modelica.SIunits.Length PasL = 0.03
    "Longitudianl step or Length bottom pipes triangular step";
  parameter Modelica.SIunits.Length PasT = 0.03
    " Transverse step or pipes step";
  //parameter Modelica.SIunits.Angle Angle = 60 "Average bend angle (deg)";
  parameter Integer Ns=10 "Number of segments for one tube pass (half U pipe";
  parameter Integer ntubes1=500
    "Numbers of drowned pipes in liquid for pipes 1";
  parameter Integer ntubes2=500
    "Numbers of the pipes immersed in steam = NbTub2, for pipes 2";
  parameter Integer ntubes3=500
    "Numbers of the pipes immersed in steam, for pipe 3";
  parameter Integer ntubesV=15 "Numbers of pipes in a vertical row (tube bank)";
  parameter Modelica.SIunits.SpecificHeatCapacity cp=460
    "Specific heat capacity of the metal of the cooling pipes";
  parameter Modelica.SIunits.Density rho=7900
    "Density of the metal of the cooling pipes";
  parameter Modelica.SIunits.ThermalConductivity lambda=26
    "Wall thermal conductivity of the cooling pipes";
  //parameter Modelica.SIunits.CoefficientOfHeatTransfer hcond=25000
  //  "Heat transfer coefficient between the vapor and the cooling pipes";
  parameter Real DpfCorr= 1.00
    "Corrective terme for friction pressure loss (dpf) in node i";
  parameter Real COP0v = 1.0
    "Corrective terme for Heat exchange coefficient or Fouling coefficient steam side";
  parameter Real COP0l = 1
    "Corrective terme for Heat exchange coefficient or Fouling coefficient liquid side";

  Volumes.TwoPhaseCavity WaterHeating(
    Vf0=Vf0,
    P0=P0c,
    Ns=Ns,
    L2=L2,
    NbTub1=ntubes1,
    NbTubV=ntubesV,
    DIc=DIc,
    R=Rv,
    Dext=Dc + 2*ec,
    COPv=COP0v,
    COPl=COP0l,
    Lc=Lc,
    PasL=PasL,
    PasT=PasT,
    L1=L1,
    L3=L3,
    NbTub2=ntubes2,
    NbTub3=ntubes3)
    annotation (                        Placement(transformation(extent={{-100,
            -100},{100,100}}, rotation=0)));
  ThermoSysPro.WaterSteam.HeatExchangers.DynamicOnePhaseFlowPipe pipe_3(
    option_temperature=2,
    advection=true,
    mode=0,
    continuous_flow_reversal=true,
    D=Dc,
    Ns=Ns*2,
    dpfCorr=DpfCorr,
    inertia=true,
    L=L3,
    ntubes=ntubes3,
    Q(start=fill(300, Ns*2 + 1)))
    annotation (Placement(transformation(extent={{-35,-34},{60,0}}, rotation=0)));
  Connectors.FluidInletI C1vap "Vapor inlet"
    annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
  Connectors.FluidOutletI C2ex "Condensed water extraction outlet"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
  Connectors.FluidInletI Ce1 "Cooling water inlet"
    annotation (Placement(transformation(extent={{-110,-55},{-90,-35}},
          rotation=0)));
  Connectors.FluidOutletI Ce2 "Cooling water outlet"
    annotation (Placement(transformation(extent={{-110,34},{-90,54}}, rotation=
            0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal sortieReelle
    annotation (Placement(transformation(extent={{92,-86},{112,-66}}, rotation=
            0)));

  Connectors.FluidInletI C1 "Extra water inlet"
    annotation (Placement(transformation(extent={{-74,82},{-54,102}}, rotation=
            0)));
  Thermal.HeatTransfer.HeatExchangerWall Wall_3(
    D=Dc,
    e=ec,
    lambda=lambda,
    cpw=cp,
    rhow=rho,
    Ns=Ns*2,
    L=L3,
    ntubes=ntubes3)
    annotation (Placement(transformation(extent={{-34,-24},{60,24}}, rotation=0)));

equation
  if (cardinality(C1) == 1) then
    C1.Q = 0;
    C1.h = 1.e5;
    C1.b = true;
  end if;

  connect(C1vap, WaterHeating.Cv)
                                annotation (Line(points={{0,100},{0,73.3333},{
          -0.571429,73.3333}}));
  connect(WaterHeating.Cl, C2ex)
                               annotation (Line(points={{-0.571429,-73.3333},{
          -0.571429,-94},{-2,-94},{-2,-98},{0,-98},{0,-100}}, color={0,0,255}));
  connect(C1, WaterHeating.Ce)
    annotation (Line(points={{-64,92},{-60,92},{-60,73.3333},{-42.8571,73.3333}}));
  connect(WaterHeating.yLevel, sortieReelle)
    annotation (Line(points={{100,-30},{94,-30},{94,-76},{102,-76}}));
  connect(WaterHeating.Cth3, Wall_3.WT2)
                                      annotation (Line(points={{12.5714,12.6667},
          {12.5714,8.33335},{13,8.33335},{13,4.8}}, color={191,95,0}));
  connect(Wall_3.WT1, pipe_3.CTh) annotation (Line(points={{13,-4.8},{13,-10.4},
          {12.5,-10.4},{12.5,-11.9}}, color={191,95,0}));
  connect(pipe_3.C2, Ce2) annotation (Line(
      points={{60,-17},{78,-17},{78,44},{-100,44}},
      color={0,0,255},
      thickness=0.5));
  connect(pipe_3.C1, Ce1) annotation (Line(points={{-35,-17},{-68,-17},{-68,-45},
          {-100,-45}}, thickness=0.5));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={
        Text(
          extent={{-116,-56},{-90,-72}},
          lineColor={0,0,255},
          textString=
               "IN"),
        Text(
          extent={{-110,67},{-86,53}},
          lineColor={0,0,255},
          textString=
               "OUT"),
        Text(
          extent={{10,104},{38,89}},
          lineColor={0,0,255},
          textString=
               "Steam")}),
                       Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{-100,0},{-74,-90}},
          lineColor={0,0,255},
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,-8},{0,-14}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,14},{-74,8}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{60,14},{16,8}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{60,-90},{-100,-90}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{60,90},{-100,90}},
          color={0,0,255},
          thickness=0.5),
        Line(
          points={{-100,0},{76,0}},
          color={0,0,255},
          thickness=0.5),
        Rectangle(
          extent={{-74,-52},{60,-90}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,90},{-74,0}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,-8},{-74,-14}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,-30},{-74,-36}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,-54},{-74,-60}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,36},{-74,30}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{16,60},{-74,54}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,90},{70,80},{84,60},{94,40},{100,20},{102,0},{100,-20},{
              94,-40},{84,-60},{70,-80},{60,-90},{60,90}},
          lineColor={0,0,255},
          lineThickness=0.5,
          fillColor={85,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{66,14},{60,-14}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{70,36},{16,30}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{78,60},{16,54}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{74,-30},{16,-36}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{60,-52},{88,-52},{74,-74},{64,-86},{59,-90},{60,-52}},
          lineColor={255,170,170},
          lineThickness=0.5,
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-76},{72,-76}},
          color={255,255,255},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Rectangle(
          extent={{74,36},{68,-36}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{82,60},{76,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{76,-54},{16,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-74,-68},{78,-68}},
          color={255,255,255},
          pattern=LinePattern.Dash,
          thickness=0.5),
        Line(
          points={{-74,-58},{84,-58}},
          color={255,255,255},
          pattern=LinePattern.Dash,
          thickness=0.5)}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2014</h4></p>
<p><b>ThermoSysPro Version 3.1</h4>
</html>"));
end DynamicWaterHeatingOnePipe;
