within ThermoSysPro.Fluid.PressureLosses;
model ControlValve "Control valve"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter ThermoSysPro.Units.xSI.Cv Cvmax=8005.42
    "Maximum CV (active if mode_caract=0)";
  parameter Real caract[:, 2]=[0, 0; 1, Cvmax]
    "Position vs. Cv characteristics (active if mode_caract=1)";
  parameter Integer mode_caract=0
    "0:linear characteristics - 1:characteristics is given by caract[]";
  parameter Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation (active if mode_caract=1)";
  parameter Integer option_rho_water=1
    "1: using (deltaP*Cv^2=A.Q^2/rho^2) - 2: using (deltaP*Cv^2=A.Q^2/(rho*rho_15)); with rho_15 is the density of the water at 15.5556 °C)";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real eps=1.e-3 "Small number for pressure loss equation";
  parameter Units.SI.Density rho_15=999 "density of the water at 15.5556 °C";

public
  ThermoSysPro.Units.xSI.Cv Cv(start=100) "Cv";
  Units.SI.MassFlowRate Q(start=100) "Mass flow rate";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Singular pressure loss";
  Units.SI.Density rho(start=998) "Fluid density";
  Units.SI.Temperature T(start=290) "Fluid temperature";
  Units.SI.AbsolutePressure Pm(start=1.e5) "Fluid average pressure";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal Ouv
    annotation (Placement(transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C1 annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C2 annotation (Placement(
        transformation(extent={{90,-70},{110,-50}}, rotation=0)));
equation

  C1.Q = C2.Q;
  C1.h = C2.h;

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
  h = C1.h;
  deltaP = C1.P - C2.P;

  ftype = C1.ftype;

  /* Pressure loss */
  if (option_rho_water == 1) then
    deltaP*Cv*abs(Cv) = 1.733e12*ThermoSysPro.Functions.ThermoSquare(Q, eps)/rho^2;
  elseif (option_rho_water == 2) then
    deltaP*Cv*abs(Cv) = 1.733e12*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(rho*rho_15);
  else
    assert(false, "ControlValve - option_rho_water: invalid option");
  end if;

  /* Cv as a function of the valve position */
  if (mode_caract == 0) then
    Cv = Ouv.signal*Cvmax;
  elseif (mode_caract == 1) then
    if (option_interpolation == 1) then
      Cv = ThermoSysPro.Functions.LinearInterpolation(caract[:, 1], caract[:, 2], Ouv.signal);
    elseif (option_interpolation == 2) then
      Cv = ThermoSysPro.Functions.SplineInterpolation(caract[:, 1], caract[:, 2], Ouv.signal);
    else
      assert(false, "ControlValve: incorrect interpolation option");
    end if;
  else
    assert(false, "ControlValve: invalid option");
  end if;

  /* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;

  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);
  end if;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{40,40},{-40,40},{-40,56},{-38,74},{-32,84},{-20,94},{0,100},
              {20,94},{32,84},{38,72},{40,54},{40,40}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{40,40},{-40,40},{0,-60}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-102},{-100,-100}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-102},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor=DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-102},{-100,-100}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-102},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{40,40},{-40,40},{-40,56},{-38,74},{-32,84},{-20,94},{0,100},
              {20,94},{32,84},{38,72},{40,54},{40,40}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{40,40},{-40,40},{0,-60}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.07,
      y=0.13,
      width=0.8,
      height=0.77),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 13.8 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end ControlValve;
