within ThermoSysPro.Fluid.BoundaryConditions;
model RefXgas "Fixed gas composition"

  parameter Real Xco2=0.05 "CO2 mass fraction at the outlet";
  parameter Real Xh2o=0.01 "H2O mass fraction at the outlet";
  parameter Real Xo2=0.1 "O2 mass fraction at the outlet";
  parameter Real Xso2=0 "SO2 mas fraction at the outlet";

public
  Units.SI.MassFlowRate Q "Fluid mass flow rate";
  Units.SI.AbsolutePressure P "Pressure";
  Units.SI.SpecificEnthalpy h "Fluid specific enthalpy";

  ThermoSysPro.Fluid.Interfaces.Connectors.FluidInlet C1 annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}, rotation=0)));
  ThermoSysPro.Fluid.Interfaces.Connectors.FluidOutlet C2 annotation (Placement(
        transformation(extent={{90,-10},{110,10}}, rotation=0)));

  InstrumentationAndControl.Connectors.InputReal IXco2 annotation (Placement(
        transformation(
        origin={-90,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  InstrumentationAndControl.Connectors.InputReal IXh2o annotation (Placement(
        transformation(
        origin={-30,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  InstrumentationAndControl.Connectors.InputReal IXo2 annotation (Placement(
        transformation(
        origin={30,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  InstrumentationAndControl.Connectors.InputReal IXso2 annotation (Placement(
        transformation(
        origin={90,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  if (cardinality(IXco2) == 0) then
    IXco2.signal = Xco2;
  end if;

  if (cardinality(IXh2o) == 0) then
    IXh2o.signal = Xh2o;
  end if;

  if (cardinality(IXo2) == 0) then
    IXo2.signal = Xo2;
  end if;

  if (cardinality(IXso2) == 0) then
    IXso2.signal = Xso2;
  end if;

  C1.Q = C2.Q;
  C1.P = C2.P;
  C1.h = C2.h;

  C1.h_vol_1 = C2.h_vol_1;
  C1.h_vol_2 = C2.h_vol_2;

  C2.diff_on_1 = C1.diff_on_1;
  C1.diff_on_2 = C2.diff_on_2;

  C2.diff_res_1 = C1.diff_res_1;
  C1.diff_res_2 = C2.diff_res_2;

  C1.ftype = C2.ftype;

  C1.Xco2 = C2.Xco2;
  C1.Xh2o = C2.Xh2o;
  C1.Xo2  = C2.Xo2;
  C1.Xso2 = C2.Xso2;

  Q = C1.Q;
  P = C1.P;
  h = C1.h;

  C1.Xco2 = Xco2;
  C1.Xso2 = Xso2;
  C1.Xh2o = Xh2o;
  C1.Xo2 = Xo2;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Solid,
          fillColor={128,255,0}),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,30},{28,-26}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString="X"),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillPattern=FillPattern.Solid,
          fillColor=DynamicSelect({127,255,0}, fill_color_singular)),
        Line(points={{-90,0},{-40,0}}, color={0,0,255}),
        Line(points={{40,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-28,27},{28,-29}},
          lineColor={0,0,255},
          fillColor={128,255,0},
          fillPattern=FillPattern.Solid,
          textString="X"),
        Line(points={{0,100},{0,40}}, color={0,0,255}),
        Line(points={{20,60},{0,40},{-20,60}}, color={0,0,255}),
        Rectangle(
          extent={{-100,100},{100,90}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,90},{-80,80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          textString="CO2"),
        Text(
          extent={{-40,90},{-20,80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          textString="H2O"),
        Text(
          extent={{20,90},{40,80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          textString="O2"),
        Text(
          extent={{80,90},{100,80}},
          lineColor={28,108,200},
          fillColor={28,108,200},
          fillPattern=FillPattern.None,
          textString="SO2")}),
    Window(
      x=0.06,
      y=0.08,
      width=0.82,
      height=0.65),
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
</html>"),
    DymolaStoredErrors);
end RefXgas;
