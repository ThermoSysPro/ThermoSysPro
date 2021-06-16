within ThermoSysPro.WaterSteam.HeatExchangers;
model SimpleStaticCondenser "Simple static condenser"
  parameter Real Kc=10 "Friction pressure loss coefficient for the hot side";
  parameter Real Kf=10 "Friction pressure loss coefficient for the cold side";
  parameter Modelica.SIunits.Position z1c=0 "Hot inlet altitude";
  parameter Modelica.SIunits.Position z2c=0 "Hot outlet altitude";
  parameter Modelica.SIunits.Position z1f=0 "Cold inlet altitude";
  parameter Modelica.SIunits.Position z2f=0 "Cold outlet altitude";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Modelica.SIunits.Density p_rhoc=0
    "If > 0, fixed fluid density for the hot side";
  parameter Modelica.SIunits.Density p_rhof=0
    "If > 0, fixed fluid density for the cold side";
  parameter Integer modec=0
    "IF97 region of the water for the hot side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modecs=0
    "IF97 region of the water at the outlet of the hot side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modef=0
    "IF97 region of the water for the cold side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";

public
  Modelica.SIunits.Power W(start=1e6)
    "Power exchanged from the hot side to the cold side";
  Modelica.SIunits.Temperature Tec(start=500)
    "Fluid temperature at the inlet of the hot side";
  Modelica.SIunits.Temperature Tsc(start=400)
    "Fluid temperature at the outlet of the hot side";
  Modelica.SIunits.Temperature Tef(start=350)
    "Fluid temperature at the inlet of the cold side";
  Modelica.SIunits.Temperature Tsf(start=350)
    "Fluid temperature at the outlet of the cold side";
  ThermoSysPro.Units.DifferentialPressure DPfc(start=1e3)
    "Friction pressure loss in the hot side";
  ThermoSysPro.Units.DifferentialPressure DPgc(start=1e2)
    "Gravity pressure loss in the hot side";
  ThermoSysPro.Units.DifferentialPressure DPc( start=1e3)
    "Total pressure loss in the hot side";
  ThermoSysPro.Units.DifferentialPressure DPff(start=1e3)
    "Friction pressure loss in the cold side";
  ThermoSysPro.Units.DifferentialPressure DPgf(start=1e2)
    "Gravity pressure loss in the cold side";
  ThermoSysPro.Units.DifferentialPressure DPf( start=1e3)
    "Total pressure loss in the cold side";
  Modelica.SIunits.Density rhoc(start=998)
    "Density of the fluid in the hot side";
  Modelica.SIunits.Density rhof(start=998)
    "Density of the fluid in the cold side";
  Modelica.SIunits.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Modelica.SIunits.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";

public
  Connectors.FluidInlet Ec
                          annotation (Placement(transformation(extent={{-70,
            -110},{-50,-90}}, rotation=0)));
  Connectors.FluidInlet Ef
                          annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}, rotation=0)));
  Connectors.FluidOutlet Sf
                          annotation (Placement(transformation(extent={{90,-11},
            {110,9}}, rotation=0)));
  Connectors.FluidOutlet Sc
                          annotation (Placement(transformation(extent={{50,-110},
            {70,-90}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promf
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{40,80},{60,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promc
    annotation (Placement(transformation(extent={{0,-100},{20,-80}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
equation

  /* Flow reversal in the hot side */
  if continuous_flow_reversal then
    0 = noEvent(if (Qc > Qeps) then Ec.h - Ec.h_vol else if (Qc < -Qeps) then
        Sc.h - Sc.h_vol else Ec.h - 0.5*((Ec.h_vol - Sc.h_vol)*Modelica.Math.sin(pi
        *Qc/2/Qeps) + Ec.h_vol + Sc.h_vol));
  else
    0 = if (Qc > 0) then Ec.h - Ec.h_vol else Sc.h - Sc.h_vol;
  end if;

  /* Flow reversal in the cold side */
  if continuous_flow_reversal then
    0 = noEvent(if (Qf > Qeps) then Ef.h - Ef.h_vol else if (Qf < -Qeps) then
        Sf.h - Sf.h_vol else Ef.h - 0.5*((Ef.h_vol - Sf.h_vol)*Modelica.Math.sin(pi
        *Qf/2/Qeps) + Ef.h_vol + Sf.h_vol));
  else
    0 = if (Qf > 0) then Ef.h - Ef.h_vol else Sf.h - Sf.h_vol;
  end if;

  /* Flows in both sides */
  Ec.Q = Sc.Q;
  Qc = Ec.Q;

  Ef.Q = Sf.Q;
  Qf = Ef.Q;

  /* The fluid specific enthalpy at the outlet of the hot side is assumed to be at the saturation point */
  Sc.h = lsat.h;

  /* Power exchanged between the two sides */
  W = Qf*(Sf.h - Ef.h);
  W = Qc*(Ec.h - Sc.h);

  /* Pressure losses in the hot side */
  Ec.P - Sc.P = DPc;

  DPfc = Kc*ThermoSysPro.Functions.ThermoSquare(Qc, eps)/rhoc;
  DPgc = rhoc*g*(z2c - z1c);
  DPc  = DPfc + DPgc;

  /* Pressure losses in the cold side */
  Ef.P - Sf.P = DPf;

  DPff = Kf*ThermoSysPro.Functions.ThermoSquare(Qf, eps)/rhof;
  DPgf = rhof*g*(z2f - z1f);
  DPf  = DPff + DPgf;

  /* Fluid thermodynamic properties in the hot side */
  proce = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ec.P, Ec.h, modec);
  procs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sc.P, Sc.h, modecs);
  promc = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ec.P + Sc.P)/2, (Ec.h + Sc.h)/2, modec);

  Tec = proce.T;
  Tsc = procs.T;

  (lsat,vsat) = ThermoSysPro.Properties.WaterSteam.IF97.Water_sat_P(Ec.P);

  if (p_rhoc > 0) then
    rhoc = p_rhoc;
  else
    rhoc = promc.d;
  end if;

  /* Fluid thermodynamic properties in the cold side */
  profe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ef.P, Ef.h, modef);
  profs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sf.P, Sf.h, modef);
  promf = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ef.P + Sf.P)/2, (Ef.h + Sf.h)/2, modef);

  Tef = profe.T;
  Tsf = profs.T;

  if (p_rhof > 0) then
    rhof = p_rhof;
  else
    rhof = promf.d;
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid), Line(
          points={{-60,-90},{-60,38},{0,-8},{60,40},{60,-90}},
          color={0,0,255},
          thickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-60,-90},{-60,38},{0,-8},{60,40},{60,-90}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-110,21},{-90,11}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Cold inlet"),
        Text(
          extent={{-46,-93},{-26,-103}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Hot inlet"),
        Text(
          extent={{28,-93},{48,-103}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Hot outlet"),
        Text(
          extent={{88,20},{110,9}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString=
               "Cold outlet")}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"),
    DymolaStoredErrors);
end SimpleStaticCondenser;
