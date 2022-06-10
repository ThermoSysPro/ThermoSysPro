within ThermoSysPro.Fluid.PressureLosses;
model Bend "Bend"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.Diameter D=0.2 "Pipe diameter";
  parameter Units.SI.Radius R0=0.2 "Pipe radius";
  parameter ThermoSysPro.Units.nonSI.Angle_deg delta=90 "Pipe angle";
  parameter Real rugosrel=0 "Pipe roughness";
  parameter Boolean K_A1_Tabule=true
    "true: A1 is computed using linear interpolation - false: A1 is computed using correlation formula";
  parameter Boolean K_B1_Tabule=true
    "true: B1 is computed using linear interpolation - false: B1 is computed using correlation formula";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";
  parameter Units.SI.Density p_rho=0 "If > 0, fixed fluid density"
    annotation (Evaluate=true, Dialog(tab="Fluid", group="Fluid properties"));
  parameter IF97Region region=IF97Region.All_regions "IF97 region (active for IF97 water/steam only)" annotation(Evaluate=true, Dialog(enable=(ftype==FluidType.WaterSteam), tab="Fluid", group="Fluid properties"));

protected
  constant Real pi=Modelica.Constants.pi "pi";
  parameter Integer mode=Integer(region) - 1 "IF97 region. 1:liquid - 2:steam - 4:saturation line - 0:automatic";
  parameter Real eps=1.e-3 "Small number for pressure loss equation";

public
  Real khi "Hydraulic pressure loss coefficient";
  Real khim "Singular pressure loss coefficient";
  Real khif "Friction pressure loss coefficient";
  Real kdelta "Roughness factor for the singular pressure loss";
  ThermoSysPro.Units.SI.PressureDifference deltaP "Presure loss";
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.ReynoldsNumber Re "Reynolds number";
  Units.SI.ReynoldsNumber Relim "Limit Reynolds number";
  Real yA1 "Output of table A1";
  Real yB1 "Output of table B1";
  Real yC1 "Output of table C1";
  Real lambda "Friction pressure loss coefficient";
  Units.SI.Density rho "Fluid density";
  Units.SI.DynamicViscosity mu "Fluid dynamic viscosity";
  Units.SI.Temperature T "Fluid temperature";
  Units.SI.AbsolutePressure Pm "Fluid average pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  FluidType ftype "Fluid type";
  Integer fluid=Integer(ftype) "Fluid number";

