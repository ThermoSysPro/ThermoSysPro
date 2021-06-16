within ThermoSysPro.WaterSteam.HeatExchangers;
model StaticWaterWaterExchangerDTorWorEff
  "Static water/water heat exchanger with fixed delta temperature, delta power or efficiency"
  parameter Integer exchanger_type=1
    "Exchanger type - 1: Delta temperature is fixed - 2: delta power is fixed - 3: efficiency is fixed";
  parameter ThermoSysPro.Units.DifferentialTemperature DTfroid=0
    "Temperature difference between the cold inlet and the cold outlet (active if exchanger_type=1)";
  parameter Modelica.SIunits.Power DW=0
    "Power increase on the cold side (active if exchanger_type=2)";
  parameter Real EffEch=0.9
    "Thermal exchange efficiency (=W/Wmax) (active if exchanger_type=3)";
  parameter Real Kc=10 "Pressure loss coefficient for the hot fluid";
  parameter Real Kf=10 "Pressure loss coefficient for the cold fluid";
  parameter Modelica.SIunits.Position z1c=0 "Hot inlet altitude";
  parameter Modelica.SIunits.Position z2c=0 "Hot outlet altitude";
  parameter Modelica.SIunits.Position z1f=0 "Cold inlet altitude";
  parameter Modelica.SIunits.Position z2f=0 "Cold outlet altitude";
  parameter Boolean continuous_flow_reversal=false
    "true: continuous flow reversal - false: discontinuous flow reversal";
  parameter Modelica.SIunits.Density p_rhoc=0
    "If > 0, fixed fluid density for the hot fluid";
  parameter Modelica.SIunits.Density p_rhof=0
    "If > 0, fixed fluid density for the cold fluid";
  parameter Integer modec=0
    "IF97 region of the water for the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modecs=0
    "IF97 region of the water at the outlet of the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer modef=0
    "IF97 region of the water for the cold fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

protected
  constant Modelica.SIunits.Acceleration g=Modelica.Constants.g_n
    "Gravity constant";
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";
  parameter Modelica.SIunits.MassFlowRate Qeps=1.e-3
    "Small mass flow rate for continuous flow reversal";

public
  Modelica.SIunits.Power W(start=1e6)
    "Power exchanged from the hot fluid to the cold fluid";
  Modelica.SIunits.Temperature Tec(start=500)
    "Fluid temperature at the inlet of the hot side";
  Modelica.SIunits.Temperature Tsc(start=400)
    "Fluid temperature at the outlet of the hot side";
  Modelica.SIunits.Temperature Tef(start=350)
    "Fluid temperature at the inlet of the cold side";
  Modelica.SIunits.Temperature Tsf(start=450)
    "Fluid temperature at the outlet of the cold side";
  Modelica.SIunits.Temperature Tsatsf
    "Saturation temperature at the outlet of the cold side";
  ThermoSysPro.Units.DifferentialPressure DPfc(start=1e3)
    "Friction pressure loss for the hot fluid";
  ThermoSysPro.Units.DifferentialPressure DPgc(start=1e2)
    "Gravity pressure loss for the hot fluid";
  ThermoSysPro.Units.DifferentialPressure DPc( start=1e3)
    "Total pressure loss for the hot fluid";
  ThermoSysPro.Units.DifferentialPressure DPff(start=1e3)
    "Friction pressure loss for the cold fluid";
  ThermoSysPro.Units.DifferentialPressure DPgf(start=1e2)
    "Gravity pressure loss for the cold fluid";
  ThermoSysPro.Units.DifferentialPressure DPf( start=1e3)
    "Total pressure loss for the cold fluid";
  Modelica.SIunits.Density rhoc(start=998) "Hot fluid density";
  Modelica.SIunits.Density rhof(start=998) "Cold fluid density";
  Modelica.SIunits.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Modelica.SIunits.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";

