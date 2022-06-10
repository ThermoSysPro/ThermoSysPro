within ThermoSysPro.Fluid.HeatExchangers;
model SimpleEvaporatorWaterSteamFlueGases "Simple water/steam - flue gases evaporator"
  extends ThermoSysPro.Fluid.Interfaces.IconColors;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real Kdpf=10 "Flue gases pressure drop coefficient";
  parameter Real Kdpe=10 "Water/steam pressure drop coefficient";
  parameter Units.SI.MassFlowRate gamma_diff_ws=1e-4
    "Diffusion conductance for the water/steam side (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.MassFlowRate gamma_diff_fg=1e-4
    "Diffusion conductance for the flue gases side (active if diffusion=true in neighbouring volumes)";
  parameter IF97Region region=IF97Region.All_regions "IF97 region for the water/steam side (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer mode=Integer(region) - 1 "IF97 region for the water/steam side. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real eps=1.e-0 "Small number for pressure loss equation";

public
  Units.SI.AbsolutePressure Pef(start=3e5) "Flue gases pressure at the inlet";
  Units.SI.AbsolutePressure Psf(start=2.5e5)
    "Flue gases pressure at the outlet";
  Units.SI.Temperature Tef(start=600) "Flue gases temperature at the inlet";
  Units.SI.Temperature Tsf(start=400) "Flue gases temperature at the outlet";
  Units.SI.SpecificEnthalpy Hsf(start=3e5)
    "Flue gases specific enthalpy at the outlet";
  Units.SI.SpecificEnthalpy Hef(start=6e5)
    "Flue gases specific enthalpy at the inlet";
  Units.SI.MassFlowRate Qf(start=10) "Flue gases mass flow rate";
  Units.SI.AbsolutePressure Pee(start=2e6) "Water pressure at the inlet";
  Units.SI.AbsolutePressure Pse(start=2e6) "Water pressure at the outlet";
  Units.SI.Temperature Tee(start=400) "Water temperature at the inlet";
  Units.SI.Temperature Tse(start=450) "Water temperature at the outlet";
  Units.SI.SpecificEnthalpy Hee(start=3e5)
    "Water specific enthalpy at the inlet";
  Units.SI.SpecificEnthalpy Hse(start=20e5)
    "Water specific enthalpy at the outlet";
  Units.SI.MassFlowRate Qe(start=10) "Water mass flow rate";
  Units.SI.Density rhof(start=0.9) "Flue gases density";
  Units.SI.Density rhoe(start=700) "Water density";
  Units.SI.Power W(start=1e8) "Power exchanged";
  FluidType ftype_ws "Fluid type for the water/steam side";
  Integer fluid_ws=Integer(ftype_ws) "Fluid number for the water/steam side";
  FluidType ftype_fg "Fluid type for the flue gases side";
  Integer fluid_fg=Integer(ftype_fg) "Fluid number for the flue gases side";

  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cws2 annotation (
      Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Cws1 annotation (
      Placement(transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet Cfg1 annotation (
      Placement(transformation(extent={{-10,80},{10,100}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet Cfg2 annotation (
      Placement(transformation(extent={{-10,-100},{10,-80}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proee
    annotation (Placement(transformation(extent={{-100,80},{-80,100}}, rotation=
           0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proes
    annotation (Placement(transformation(extent={{-52,80},{-32,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proem
    annotation (Placement(transformation(extent={{-76,80},{-56,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat vsat
                                           annotation (Placement(transformation(
          extent={{80,80},{100,100}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.PropThermoSat lsat
    annotation (Placement(transformation(extent={{58,80},{78,100}}, rotation=0)));
equation
  /* Check that the fluid type for the water/steam side is water/steam */
  assert((ftype_ws == FluidType.WaterSteam) or (ftype_ws == FluidType.WaterSteamSimple), "SimpleEvaporatorWaterSteamFlueGases: the fluid type must be water/steam for the water/steam side");

  /* Flue gases inlet */
  Pef = Cfg1.P;
  Hef = Cfg1.h;
  Qf = Cfg1.Q;

  /* Flue gases outlet */
  Psf = Cfg2.P;
  Hsf = Cfg2.h;
  Cfg1.Q = Cfg2.Q;

  Cfg1.h_vol_1 = Cfg2.h_vol_1;
  Cfg1.h_vol_2 = Cfg2.h_vol_2;

  Cfg2.diff_on_1 = Cfg1.diff_on_1;
  Cfg1.diff_on_2 = Cfg2.diff_on_2;

  Cfg2.diff_res_1 = Cfg1.diff_res_1 + 1/gamma_diff_fg;
  Cfg1.diff_res_2 = Cfg2.diff_res_2 + 1/gamma_diff_fg;

  Cfg1.ftype = Cfg2.ftype;

  Cfg2.Xco2 = Cfg1.Xco2;
  Cfg2.Xh2o = Cfg1.Xh2o;
  Cfg2.Xo2  = Cfg1.Xo2;
  Cfg2.Xso2 = Cfg1.Xso2;

  ftype_fg = Cfg1.ftype;

  /* Water inlet */
  Pee = Cws1.P;
  Hee = Cws1.h;
  Qe = Cws1.Q;

  /* Water outlet */
  Pse = Cws2.P;
  Hse = Cws2.h;
  Cws1.Q = Cws2.Q;

  Cws1.h_vol_1 = Cws2.h_vol_1;
  Cws1.h_vol_2 = Cws2.h_vol_2;

  Cws2.diff_on_1 = Cws1.diff_on_1;
  Cws1.diff_on_2 = Cws2.diff_on_2;

  Cws2.diff_res_1 = Cws1.diff_res_1 + 1/gamma_diff_ws;
  Cws1.diff_res_2 = Cws2.diff_res_2 + 1/gamma_diff_ws;

  Cws1.ftype = Cws2.ftype;

  Cws2.Xco2 = Cws1.Xco2;
  Cws2.Xh2o = Cws1.Xh2o;
  Cws2.Xo2  = Cws1.Xo2;
  Cws2.Xso2 = Cws1.Xso2;

  ftype_ws = Cws1.ftype;

  /* Pressure losses */
  Pef = Psf + Kdpf*ThermoSysPro.Functions.ThermoSquare(Qf, eps)/rhof;
  Pee = Pse + Kdpe*ThermoSysPro.Functions.ThermoSquare(Qe, eps)/rhoe;

  /* Power exchanged */
  W = Qf*(Hef - Hsf);
  W = Qe*(Hse - Hee);

  /* Flue gases specific enthalpy at the inlet */
  Tef = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pef, Hef, fluid_fg, 0, Cfg1.Xco2,  Cfg1.Xh2o,  Cfg1.Xo2,  Cfg1.Xso2);

  /* Flue gases specific enthalpy at the outlet */
  Tsf = ThermoSysPro.Properties.Fluid.Temperature_Ph(Psf, Hsf, fluid_fg, 0, Cfg1.Xco2,  Cfg1.Xh2o,  Cfg1.Xo2,  Cfg1.Xso2);

  /* Flue gases density */
  rhof = ThermoSysPro.Properties.Fluid.Density_Ph(Pef, Hef, fluid_fg, 0, Cfg1.Xco2,  Cfg1.Xh2o,  Cfg1.Xo2,  Cfg1.Xso2);

  /* Water/steam thermodynamic properties */
  proee = ThermoSysPro.Properties.Fluid.Ph(Pee, Hee, mode, fluid_ws);
  Tee = proee.T;

  proem = ThermoSysPro.Properties.Fluid.Ph((Pee + Pse)/2, (Hee + Hse)/2, mode, fluid_ws);
  rhoe = proem.d;

  proes = ThermoSysPro.Properties.Fluid.Ph(Pse, Hse, mode, fluid_ws);
  Tse = proes.T;

  (lsat,vsat) = ThermoSysPro.Properties.Fluid.Water_sat_P(Pse, fluid_ws);
  Hse = vsat.h;

  annotation (Diagram(graphics={
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-30,76},{28,66}},
          lineColor={0,0,0},
          lineThickness=0,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "Flue gases"),
        Polygon(
          points={{-94,12},{-80,12},{-80,56},{80,56},{80,12},{92,12},{92,6},{74,
              6},{74,50},{-74,50},{-74,6},{-94,6},{-94,12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-94,-12},{-80,-12},{-80,-56},{80,-56},{80,-12},{92,-12},{92,
              -6},{74,-6},{74,-50},{-74,-50},{-74,-6},{-94,-6},{-94,-12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-114,28},{-48,18}},
          lineColor={0,0,0},
          lineThickness=0,
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={175,175,175},
          textString=
               "Water/Steam"),
        Polygon(
          points={{-94,3},{90,3},{90,-3},{-94,-3},{-94,3}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}),
                            Icon(graphics={
        Rectangle(
          extent={{-100,-75},{100,-85}},
          lineColor={175,175,175},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,86},{100,76}},
          lineColor={175,175,175},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-100,80},{100,-80}},
          lineColor={175,175,175},
          lineThickness=0,
          fillColor= DynamicSelect({255,255,0}, fill_color_static),
          fillPattern=FillPattern.Backward),
        Polygon(
          points={{-94,12},{-80,12},{-80,56},{80,56},{80,12},{92,12},{92,6},{74,
              6},{74,50},{-74,50},{-74,6},{-94,6},{-94,12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-92,3},{92,3},{92,-3},{-92,-3},{-92,3}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-94,-12},{-80,-12},{-80,-56},{80,-56},{80,-12},{92,-12},{92,
              -6},{74,-6},{74,-50},{-74,-50},{-74,-6},{-94,-6},{-94,-12}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-128,26},{-102,16}},
          lineColor={28,108,200},
          lineThickness=0,
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward,
          textString="Water"),
        Text(
          extent={{104,22},{128,12}},
          lineColor={255,0,0},
          lineThickness=0,
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward,
          textString="Steam"),
        Text(
          extent={{-52,-86},{-14,-98}},
          lineColor={28,108,200},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward,
          textString="Flue gases"),
        Text(
          extent={{-50,102},{-14,86}},
          lineColor={238,46,47},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward,
          textString="Flue gases")}),
    Documentation(revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>",
   info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>"));
end SimpleEvaporatorWaterSteamFlueGases;
