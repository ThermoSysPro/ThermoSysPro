within ThermoSysPro.Fluid.HeatExchangers;
model SimpleStaticCondenser "Simple static condenser"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real Kc=10 "Friction pressure loss coefficient for the hot side";
  parameter Real Kf=10 "Friction pressure loss coefficient for the cold side";
  parameter Units.SI.Position z1c=0 "Hot inlet altitude";
  parameter Units.SI.Position z2c=0 "Hot outlet altitude";
  parameter Units.SI.Position z1f=0 "Cold inlet altitude";
  parameter Units.SI.Position z2f=0 "Cold outlet altitude";
  parameter Units.SI.Density p_rhoc=0
    "If > 0, fixed fluid density for the hot side";
  parameter Units.SI.Density p_rhof=0
    "If > 0, fixed fluid density for the cold side";
  parameter Units.SI.MassFlowRate gamma_diff_c=1e-4
    "Diffusion conductance for the hot fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.MassFlowRate gamma_diff_f=1e-4
    "Diffusion conductance for the cold fluid (active if diffusion=true in neighbouring volumes)";
  parameter IF97Region region_c=IF97Region.All_regions "IF97 region for the hot fluid (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_cs=IF97Region.All_regions "IF97 region of the water at the outlet of the hot side (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_f=IF97Region.All_regions "IF97 region for the cold fluid (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Integer mode_c=Integer(region_c) - 1 "IF97 region for the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_cs=Integer(region_cs) - 1 "IF97 region of the water at the outlet of the hot side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_f=Integer(region_f) - 1 "IF97 region for the cold fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Units.SI.Power W(start=1e6)
    "Power exchanged from the hot side to the cold side";
  Units.SI.Temperature Tec(start=500)
    "Fluid temperature at the inlet of the hot side";
  Units.SI.Temperature Tsc(start=400)
    "Fluid temperature at the outlet of the hot side";
  Units.SI.Temperature Tef(start=350)
    "Fluid temperature at the inlet of the cold side";
  Units.SI.Temperature Tsf(start=350)
    "Fluid temperature at the outlet of the cold side";
  ThermoSysPro.Units.SI.PressureDifference DPfc(start=1e3)
    "Friction pressure loss in the hot side";
  ThermoSysPro.Units.SI.PressureDifference DPgc(start=1e2)
    "Gravity pressure loss in the hot side";
  ThermoSysPro.Units.SI.PressureDifference DPc(start=1e3)
    "Total pressure loss in the hot side";
  ThermoSysPro.Units.SI.PressureDifference DPff(start=1e3)
    "Friction pressure loss in the cold side";
  ThermoSysPro.Units.SI.PressureDifference DPgf(start=1e2)
    "Gravity pressure loss in the cold side";
  ThermoSysPro.Units.SI.PressureDifference DPf(start=1e3)
    "Total pressure loss in the cold side";
  Units.SI.Density rhoc(start=998) "Density of the fluid in the hot side";
  Units.SI.Density rhof(start=998) "Density of the fluid in the cold side";
  Units.SI.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Units.SI.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";
  FluidType ftype_c "Fluid type for the hot fluid";
  Integer fluid_c=Integer(ftype_c) "Fluid number for the hot fluid";
  FluidType ftype_f "Fluid type for the cold fluid";
  Integer fluid_f=Integer(ftype_f) "Fluid number for the cold fluid";

public
  Interfaces.Connectors.FluidInlet Ec annotation (Placement(transformation(
          extent={{-70,-110},{-50,-90}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ef annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sf annotation (Placement(transformation(
          extent={{90,-11},{110,9}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sc annotation (Placement(transformation(
          extent={{50,-110},{70,-90}}, rotation=0)));
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

  /* Check that the fluid type for both sides is water/steam */
  assert((ftype_c == FluidType.WaterSteam) or (ftype_c == FluidType.WaterSteamSimple), "SimpleStaticCondenser: the fluid type must be water/steam for the hot side");
  assert((ftype_f == FluidType.WaterSteam) or (ftype_f == FluidType.WaterSteamSimple), "SimpleStaticCondenser: the fluid type must be water/steam for the cold side");

  /* Mass flow rates */
  Ec.Q = Sc.Q;

  Ec.h_vol_1 = Sc.h_vol_1;
  Ec.h_vol_2 = Sc.h_vol_2;

  Sc.diff_on_1 = Ec.diff_on_1;
  Ec.diff_on_2 = Sc.diff_on_2;

  Sc.diff_res_1 = Ec.diff_res_1 + 1/gamma_diff_c;
  Ec.diff_res_2 = Sc.diff_res_2 + 1/gamma_diff_c;

  Ec.ftype = Sc.ftype;

  Ec.Xco2 = Sc.Xco2;
  Ec.Xh2o = Sc.Xh2o;
  Ec.Xo2  = Sc.Xo2;
  Ec.Xso2 = Sc.Xso2;

  ftype_c = Ec.ftype;

  Ef.Q = Sf.Q;

  Ef.h_vol_1 = Sf.h_vol_1;
  Ef.h_vol_2 = Sf.h_vol_2;

  Sf.diff_on_1 = Ef.diff_on_1;
  Ef.diff_on_2 = Sf.diff_on_2;

  Sf.diff_res_1 = Ef.diff_res_1 + 1/gamma_diff_f;
  Ef.diff_res_2 = Sf.diff_res_2 + 1/gamma_diff_f;

  Ef.ftype = Sf.ftype;

  Ef.Xco2 = Sf.Xco2;
  Ef.Xh2o = Sf.Xh2o;
  Ef.Xo2  = Sf.Xo2;
  Ef.Xso2 = Sf.Xso2;

  ftype_f = Ef.ftype;

  Qc = Ec.Q;
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

  /* Fluid thermodynamic properties at the hot side */
  proce = ThermoSysPro.Properties.Fluid.Ph(Ec.P, Ec.h, mode_c, fluid_c);
  procs = ThermoSysPro.Properties.Fluid.Ph(Sc.P, Sc.h, mode_cs, fluid_c);
  promc = ThermoSysPro.Properties.Fluid.Ph((Ec.P + Sc.P)/2, (Ec.h + Sc.h)/2, mode_c, fluid_c);

  Tec = proce.T;
  Tsc = procs.T;

  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(Ec.P, fluid_c);

  if (p_rhoc > 0) then
    rhoc = p_rhoc;
  else
    rhoc = promc.d;
  end if;

  /* Fluid thermodynamic properties at the cold side */
  profe = ThermoSysPro.Properties.Fluid.Ph(Ef.P, Ef.h, mode_f, fluid_f);
  profs = ThermoSysPro.Properties.Fluid.Ph(Sf.P, Sf.h, mode_f, fluid_f);
  promf = ThermoSysPro.Properties.Fluid.Ph((Ef.P + Sf.P)/2, (Ef.h + Sf.h)/2, mode_f, fluid_f);

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
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,255,0}),
          Line(
          points={{-60,-90},{-60,38},{0,-8},{60,40},{60,-90}},
          color={0,0,255},
          thickness=0),
        Text(
          extent={{-104,-90},{-76,-110}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Steam inlet"),
        Text(
          extent={{-132,28},{-106,14}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold inlet"),
        Text(
          extent={{104,28},{134,12}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold outlet"),
        Text(
          extent={{78,-90},{106,-110}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Steam outlet")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={255,255,0}),
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
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"),
    DymolaStoredErrors);
end SimpleStaticCondenser;
