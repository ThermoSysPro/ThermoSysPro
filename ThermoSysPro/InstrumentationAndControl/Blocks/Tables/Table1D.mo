within ThermoSysPro.InstrumentationAndControl.Blocks.Tables;
block Table1D
  parameter Real Table[:, 2]=[0, 0; 0, 0]
    "Table (entrées = première colonne, sorties = deuxième colonne)";
  parameter Integer option_interpolation=1
    "1: linear interpolation - 2: spline interpolation";

protected
  parameter Real Tu[:]=Table[:, 1] "Entrées de la table";
  parameter Real Ty[:]=Table[:, 2] "Sorties de la table";
public
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal u
                                      annotation (Placement(transformation(
          extent={{-120,-10},{-100,10}}, rotation=0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.OutputReal y
                                       annotation (Placement(transformation(
          extent={{100,-10},{120,10}}, rotation=0)));
equation

  if (option_interpolation == 1) then
    y.signal = ThermoSysPro.Functions.LinearInterpolation(Tu, Ty, u.signal);
  elseif (option_interpolation == 2) then
     y.signal = ThermoSysPro.Functions.SplineInterpolation(Tu, Ty, u.signal);
  else
    assert(false, "Table1D: incorrect interpolation option");
  end if;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,255}),
        Line(points={{80,0},{100,0}}),
        Line(points={{28,40},{28,-40}}, color={0,0,0}),
        Rectangle(
          extent={{-26,40},{0,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,20},{0,0}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,0},{0,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,-20},{0,-40}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-24,56},{-6,44}}, textString=
                                            "u"),
        Text(extent={{2,56},{26,44}}, textString=
                                          "y"),
        Text(extent={{-98,14},{-80,2}}, textString=
                                            "u"),
        Text(extent={{78,14},{102,2}}, textString=
                                           "y"),
        Line(points={{-80,0},{-100,0}}),
        Line(points={{0,40},{28,40}}, color={0,0,0}),
        Line(points={{0,20},{28,20}}, color={0,0,0}),
        Line(points={{0,0},{28,0}}, color={0,0,0}),
        Line(points={{0,-20},{28,-20}}, color={0,0,0}),
        Line(points={{0,-40},{28,-40}}, color={0,0,0})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-150,150},{150,110}}, textString=
                                                "%name"),
        Rectangle(extent={{-80,80},{80,-80}}, lineColor={0,0,255}),
        Line(points={{80,0},{100,0}}),
        Line(points={{28,40},{28,-40}}, color={0,0,0}),
        Rectangle(
          extent={{-26,40},{0,20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,20},{0,0}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,0},{0,-20}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-26,-20},{0,-40}},
          lineColor={0,0,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-24,56},{-6,44}}, textString=
                                            "u"),
        Text(extent={{2,56},{26,44}}, textString=
                                          "y"),
        Text(extent={{-98,14},{-80,2}}, textString=
                                            "u"),
        Text(extent={{78,14},{102,2}}, textString=
                                           "y"),
        Line(points={{-80,0},{-100,0}}),
        Line(points={{0,40},{28,40}}, color={0,0,0}),
        Line(points={{0,20},{28,20}}, color={0,0,0}),
        Line(points={{0,0},{28,0}}, color={0,0,0}),
        Line(points={{0,-20},{28,-20}}, color={0,0,0}),
        Line(points={{0,-40},{28,-40}}, color={0,0,0})}),
    Window(
      x=0.17,
      y=0.19,
      width=0.83,
      height=0.6),
    Documentation(info="<html>
<p><b>Adapted from the ModelicaAdditions.Blocks.Tables library</b> </p>
<p><b>Version 3.1</h4>
</html>"));
end Table1D;