public
  Connectors.FluidInlet Ec "Hot inlet"
                          annotation (Placement(transformation(extent={{-50,31},
            {-30,51}}, rotation=0)));
  Connectors.FluidInlet Ef "Cold inlet"
                          annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}}, rotation=0)));
  Connectors.FluidOutlet Sf "Cold outlet"
                          annotation (Placement(transformation(extent={{90,-9},
            {110,11}}, rotation=0)));
  Connectors.FluidOutlet Sc "Hot outlet"
                          annotation (Placement(transformation(extent={{30,31},
            {50,51}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}},
          rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs
    annotation (Placement(transformation(extent={{80,-100},{100,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_pT profPT
    annotation (Placement(transformation(extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promc
    annotation (Placement(transformation(extent={{-10,-100},{10,-80}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph promf
    annotation (Placement(transformation(extent={{40,80},{60,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
equation

  /* Flow reversal for the hot fluid */
  if continuous_flow_reversal then
    0 = noEvent(if (Qc > Qeps) then Ec.h - Ec.h_vol else if (Qc < -Qeps) then
        Sc.h - Sc.h_vol else Ec.h - 0.5*((Ec.h_vol - Sc.h_vol)*Modelica.Math.sin(pi
        *Qc/2/Qeps) + Ec.h_vol + Sc.h_vol));
  else
    0 = if (Qc > 0) then Ec.h - Ec.h_vol else Sc.h - Sc.h_vol;
  end if;

  /* Flow reversal for the cold fluid */
  if continuous_flow_reversal then
    0 = noEvent(if (Qf > Qeps) then Ef.h - Ef.h_vol else if (Qf < -Qeps) then
        Sf.h - Sf.h_vol else Ef.h - 0.5*((Ef.h_vol - Sf.h_vol)*Modelica.Math.sin(pi
        *Qf/2/Qeps) + Ef.h_vol + Sf.h_vol));
  else
    0 = if (Qf > 0) then Ef.h - Ef.h_vol else Sf.h - Sf.h_vol;
  end if;

  /* Mass flow rates */
  Ec.Q = Sc.Q;
  Qc = Ec.Q;

  Ef.Q = Sf.Q;
  Qf = Ef.Q;

  /* Power exchanged between the hot and cold fluids */
  if (exchanger_type == 1) then
    W = Qf*(Sf.h - Ef.h);
    W = Qc*(Ec.h - Sc.h);

    Sf.h = profPT.h;
    Tsf = Tef + DTfroid;
  elseif (exchanger_type == 2) then
    W = Qf*(Sf.h - Ef.h);

    DW = Qf*(Sf.h - Ef.h);
    DW = Qc*(Ec.h - Sc.h);

    Tsf = profs.T;
  elseif (exchanger_type == 3) then
    if ((proce.x > 0) and (proce.x < 1) and ((profe.x < 1e-5) or (profe.x > 0.999999))) then
       W = Qf*profe.cp*EffEch*(Tec - Tef);
    elseif ((profe.x > 0) and (profe.x < 1)) then
       W = Qc*proce.cp*EffEch*(Tec - Tef);
    else
       W = noEvent(min(Qc*proce.cp, Qf*profe.cp)*EffEch*(Tec - Tef));
    end if;

    Sf.h = Ef.h + W/Qf;
    Sc.h = Ec.h - W/Qc;

    Tsf = profs.T;
  else
    assert(false, "StaticWaterWaterExchangerDTorWorEff: invalid option");
  end if;

  /* Pressure losses for the hot fluid */
  Ec.P - Sc.P = DPc;

  DPfc = Kc*ThermoSysPro.Functions.ThermoSquare(Qc, eps)/rhoc;
  DPgc = rhoc*g*(z2c - z1c);
  DPc  = DPfc + DPgc;

  /* Pressure losses for the cold fluid */
  Ef.P - Sf.P = DPf;

  DPff = Kf*ThermoSysPro.Functions.ThermoSquare(Qf, eps)/rhof;
  DPgf = rhof*g*(z2f - z1f);
  DPf  = DPff + DPgf;

  /* Fluid thermodynamic properties for the hot fluid */
  proce = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ec.P, Ec.h, modec);
  procs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sc.P, Sc.h, modecs);
  promc = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ec.P + Sc.P)/2, (Ec.h + Sc.h)/2, modec);

  Tec = proce.T;
  Tsc = procs.T;

  if (p_rhoc > 0) then
    rhoc = p_rhoc;
  else
    rhoc = promc.d;
  end if;

  /* Fluid thermodynamic properties for the cold fluid */
  profe = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Ef.P, Ef.h, modef);
  profs = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph(Sf.P, Sf.h, modef);
  promf = ThermoSysPro.Properties.WaterSteam.IF97.Water_Ph((Ef.P+Sf.P)/2, (Ef.h + Sf.h)/2, modef);

  Tef = profe.T;

  if (p_rhof > 0) then
    rhof = p_rhof;
  else
    rhof = promf.d;
  end if;

  /* Fluid thermodynamic properties at the saturation point at the outlet of the cold side */
  Tsatsf = ThermoSysPro.Properties.WaterSteam.BaseIF97.Basic.tsat(Sf.P);
  profPT = ThermoSysPro.Properties.WaterSteam.IF97.Water_PT(Sf.P, Tsf, 0);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{38,-31},{102,31}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-102,-31},{-38,31}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,31},{70,-31}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-72,31},{72,31},{72,31}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-72,-31},{72,-31},{72,-31}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{68,-17},{100,-1}},
          color={0,255,255},
          thickness=1),
        Rectangle(
          extent={{-64,2},{68,2}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-96,5},{-64,21}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{-64,-17},{-64,-7}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{-64,-8},{-64,2}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{68,11},{68,21}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{68,2},{68,12}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{0,31},{0,-23}},
          color={0,0,0},
          thickness=0.5),
        Rectangle(
          extent={{-64,21},{68,21}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,-17},{68,-17}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,31},{0,-23}},
          color={0,0,0},
          thickness=0.5)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(
          extent={{-108,28},{-92,22}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString=
               "E_Froid"),
        Text(
          extent={{96,28},{112,22}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString=
               "S_Froid"),
        Ellipse(
          extent={{38,-31},{102,31}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-102,-31},{-38,31}},
          lineColor={0,0,0},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-70,31},{70,-31}},
          lineColor={255,255,0},
          lineThickness=0.5,
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-72,31},{72,31},{72,31}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{-72,-31},{72,-31},{72,-31}},
          color={0,0,0},
          thickness=0.5),
        Line(
          points={{68,-17},{100,-1}},
          color={0,255,255},
          thickness=1),
        Rectangle(
          extent={{-64,-15},{68,-17}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,2},{68,0}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,21},{68,19}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,-7},{68,-9}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-96,5},{-64,21}},
          color={0,255,255},
          thickness=1),
        Rectangle(
          extent={{-64,11},{68,9}},
          lineColor={0,255,255},
          lineThickness=1,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-64,-17},{-64,-7}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{68,-9},{68,1}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{68,10},{68,20}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{-64,1},{-64,11}},
          color={0,255,255},
          thickness=1),
        Line(
          points={{0,31},{0,-23}},
          color={0,0,0},
          thickness=0.5)}),
    Window(
      x=0.05,
      y=0.01,
      width=0.93,
      height=0.87),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2012</b> </p>
<p><b>ThermoSysPro Version 3.0</h4>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"),
    DymolaStoredErrors);
end StaticWaterWaterExchangerDTorWorEff;
