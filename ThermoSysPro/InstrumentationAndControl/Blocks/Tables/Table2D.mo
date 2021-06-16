within ThermoSysPro.InstrumentationAndControl.Blocks.Tables;
block Table2D
  parameter Real Tu1[:,1]=[0; 0] "Entrées lignes de la table";
  parameter Real Tu2[1,:]=[0, 0] "Entrées colonnes de la table";
  parameter Real Ty[size(Tu1, 1), size(Tu2, 2)]=[0, 0; 0, 0]
    "Sorties de la table";
  parameter Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation";

public
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u1
                                       annotation (Placement(transformation(
          extent={{-120,50},{-100,70}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u2
                                       annotation (Placement(transformation(
          extent={{-120,-70},{-100,-50}}, rotation=0)));
equation

  if (option_interpolation == 1) then
    y.signal = ThermoSysPro.Functions.TableLinearInterpolation(Tu1[:, 1], Tu2[1, :], Ty, u1.signal, u2.signal);
  elseif (option_interpolation == 2) then
    y.signal = ThermoSysPro.Functions.TableSplineInterpolation(Tu1[:, 1], Tu2[1, :], Ty, u1.signal, u2.signal);
  else
    assert(false, "Table1D: incorrect interpolation option");
  end if;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,255}),
        Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
              -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
              {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={0,
              0,0}),
        Line(points={{0,40},{0,-40}}, color={0,0,0}),
        Rectangle(
          extent={{-54,20},{-28,0}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,0},{-28,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,-20},{-28,-40}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-28,40},{0,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,40},{28,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,40},{54,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-54,40},{-28,20}}, color={0,0,0}),
        Line(points={{-28,40},{-54,20}}, color={0,0,0}),
        Text(extent={{-54,-40},{-30,-56}}, textString=
                                               "u1"),
        Text(extent={{28,58},{52,44}}, textString=
                                           "u2"),
        Text(extent={{-4,12},{30,-22}}, textString=
                                            "y"),
        Line(points={{80,0},{100,0}}),
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Line(points={{-100,60},{-80,60}}),
        Line(points={{-80,-60},{-100,-60}})}),
    Window(
      x=0.13,
      y=0.18,
      width=0.73,
      height=0.6),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,255}),
        Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
              -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
              {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={0,
              0,0}),
        Line(points={{0,40},{0,-40}}, color={0,0,0}),
        Rectangle(
          extent={{-54,20},{-28,0}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,0},{-28,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-54,-20},{-28,-40}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-28,40},{0,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{0,40},{28,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{28,40},{54,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-54,40},{-28,20}}, color={0,0,0}),
        Line(points={{-28,40},{-54,20}}, color={0,0,0}),
        Text(extent={{-54,-40},{-30,-56}}, textString=
                                               "u1"),
        Text(extent={{28,58},{52,44}}, textString=
                                           "u2"),
        Text(extent={{-4,12},{30,-22}}, textString=
                                            "y"),
        Line(points={{80,0},{100,0}}),
        Line(points={{-80,-60},{-100,-60}}),
        Line(points={{-100,60},{-80,60}})}),
    Documentation(info="<html>
<p><b>Adapted from the ModelicaAdditions.Blocks.Tables library</b> </p>
<p><b>Version 3.1</h4>
</html>"),    Icon(
      Rectangle(extent=[-80,80; 80,-80],   style(fillPattern=0)),
      Line(points=[-54,40; -54,-40; 54,-40; 54,40; 28,40; 28,-40; -28,-40; -28,
            40; -54,40; -54,20; 54,20; 54,0; -54,0; -54,-20; 54,-20; 54,-40;
            -54,-40; -54,40; 54,40; 54,-40],               style(color=0)),
      Line(points=[0,40; 0,-40],   style(color=0)),
      Rectangle(extent=[-54,20; -28,0],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[-54,0; -28,-20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[-54,-20; -28,-40],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[-28,40; 0,20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[0,40; 28,20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[28,40; 54,20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Line(points=[-54,40; -28,20],   style(color=0)),
      Line(points=[-28,40; -54,20],   style(color=0)),
      Text(extent=[-54,-40; -30,-56],   string="u1"),
      Text(extent=[56,38; 80,24],   string="u2"),
      Text(extent=[0,0; 28,-20],     string="y"),
      Line(points=[80,0; 100,0]),
      Line(points=[-100,60; -80,60]),
      Line(points=[-80,-60; -100,-60])), Diagram(
      Rectangle(extent=[-80,80; 80,-80],   style(fillPattern=0)),
      Line(points=[-54,40; -54,-40; 54,-40; 54,40; 28,40; 28,-40; -28,-40; -28,
            40; -54,40; -54,20; 54,20; 54,0; -54,0; -54,-20; 54,-20; 54,-40;
            -54,-40; -54,40; 54,40; 54,-40],               style(color=0)),
      Line(points=[0,40; 0,-40],   style(color=0)),
      Rectangle(extent=[-54,20; -28,0],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[-54,0; -28,-20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[-54,-20; -28,-40],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[-28,40; 0,20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[0,40; 28,20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Rectangle(extent=[28,40; 54,20],   style(
          color=0,
          fillColor=6,
          fillPattern=1)),
      Line(points=[-54,40; -28,20],   style(color=0)),
      Line(points=[-28,40; -54,20],   style(color=0)),
      Text(extent=[-54,-40; -30,-56],   string="u1"),
      Text(extent=[56,38; 80,24],   string="u2"),
      Text(extent=[0,0; 28,-20],     string="y"),
      Line(points=[80,0; 100,0]),
      Line(points=[-100,60; -80,60]),
      Line(points=[-80,-60; -100,-60])));
end Table2D;
