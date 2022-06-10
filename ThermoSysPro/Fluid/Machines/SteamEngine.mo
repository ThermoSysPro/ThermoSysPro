within ThermoSysPro.Fluid.Machines;
model SteamEngine "Steam engine"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Real caract[:, 2]=[0, 0; 15e5, 20.0] "Engine charateristics Q=f(deltaP)";
  parameter Real eta_is=0.85 "Isentropic efficiency";
  parameter Real W_frot=0.0 "Power losses due to hydrodynamic friction (percent)";
  parameter Real eta_stato=1.0 "Efficiency to account for cinetic losses (<= 1) (s.u.)";
  parameter Integer option_interpolation=1 "1: linear interpolation - 2: spline interpolation";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter IF97Region region_e=IF97Region.All_regions "Inlet IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));
  parameter IF97Region region_s=IF97Region.All_regions "Outlet IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Units.SI.Acceleration g=Modelica.Constants.g_n "Gravity constant";
  parameter Integer mode_e=Integer(region_e) - 1 "Inlet IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Integer mode_s=Integer(region_s) - 1 "Outlet IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";

public
  Units.SI.Power W "Power produced by the engine";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.SpecificEnthalpy His
    "Fluid specific enthalpy after isentropic expansion";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Pressure loss";
  Units.SI.AbsolutePressure Pe(start=10e5) "Pressure at the inlet";
  Units.SI.AbsolutePressure Ps(start=10e5) "Pressure at the outlet";
  Units.SI.Temperature Te "Temperature at the inlet";
  Units.SI.Temperature Ts "Temperature at the outlet";
  Real xm(start=1.0,min=0) "Average vapor mass fraction (n.u.)";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph proe
    annotation (Placement(transformation(extent={{-80,80},{-60,100}}, rotation=
            0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ph pros
    annotation (Placement(transformation(extent={{60,80},{80,100}}, rotation=0)));
  Interfaces.Connectors.FluidInlet C1 annotation (Placement(transformation(
          extent={{-80,-10},{-60,10}}, rotation=0)));
  Interfaces.Connectors.FluidOutlet C2 annotation (Placement(transformation(
          extent={{60,-10},{80,10}}, rotation=0)));
  ThermoSysPro.Properties.WaterSteam.Common.ThermoProperties_ps props
    annotation (Placement(transformation(extent={{-80,40},{-60,60}}, rotation=0)));
equation

  /* Check that the fluid type is water/steam */
  assert((ftype == FluidType.WaterSteam) or (ftype == FluidType.WaterSteamSimple), "SteamEngine: the fluid type must be water/steam");

  C1.Q = C2.Q;

  C1.h_vol_1 = C2.h_vol_1;
  C1.h_vol_2 = C2.h_vol_2;

  C2.diff_on_1 = if (gamma_diff > 0) then C1.diff_on_1 else false;
  C1.diff_on_2 = if (gamma_diff > 0) then C2.diff_on_2 else false;

  C2.diff_res_1 = C1.diff_res_1 + (if (gamma_diff > 0) then 1/gamma_diff else 0);
  C1.diff_res_2 = C2.diff_res_2 + (if (gamma_diff > 0) then 1/gamma_diff else 0);

  C1.ftype = C2.ftype;

  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2  = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  Q = C1.Q;
  Pe = C1.P;
  Ps = C2.P;
  deltaP = Pe - Ps;

  ftype = C1.ftype;

  /* Average vapor mass fraction during the expansion */
  xm = (proe.x + pros.x)/2.0;

  /* Mass flow */
  if (option_interpolation == 1) then
    Q = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], deltaP);
  elseif (option_interpolation == 2) then
    Q = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], deltaP);
  else
    assert(false, "SteamEngine: incorrect interpolation option");
  end if;

  /* Fluid specific enthalpy at the outlet */
  C2.h - C1.h = xm*eta_is*(His - C1.h);

  /* Mechanical power produced by the engine */
  W = Q*eta_stato*(C1.h - C2.h)*(1 - W_frot/100);

  /* Fluid thermodynamic properties before the expansion */
  proe = ThermoSysPro.Properties.Fluid.Ph(Pe, C1.h, mode_e,fluid);
  Te = proe.T;

  /* Fluid thermodynamic properties after the expansion */
  pros = ThermoSysPro.Properties.Fluid.Ph(Ps, C2.h, mode_s,fluid);
  Ts = pros.T;

  /* Fluid thermodynamic properties after the isentropic expansion */
  props = ThermoSysPro.Properties.Fluid.Ps(Ps, proe.s, mode_s,fluid);
  His = props.h;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,100},{-60,-100},{60,-100},{60,100},{-60,100}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,100},{20,12}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,-16},{30,-66}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,60},{24,-42}}, color={0,0,255}),
        Rectangle(
          extent={{-20,80},{20,40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-60,100},{-60,-100},{60,-100},{60,100},{-60,100}},
          lineColor={28,108,200},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-20,100},{20,20}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-22,-16},{30,-66}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{0,60},{24,-42}}, color={0,0,255}),
        Rectangle(
          extent={{-20,80},{20,40}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Forward)}),
    Window(
      x=0.17,
      y=0.1,
      width=0.76,
      height=0.76),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Beno&icirc;t Bride</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end SteamEngine;
