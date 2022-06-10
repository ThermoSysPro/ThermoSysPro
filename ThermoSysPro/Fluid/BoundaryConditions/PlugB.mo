within ThermoSysPro.Fluid.BoundaryConditions;
model PlugB "Plug"
  extends
    ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidTypeVariableInterface;
  import ThermoSysPro.Fluid.Interfaces.PropertyInterfaces.FluidType;

  parameter Boolean diffusion=false "true: energy balance equation with diffusion - false: energy balance equation without diffusion";

public
  Units.SI.MassFlowRate Q "Fluid mass flow rate";
  Units.SI.AbsolutePressure P "Fluid pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";
  FluidType ftype "Fluid type";
  Real Xco2(start=0.01) "CO2 mass fraction of the fluid crossing the boundary of the control volume";
  Real Xh2o(start=0.05) "H2O mass fraction of the fluid crossing the boundary of the control volume";
  Real Xo2(start=0.2) "O2 mass fraction of the fluid crossing the boundary of the control volume";
  Real Xso2(start=0) "SO2 mass fraction of the fluid crossing the boundary of the control volume";

  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
equation

  Q = C.Q;
  P = C.P;
  h = C.h;

  C.h_vol_2 = h;
  C.diff_res_2 = 0;
  C.diff_on_2 = diffusion;

  ftype = C.ftype;

  Xco2 = C.Xco2;
  Xh2o = C.Xh2o;
  Xo2 = C.Xo2;
  Xso2 = C.Xso2;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-90,0},{-40,0},{-54,10}}),
        Line(points={{-54,-10},{-40,0}}),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={128,255,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-92,0},{-40,0},{-54,10}}),
        Line(points={{-54,-10},{-40,0}}),
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({127,255,0}, fill_color_singular))}),
    Window(
      x=0.23,
      y=0.15,
      width=0.81,
      height=0.71),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2021</b> </p>
<p><b>ThermoSysPro Version 4.0</b> </p>
</html>",
   revisions="<html>
<p><u><b>Authors</b></u></p>
<ul>
<li>Baligh El Hefni</li>
<li>Daniel Bouskela </li>
</ul>
</html>"));
end PlugB;
