within ThermoSysPro.Thermal.HeatTransfer;
model ConvectiveHeatFlow "Convective heat flow"
  parameter Modelica.SIunits.Area A[:]={1} "Heat exchange surface";
  parameter Modelica.SIunits.CoefficientOfHeatTransfer k[:]={1000}
    "Heat exchange coefficient";

protected
  parameter Integer N=size(A, 1);
public
  ThermoSysPro.Thermal.Connectors.ThermalPort C1       annotation (Placement(
        transformation(extent={{-10,90},{10,110}}, rotation=0)));
  ThermoSysPro.Thermal.Connectors.ThermalPort C2       annotation (Placement(
        transformation(extent={{-10,-110},{10,-90}}, rotation=0)));
equation

  C1.W = k*A*(C1.T - C2.T);
  C1.W = -C2.W;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-15,65},{15,65},{0,90},{-15,65}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,70},{0,40},{-20,30},{20,10},{-20,-10},{20,-30},{0,-40},{0,
              -70}},
          color={255,0,0},
          thickness=0.5),
        Polygon(
          points={{-15,-65},{15,-65},{0,-90},{-15,-65}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{-15,65},{15,65},{0,90},{-15,65}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{0,70},{0,40},{-20,30},{20,10},{-20,-10},{20,-30},{0,-40},{0,
              -70}},
          color={255,0,0},
          thickness=0.5),
        Polygon(
          points={{-15,-65},{15,-65},{0,-90},{-15,-65}},
          lineColor={255,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid)}),
    Window(
      x=0.24,
      y=0.27,
      width=0.6,
      height=0.6),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
"));
end ConvectiveHeatFlow;
