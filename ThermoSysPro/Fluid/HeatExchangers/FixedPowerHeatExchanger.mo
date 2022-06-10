within ThermoSysPro.Fluid.HeatExchangers;
model FixedPowerHeatExchanger "Heat exchanger with fixed delta power"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Power DW=0
    "Power exchanged between the hot and the cold fluid";
  parameter Real DPc=10 "Total pressure loss for the hot fluid (percent of the fluid pressure at the inlet)";
  parameter Real DPf=10 "Total pressure loss for the cold fluid (percent of the fluid pressure at the inlet)";
  parameter Units.SI.MassFlowRate gamma_diff_c=1e-4
    "Diffusion conductance for the hot fluid (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.MassFlowRate gamma_diff_f=1e-4
    "Diffusion conductance for the cold fluid (active if diffusion=true in neighbouring volumes)";
  parameter IF97Region region_c=IF97Region.All_regions "IF97 region for the hot fluid (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_f=IF97Region.All_regions "IF97 region for the cold fluid (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer mode_c=Integer(region_c) - 1 "IF97 region for the hot fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_f=Integer(region_f) - 1 "IF97 region for the cold fluid. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.Temperature Tec "Fluid temperature at the inlet of the hot side";
  Units.SI.Temperature Tsc "Fluid temperature at the outlet of the hot side";
  Units.SI.Temperature Tef "Fluid temperature at the inlet of the cold side";
  Units.SI.Temperature Tsf "Fluid temperature at the outlet of the cold side";
  Units.SI.MassFlowRate Qc(start=100) "Hot fluid mass flow rate";
  Units.SI.MassFlowRate Qf(start=100) "Cold fluid mass flow rate";
  FluidType ftype_c "Fluid type for the hot fluid";
  Integer fluid_c=Integer(ftype_c) "Fluid number for the hot fluid";
  FluidType ftype_f "Fluid type for the cold fluid";
  Integer fluid_f=Integer(ftype_f) "Fluid number for the cold fluid";

public
  Interfaces.Connectors.FluidInlet Ec annotation (Placement(transformation(
          extent={{-68,-70},{-48,-50}}, rotation=0)));
  Interfaces.Connectors.FluidInlet Ef annotation (Placement(transformation(
          extent={{-110,-10},{-90,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sf annotation (Placement(transformation(
          extent={{88,-9},{108,11}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet Sc annotation (Placement(transformation(
          extent={{48,-70},{68,-50}}, rotation=0)));

  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proce
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph procs
    annotation (Placement(transformation(extent={{20,80},{40,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profe
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph profs
    annotation (Placement(transformation(extent={{-60,80},{-40,100}}, rotation=
            0)));
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

  /* Power exchanged between the hot and cold fluid */
  DW = Qf*(Sf.h - Ef.h);
  DW = Qc*(Ec.h - Sc.h);

  /* Pressure losses */
  Sc.P = if (Qc > 0) then Ec.P - DPc*Ec.P/100 else Ec.P + DPc*Ec.P/100;
  Sf.P = if (Qf > 0) then Ef.P - DPf*Ef.P/100 else Ef.P + DPf*Ef.P/100;

  /* Fluid thermodynamic properties for the hot fluid */
  proce = ThermoSysPro.Properties.Fluid.Ph(Ec.P, Ec.h, mode_c, fluid_c);
  procs = ThermoSysPro.Properties.Fluid.Ph(Sc.P, Sc.h, mode_c, fluid_c);

  Tec = proce.T;
  Tsc = procs.T;

  /* Fluid thermodynamic properties for the cold fluid */
  profe = ThermoSysPro.Properties.Fluid.Ph(Ef.P, Ef.h, mode_f, fluid_f);
  profs = ThermoSysPro.Properties.Fluid.Ph(Sf.P, Sf.h, mode_f, fluid_f);

  Tef = profe.T;
  Tsf = profs.T;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,62},{100,-62}},
          lineColor={255,255,170},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          lineThickness=0,
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,62},{100,-62}},
          lineColor={0,0,0},
          fillColor={127,255,0},
          fillPattern=FillPattern.CrossDiag),
        Line(
          points={{-58,-50},{-58,4},{-2,-28},{58,6},{58,-50}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-126,24},{-106,14}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold inlet"),
        Text(
          extent={{-88,-70},{-68,-80}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot inlet"),
        Text(
          extent={{70,-72},{94,-82}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Hot outlet"),
        Text(
          extent={{104,24},{128,10}},
          lineColor={0,0,255},
          fillColor={255,213,170},
          fillPattern=FillPattern.Solid,
          textString="Cold outlet")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-100,60},{100,-60}},
          lineColor={28,108,200},
          fillColor={127,255,0},
          fillPattern=FillPattern.CrossDiag), Line(
          points={{-58,-50},{-58,2},{-2,-34},{58,2},{58,-50}},
          color={0,0,255},
          thickness=0.5),
        Text(
          extent={{-104,28},{-60,10}},
          lineColor={0,0,0},
          textString="Cold inlet"),
        Text(
          extent={{62,30},{106,12}},
          lineColor={0,0,0},
          textString="Cold outlet"),
        Text(
          extent={{62,-36},{106,-54}},
          lineColor={238,46,47},
          textString="Hot outlet"),
        Text(
          extent={{-106,-34},{-62,-52}},
          lineColor={238,46,47},
          textString="Hot inlet")}),
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
</html>"));
end FixedPowerHeatExchanger;
