within ThermoSysPro.FlueGases.BoundaryConditions;
model SinkPQ "Flue gas sink with fixed pressure and mass flow rate"
  parameter Modelica.SIunits.AbsolutePressure P0=100000 "Sink pressure";
  parameter Modelica.SIunits.MassFlowRate Q0=100 "Sink mass flow rate";

public
  Modelica.SIunits.AbsolutePressure P "Fluid pressure";
  Modelica.SIunits.MassFlowRate Q "Mass flow";
  Modelica.SIunits.Temperature T "Fluid temperature";
  Real Xco2 "CO2 mass fraction";
  Real Xh2o "H2O mass fraction";
  Real Xo2 "O2 mass fraction";
  Real Xso2 "SO2 mass fraction";
  Real Xn2 "N2 mass fraction";

public
  ThermoSysPro.FlueGases.Connectors.FlueGasesInlet C
    annotation (Placement(transformation(extent={{-108,-10},{-88,10}}, rotation=
           0)));
  ThermoSysPro.InstrumentationAndControl.Connectors.InputReal IPressure
    annotation (Placement(transformation(extent={{60,-9},{40,9}}, rotation=0)));
public
  InstrumentationAndControl.Connectors.InputReal IMassFlow
    annotation (Placement(transformation(
        origin={0,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation

  C.P = P;
  C.Q = Q;
  C.T = T;

  /* Flue gas composition */
  C.Xco2 = Xco2;
  C.Xh2o = Xh2o;
  C.Xo2 = Xo2;
  C.Xso2 = Xso2;

  Xn2 = 1 - Xco2 - Xh2o - Xo2 - Xso2;

  /* Pressure */
  if (cardinality(IPressure) == 0) then
    IPressure.signal = P0;
  end if;

  P = IPressure.signal;

  /* Mass flow rate */
  if (cardinality(IMassFlow) == 0) then
    IMassFlow.signal = Q0;
  end if;

  Q = IMassFlow.signal;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          textString=
               "PQ"),
        Line(points={{-90,0},{-40,0},{-58,10}}),
        Line(points={{-40,0},{-58,-10}}),
        Text(
          extent={{40,28},{64,6}},
          lineColor={0,0,255},
          textString=
               "P"),
        Text(
          extent={{-40,60},{-6,40}},
          lineColor={0,0,255},
          textString=
               "Q")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          textString=
               "PQ"),
        Line(points={{-90,0},{-40,0},{-58,10}}),
        Line(points={{-40,0},{-58,-10}}),
        Text(
          extent={{40,28},{64,6}},
          lineColor={0,0,255},
          textString=
               "P"),
        Text(
          extent={{-40,60},{-6,40}},
          lineColor={0,0,255},
          textString=
               "Q")}),
    Window(
      x=0.09,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2010</b></p>
</HTML>
<html>
<p><b>ThermoSysPro Version 2.0</b></p>
</HTML>
", revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end SinkPQ;
