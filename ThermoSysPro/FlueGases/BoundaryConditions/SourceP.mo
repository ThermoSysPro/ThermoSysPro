within ThermoSysPro.FlueGases.BoundaryConditions;
model SourceP "Flue gas source with fixed pressure"
  parameter Modelica.SIunits.AbsolutePressure P0=200000 "Source pressure";
  parameter Modelica.SIunits.Temperature T0=400 "Source temperature";
  parameter Real Xco2=0.10 "CO2 mass fraction";
  parameter Real Xh2o=0.05 "H2O mass fraction";
  parameter Real Xo2=0.22 "O2 mass fraction";
  parameter Real Xso2=0.00 "SO2 mass fraction";

public
  Modelica.SIunits.AbsolutePressure P "Fluid pressure";
  Modelica.SIunits.MassFlowRate Q "Mass flow";
  Modelica.SIunits.Temperature T "Fluid temperature";
  Real Xn2 "N2 mas fraction";

public
  ThermoSysPro.FlueGases.Connectors.FlueGasesOutlet C
    annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
public
  InstrumentationAndControl.Connectors.InputReal ITemperature
    annotation (Placement(transformation(
        origin={0,-50},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  InstrumentationAndControl.Connectors.InputReal IPressure
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}}, rotation=
            0)));
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

  /* Temperature */
  if (cardinality(ITemperature) == 0) then
    ITemperature.signal = T0;
  end if;

  T = ITemperature.signal;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-94,28},{98,-28}},
          lineColor={0,0,255},
          textString =                     "P"),
        Text(
          extent={{-64,26},{-40,6}},
          lineColor={0,0,255},
          textString=
               "P"),
        Text(
          extent={{-40,-40},{-2,-60}},
          lineColor={0,0,255},
          textString=
               "T")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={127,255,0},
          fillPattern=FillPattern.Backward),
        Text(
          extent={{-92,30},{100,-26}},
          lineColor={0,0,255},
          textString =                     "P"),
        Text(
          extent={{-64,26},{-40,6}},
          lineColor={0,0,255},
          textString=
               "P"),
        Text(
          extent={{-40,-40},{-2,-60}},
          lineColor={0,0,255},
          textString=
               "T")}),
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
end SourceP;
