within ThermoSysPro.Fluid.HeatExchangers;
model StaticExchangerDTorWorEff "Static heat exchanger with fixed delta temperature, delta power or efficiency"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Integer exchanger_type=1 "Exchanger type - 1: delta temperature is fixed - 2: delta power is fixed - 3: efficiency is fixed";
  parameter ThermoSysPro.Units.SI.TemperatureDifference DTfroid=0
    "Temperature difference between the cold inlet and the cold outlet (active if exchanger_type=1)";
  parameter Units.SI.Power DW=0
    "Power increase on the cold side (active if exchanger_type=2)";
  parameter Real EffEch=0.9 "Thermal exchange efficiency (=W/Wmax) (active if exchanger_type=3)";
  parameter Real Kc=1e-4 "Pressure loss coefficient for the hot fluid";
  parameter Real Kf=1e-4 "Pressure loss coefficient for the cold fluid";
  parameter Units.SI.Position z1c=0 "Hot inlet altitude";
  parameter Units.SI.Position z2c=0 "Hot outlet altitude";
  parameter Units.SI.Position z1f=0 "Cold inlet altitude";
  parameter Units.SI.Position z2f=0 "Cold outlet altitude";
  parameter Units.SI.MassFlowRate gamma_diff_c=1e-4
    "Diffusion conductance for the hot fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.MassFlowRate gamma_diff_f=1e-4
    "Diffusion conductance for the cold fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rhoc=0
    "If > 0, fixed fluid density for the hot fluid";
  parameter Units.SI.Density p_rhof=0
    "If > 0, fixed fluid density for the cold fluid";
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
    "Power exchanged from the hot fluid to the cold fluid";
  Units.SI.Temperature Tec(start=500)
    "Fluid temperature at the inlet of the hot side";
  Units.SI.Temperature Tsc(start=400)
    "Fluid temperature at the outlet of the hot side";
  Units.SI.Temperature Tef(start=350)
    "Fluid temperature at the inlet of the cold side";
  Units.SI.Temperature Tsf(start=450)
    "Fluid temperature at the outlet of the cold side";
  ThermoSysPro.Units.SI.PressureDifference DPfc(start=1e3)
    "Friction pressure loss for the hot fluid";
  ThermoSysPro.Units.SI.PressureDifference DPgc(start=1e2)
    "Gravity pressure loss for the hot fluid";
  ThermoSysPro.Units.SI.PressureDifference DPc(start=1e3)
    "Total pressure loss for the hot fluid";
  ThermoSysPro.Units.SI.PressureDifference DPff(start=1e3)
    "Friction pressure loss for the cold fluid";
  ThermoSysPro.Units.SI.PressureDifference DPgf(start=1e2)
    "Gravity pressure loss for the cold fluid";
  ThermoSysPro.Units.SI.PressureDifference DPf(start=1e3)
    "Total pressure loss for the cold fluid";
  Units.SI.Density rhoc(start=998) "Hot fluid density";
  Units.SI.Density rhof(start=998) "Cold fluid density";
  Units.SI.SpecificHeatCapacity Cpf "Specific heat capacity of the cold fluid";
  Units.SI.SpecificHeatCapacity Cpc "Specific heat capacity of the hot fluid";
  Units.SI.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Units.SI.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";
  FluidType ftype_c "Fluid type for the hot fluid";
  Integer fluid_c=Integer(ftype_c) "Fluid number for the hot fluid";
  FluidType ftype_f "Fluid type for the cold fluid";
  Integer fluid_f=Integer(ftype_f) "Fluid number for the cold fluid";

