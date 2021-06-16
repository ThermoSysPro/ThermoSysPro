within ThermoSysPro.WaterSteam.HeatExchangers;
model DynamicCondenser "Dynamic Cavity"
  //parameter Modelica.SIunits.Volume Vc=4510 "Cavity total volume";
  parameter Real Vf0=0.066
    "Fraction of initial liquid volume in the Cavity (0 < Vf0 < 1)";
  parameter Modelica.SIunits.Pressure P0c=1e4 "INitial pressure in the Cavity";
  parameter Modelica.SIunits.Radius Rv=1.0
    "Radius of the Cavity cross-sectional area";
  parameter Modelica.SIunits.Length Lv=15 "Cavity length";
  parameter Modelica.SIunits.Length L2=14 "Pipes length";
  parameter Modelica.SIunits.Length Lc=2.5
    "support plate spacing in cooling zone(Chicanes)";
  parameter Modelica.SIunits.Diameter Dc=0.016
    "Internal diameter of the cooling pipes";
  parameter Modelica.SIunits.Thickness ec=2.e-3
    "Thickness of the cooling pipes";
  parameter Integer Ns=10 "Number of segments for pipes";
  parameter Integer ntubest=10000 "Number of total pipes in Cavity ";
  parameter Integer ntubesV=200 "Numbers of pipes in a vertical plan in Cavity";
  parameter Modelica.SIunits.SpecificHeatCapacity cp=460
    "Specific heat capacity of the metal of the cooling pipes";
  parameter Modelica.SIunits.Density rho=7900
    "Density of the metal of the cooling pipes";
  parameter Modelica.SIunits.ThermalConductivity lambda=26
    "Wall thermal conductivity of the cooling pipes";
  //parameter Modelica.SIunits.CoefficientOfHeatTransfer hcond=25000
  //  "Heat transfer coefficient between the vapor and the cooling pipes";

  Volumes.TwoPhaseCavityOnePipe DynamicCondenser(
    Vf0=Vf0,
    P0=P0c,
    Ns=Ns,
    L2=L2,
    NbTubT=ntubest,
    Lc=Lc,
    NbTubV=ntubesV,
    Dext=Dc + 2*ec,
    R=Rv,
    L=Lv,
    Vertical=true)
    annotation (                        Placement(transformation(extent={{-100,
            -100},{100,100}}, rotation=0)));
  DynamicOnePhaseFlowPipe pipe_3(
    option_temperature=2,
    advection=true,
    mode=0,
    continuous_flow_reversal=true,
    D=Dc,
    L=L2,
    ntubes=ntubest,
    Ns=Ns)
    annotation (Placement(transformation(extent={{-58,-20},{54,18}}, rotation=0)));
  Connectors.FluidInletI C1vap "Vapor inlet"
    annotation (Placement(transformation(extent={{-10,90},{10,110}}, rotation=0)));
  Connectors.FluidOutletI C2ex "Condensed water extraction outlet"
    annotation (Placement(transformation(extent={{-10,-110},{10,-90}}, rotation=
           0)));
  Connectors.FluidInletI Ce1 "Cooling water inlet"
    annotation (Placement(transformation(extent={{-110,-11},{-90,9}}, rotation=
            0)));
  Connectors.FluidOutletI Ce2 "Cooling water outlet"
    annotation (Placement(transformation(extent={{89,-11},{109,9}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal sortieReelle
    annotation (Placement(transformation(extent={{98,-62},{118,-42}}, rotation=
            0)));

  Connectors.FluidInletI C1 "Extra water inlet"
    annotation (Placement(transformation(extent={{-107,71},{-87,91}}, rotation=
            0)));
  Thermal.HeatTransfer.HeatExchangerWall Wall_3(
    D=Dc,
    e=ec,
    lambda=lambda,
    cpw=cp,
    rhow=rho,
    L=L2,
    Ns=Ns,
    ntubes=ntubest)
    annotation (Placement(transformation(extent={{-58,-4},{54,40}}, rotation=0)));
  Connectors.FluidInletI C2vap "Vapor inlet"
    annotation (Placement(transformation(extent={{-63,90},{-43,110}}, rotation=
            0)));
equation

  if (cardinality(C1) == 1) then
    C1.Q = 0;
    C1.h = 1.e5;
    C1.b = true;
  end if;

  if (cardinality(C2vap) == 1) then
    C2vap.Q = 0;
    C2vap.h = 1.e5;
    C2vap.b = true;
  end if;

  connect(DynamicCondenser.Cl, C2ex)
                               annotation (Line(points={{7.10543e-015,-73.3333},
          {7.10543e-015,-98},{0,-98},{0,-100}}, color={0,0,255}));
  connect(C1, DynamicCondenser.Ce)
    annotation (Line(points={{-97,81},{-80,81},{-80,54},{-78,54},{-78,52.6667},
          {-76.5714,52.6667}}));
  connect(DynamicCondenser.yLevel, sortieReelle)
    annotation (Line(points={{98.8571,-31.3333},{94,-31.3333},{94,-52},{108,-52}}));
  connect(DynamicCondenser.Cth3, Wall_3.WT2)
                                      annotation (Line(points={{-0.571429,
          37.3333},{-2,32},{-2,22.4}}, color={191,95,0}));
  connect(Wall_3.WT1, pipe_3.CTh) annotation (Line(points={{-2,13.6},{-2,11.375},
          {-2,9.15},{-2,4.7}},                      color={191,95,0}));
  connect(DynamicCondenser.CvBP, C1vap)
    annotation (Line(points={{-0.571429,73.3333},{-0.571429,92},{0,92},{0,100}}));
  connect(C2vap, DynamicCondenser.CvGCT)
    annotation (Line(points={{-53,100},{-42.8571,100},{-42.8571,73.3333}}));
  connect(pipe_3.C2, Ce2) annotation (Line(
      points={{54,-1},{99,-1}},
      color={0,0,255},
      thickness=0.5));
  connect(pipe_3.C1, Ce1)
    annotation (Line(points={{-58,-1},{-100,-1}}, thickness=0.5));
  annotation (Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={Text(
          extent={{6,114},{32,98}},
          lineColor={0,0,255},
          textString=
               "BP")}),Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        initialScale=0.1), graphics={
        Rectangle(
          extent={{100,58},{80,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,58},{-80,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,24},{-80,18}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-20},{-80,-26}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-42},{-80,-48}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,24},{20,18}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-42},{20,-48}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-20},{20,-26}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-20},{-30,-26}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-42},{-30,-48}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,24},{-30,18}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,100},{-20,98},{-40,94},{-60,88},{-80,78},{-92,66},{-96,62},
              {-96,62},{-100,58},{100,58},{96,62},{92,66},{86,72},{80,78},{60,
              88},{40,94},{20,98},{0,100}},
          lineColor={0,0,255},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-100},{-20,-98},{-40,-96},{-60,-90},{-80,-80},{-92,-68},{
              -96,-64},{-100,-60},{-100,-60},{98,-60},{100,-60},{96,-64},{92,
              -68},{80,-80},{60,-90},{40,-96},{20,-98},{0,-100}},
          lineColor={0,0,255},
          fillColor={53,117,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,-60},{80,-80},{80,-60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-60},{-80,-60},{-80,-80},{-100,-60}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,58},{-80,58},{-80,78},{-100,58}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,58},{80,58},{80,78},{100,58}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,-64},{-80,-70}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,-64},{20,-70}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,-64},{-30,-70}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,2},{-80,-4}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,2},{20,-4}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,2},{-30,-4}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,46},{-80,40}},
          lineColor={0,0,255},
          fillColor={170,213,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{80,46},{20,40}},
          lineColor={0,0,255},
          fillColor={255,170,170},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{30,46},{-30,40}},
          lineColor={0,0,255},
          fillColor={170,170,255},
          fillPattern=FillPattern.Solid),
        Line(points={{90,8},{80,20}}, color={255,0,0}),
        Line(points={{90,-10},{80,-22}}, color={255,0,0}),
        Line(points={{90,-1},{78,-1}}, color={255,0,0}),
        Line(points={{-90,9},{-80,20}}, color={0,0,255}),
        Line(points={{-90,-10},{-80,-24}}, color={0,0,255}),
        Line(points={{-90,-1},{-76,-1}}, color={0,0,255})}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</h4>
<p>This component model is documented in Sect. 9.5.4 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </h4>
</html>"));
end DynamicCondenser;
