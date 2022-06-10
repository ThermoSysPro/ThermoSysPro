within ThermoSysPro.Fluid.PressureLosses;
model IdealSwitchValve "Ideal switch valve"
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.IF97Region;

  parameter Units.SI.MassFlowRate Qmin=1.e-6
    "Mass flow when the valve is closed";
  parameter Units.SI.MassFlowRate gamma_diff=1e-4
    "Diffusion conductance (active if diffusion=true in neighbouring volumes)";

public
  Units.SI.MassFlowRate Q "Mass flow rate";
  Units.SI.SpecificEnthalpy h(start=100000) "Fluid specific enthalpy";
  ThermoSysPro.Units.SI.PressureDifference deltaP
    "Pressure difference between the inlet and the outlet";
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputLogical Ouv
    annotation (Placement(transformation(
        origin={0,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Interfaces.Connectors.FluidInlet C1 annotation (Placement(transformation(
          extent={{-110,-70},{-90,-50}}, rotation=0), iconTransformation(extent=
           {{-110,-70},{-90,-50}})));
  Interfaces.Connectors.FluidOutlet C2 annotation (Placement(transformation(
          extent={{90,-70},{110,-50}}, rotation=0)));
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

  if Ouv.signal then
    deltaP = 0;
  else
    Q - Qmin = 0;
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-100},{-100,-100}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-100},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor={0,255,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,60},{40,60}},
          color={28,108,200},
          thickness=1),
        Line(points={{0,60},{0,-60}}),
        Text(extent={{-104,34},{88,-22}}, textString=
                                              "DP=0")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-100,-100},{0,-60},{-100,-20},{-100,-100},{-100,-100}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-60},{100,-20},{100,-100},{0,-60},{0,-60}},
          lineColor={0,0,255},
          fillColor= DynamicSelect({127,255,0}, fill_color_singular),
          fillPattern=FillPattern.Solid),
        Line(
          points={{-40,60},{40,60}},
          color={28,108,200},
          thickness=1),
        Line(points={{0,60},{0,-60}}),
        Text(extent={{-104,34},{88,-22}}, textString=
                                              "DP=0")}),
    Window(
      x=0.22,
      y=0.12,
      width=0.72,
      height=0.74),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end IdealSwitchValve;