public
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1D TA1(
                    Table=[0, 0; 20, 0.31; 30, 0.45; 45, 0.60; 60, 0.78;
        75, 0.90; 90, 1; 110, 1.13; 130, 1.20; 150, 1.28; 180, 1.40])
    annotation (Placement(transformation(extent={{-20,80},{0,100}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Blocks.Tables.Table1D TB1(
                    Table=[0.5, 1.18; 0.6, 0.77; 0.7, 0.51; 0.8, 0.37;
        0.9, 0.28; 1, 0.21; 1.25, 0.19; 1.50, 0.17; 2, 0.15; 4, 0.11; 6, 0.09;
        8, 0.07; 10, 0.07; 15, 0.06; 20, 0.05; 25, 0.05; 30, 0.04; 35, 0.04; 40,
        0.03; 45, 0.03; 50, 0.03]) annotation (Placement(transformation(extent=
            {{20,80},{40,100}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C1 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C2 annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}, rotation=0)));
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
  C1.P - C2.P = deltaP;

  ftype = C1.ftype;

  /* Pressure loss */
  deltaP = 8*khi*ThermoSysPro.Functions.ThermoSquare(Q, eps)/(pi^2*D^4*rho);

    /* Coude ࠰arois concentriques (Idel'cik p. 192). Quadratic flow regime is assumed and Re > 2e5 (Re > Relim). */
  assert(R0/D > 0.5, "Coude: on doit avoir R0/D > 0.5");
  assert((delta > 0) and not (delta > 180),
    "Bend: parameter delta should be such as 0ࠦlt; delta <= 180°");

  khi = kdelta*khim + khif;

  khim = yA1*yB1*yC1;

  TA1.u.signal = delta;

  if (K_A1_Tabule) then
    yA1 = TA1.y.signal;
  else
    yA1 = if (delta < 70) then 0.9*sin(delta) else if (delta > 100) then 0.7 +
      0.35*delta/90 else 1.0;
  end if;

  TB1.u.signal = R0/D;

  if (K_B1_Tabule) then
    yB1 = TB1.y.signal;
  else
    yB1 = if (R0/D < 1) then 0.21/(R0/D)^2.5 else 0.21/(R0/D)^0.5;
  end if;

  yC1 = 1;

  kdelta = if ((rugosrel < 0.001)) and (R0/D < 1.5) then 1.0 + 1.e3*rugosrel else
          if (rugosrel < 0.001) then 1.0 + 1.e6*rugosrel^2 else 2.0;

  khif = 0.0175*lambda*R0*delta/D;

  if (rugosrel > 0.00005) then
    lambda = 1/(2*Modelica.Math.log10(3.7/rugosrel))^2;
  else
    lambda = if noEvent(Re > 0) then 1/(1.8*Modelica.Math.log10(Re) - 1.64)^2 else
            0;
  end if;

  Relim = if (rugosrel > 0.00005) then max(560/rugosrel, 2.e5) else 2.e5;

  Re = 4*abs(Q)/(pi*D*mu);

  /* Fluid thermodynamic properties */
  Pm = (C1.P + C2.P)/2;

  T = ThermoSysPro.Properties.Fluid.Temperature_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);

  if (p_rho > 0) then
    rho = p_rho;
  else
    rho = ThermoSysPro.Properties.Fluid.Density_Ph(Pm, h, fluid,mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);
  end if;

  mu = ThermoSysPro.Properties.Fluid.DynamicViscosity_Ph(Pm, h, fluid, mode, C1.Xco2, C1.Xh2o, C1.Xo2, C1.Xso2);

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,20},{-20,-20}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,255,0}),
        Rectangle(
          extent={{-20,-18},{20,-100}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={127,255,0}),
        Polygon(
          points={{-20,20},{-12,20},{-2,18},{6,14},{12,10},{18,2},{20,-6},{20,
              -18},{-20,20}},
          lineColor={28,108,200},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,20},{-20,-20},{20,-18},{-20,20}},
          lineColor={127,255,0},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-30,-20},{-24,-22},{-22,-24},{-20,-28},{-20,-20},{-30,-20}},
          lineColor={192,192,192},
          fillColor={127,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-30,-20},{-24,-22},{-22,-24},{-20,-28}}, color={28,108,
              200})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-100,20},{-20,-20}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor= DynamicSelect({127,255,0}, fill_color_singular)),
        Rectangle(
          extent={{-20,-18},{20,-100}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor= DynamicSelect({127,255,0}, fill_color_singular)),
        Polygon(
          points={{-20,20},{-12,20},{-2,18},{6,14},{12,10},{18,2},{20,-6},{20,-20},
              {-20,20}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-20,20},{-20,-20},{20,-20},{-20,20}},
          lineColor={127,255,0},
          fillPattern=FillPattern.Solid,
          fillColor= DynamicSelect({127,255,0}, fill_color_singular)),
        Polygon(
          points={{-30,-20},{-24,-22},{-22,-24},{-20,-28},{-20,-20},{-30,-20}},
          lineColor={0,255,0},
          fillColor= DynamicSelect({127,255,0}, fill_color_singular),
          lineThickness=0.5,
          fillPattern=FillPattern.Solid),
        Line(points={{-30,-20},{-24,-22},{-22,-24},{-20,-28}})}),
    Window(
      x=0.04,
      y=0.1,
      width=0.84,
      height=0.67),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
<p>This component model is documented in Sect. 13.6 of the <a href=\"https://www.springer.com/us/book/9783030051044\">ThermoSysPro book</a>. </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Daniel Bouskela</li>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end Bend;