public
  Interfaces.Connectors.FluidInlet Ec "Hot inlet" annotation (Placement(
        transformation(extent={{-50,31},{-30,51}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ef "Cold inlet" annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sf "Cold outlet" annotation (Placement(
        transformation(extent={{90,-9},{110,11}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sc "Hot outlet" annotation (Placement(
        transformation(extent={{30,31},{50,51}}, rotation=0)));
equation

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

   /* Power exchanged between the hot and cold fluids */
  if (exchanger_type == 1) then
    W = Qf*(Sf.h - Ef.h);
    W = Qc*(Ec.h - Sc.h);
    Sf.h = ThermoSysPro.Properties.Fluid.SpecificEnthalpy_PT(Sf.P, Tsf, fluid_f, mode_f, Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);
    Tsf = Tef + DTfroid;
  elseif (exchanger_type == 2) then
    W = Qf*(Sf.h - Ef.h);
    DW = Qf*(Sf.h - Ef.h);
    DW = Qc*(Ec.h - Sc.h);
    Tsf = ThermoSysPro.Properties.Fluid.Temperature_Ph(Sf.P, Sf.h, fluid_f, mode_f,  Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);
  elseif (exchanger_type == 3) then
    W = noEvent(min(Qc*Cpc, Qf*Cpf)*EffEch*(Tec - Tef));
    Sf.h = Ef.h + W/Qf;
    Sc.h = Ec.h - W/Qc;
    Tsf = ThermoSysPro.Properties.Fluid.Temperature_Ph(Sf.P, Sf.h, fluid_f, mode_f,  Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);
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

 /* Hot fluid Temperature at the inlet and at the outlet */
  Tec = ThermoSysPro.Properties.Fluid.Temperature_Ph(Ec.P, Ec.h, fluid_c, mode_c,  Ec.Xco2, Ec.Xh2o, Ec.Xo2, Ec.Xso2);
  Tsc = ThermoSysPro.Properties.Fluid.Temperature_Ph(Sc.P, Sc.h, fluid_c, mode_cs,  Ec.Xco2, Ec.Xh2o, Ec.Xo2, Ec.Xso2);

  /* Hot fluid density */
  if (p_rhoc > 0) then
    rhoc = p_rhoc;
  else
    rhoc = ThermoSysPro.Properties.Fluid.Density_Ph((Ec.P + Sc.P)/2,(Ec.h + Sc.h)/2, fluid_c, mode_c, Ec.Xco2, Ec.Xh2o, Ec.Xo2, Ec.Xso2);
  end if;

  /* Cold fluid Temperature at the inlet */
  Tef = ThermoSysPro.Properties.Fluid.Temperature_Ph(Ef.P, Ef.h, fluid_f, mode_f, Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);

  /* Cold fluid density */
  if (p_rhof > 0) then
    rhof = p_rhof;
  else
    rhof = ThermoSysPro.Properties.Fluid.Density_Ph((Ef.P + Sf.P)/2,(Ef.h + Sf.h)/2, fluid_f, mode_f, Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);
  end if;

  /* Average specific heat capacities */
  Cpf = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph(Ef.P, Ef.h, fluid_f, mode_f,  Ef.Xco2, Ef.Xh2o, Ef.Xo2, Ef.Xso2);
  Cpc = ThermoSysPro.Properties.Fluid.SpecificHeatCapacityCp_Ph(Ec.P, Ec.h, fluid_c, mode_c,  Ec.Xco2, Ec.Xh2o, Ec.Xo2, Ec.Xso2);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{36,-31},{100,31}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-102,-31},{-38,31}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-68,31},{72,-31}},
          lineColor={255,255,0},
          fillColor= DynamicSelect({255,255,0}, fill_color_static),
          fillPattern=FillPattern.Solid),
        Line(
          points={{-72,31},{72,31},{72,31}},
          color={0,0,0}),
        Line(
          points={{-72,-31},{72,-31},{72,-31}},
          color={0,0,0}),
        Line(
          points={{68,-17},{100,-1}},
          color={0,255,255},
          thickness=0),
        Rectangle(
          extent={{-64,2},{68,2}},
          lineColor={0,255,255},
          lineThickness=0,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-96,5},{-64,21}},
          color={0,255,255},
          thickness=0),
        Line(
          points={{-66,-17},{-66,-7}},
          color={0,255,255},
          thickness=0),
        Line(
          points={{-66,-8},{-66,2}},
          color={0,255,255},
          thickness=0),
        Line(
          points={{70,11},{70,21}},
          color={0,255,255},
          thickness=0),
        Line(
          points={{70,2},{70,12}},
          color={0,255,255},
          thickness=0),
        Line(
          points={{0,31},{0,-23}},
          color={0,0,0},
          thickness=0),
        Rectangle(
          extent={{-64,21},{68,21}},
          lineColor={0,255,255},
          lineThickness=0,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-64,-17},{68,-17}},
          lineColor={0,255,255},
          lineThickness=0,
          fillColor={0,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,31},{0,-23}},
          color={0,0,0},
          thickness=0),
        Text(
          extent={{-126,26},{-96,18}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold inlet"),
        Text(
          extent={{94,30},{124,16}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold outlet"),
        Text(
          extent={{-88,56},{-60,44}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot inlet"),
        Text(
          extent={{56,56},{88,44}},
          lineColor={238,46,47},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot outlet")}),
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
end StaticExchangerDTorWorEff;
