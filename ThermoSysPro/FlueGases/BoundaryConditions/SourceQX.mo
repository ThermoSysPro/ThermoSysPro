within ThermoSysPro.FlueGases.BoundaryConditions;
model SourceQX "Flue gas source with fixed mass flow rate"
  parameter Modelica.SIunits.MassFlowRate Q0=100 "Source mass flow rate";
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
  InstrumentationAndControl.Connectors.InputReal IMassFlow
    annotation (Placement(transformation(
        origin={39,90},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  InstrumentationAndControl.Connectors.InputReal ITemperature
    annotation (Placement(transformation(
        origin={40,-90},
        extent={{10,-10},{-10,10}},
        rotation=270)));
  InstrumentationAndControl.Connectors.InputReal ICO2 annotation (Placement(
        transformation(
        origin={-90,-90},
        extent={{10,-10},{-10,10}},
        rotation=0), iconTransformation(extent={{-10,-10},{10,10}}, origin={-70,
            -90})));
  InstrumentationAndControl.Connectors.InputReal IH2O annotation (Placement(
        transformation(
        origin={-90,-30},
        extent={{10,-10},{-10,10}},
        rotation=0), iconTransformation(extent={{-10,-10},{10,10}}, origin={-70,
            -30})));
  InstrumentationAndControl.Connectors.InputReal IO2 annotation (Placement(
        transformation(
        origin={-90,30},
        extent={{10,-10},{-10,10}},
        rotation=0), iconTransformation(extent={{-11,-10},{11,10}}, origin={-69,
            30})));
  InstrumentationAndControl.Connectors.InputReal ISO2 annotation (Placement(
        transformation(
        origin={-90,90},
        extent={{10,-10},{-10,10}},
        rotation=0), iconTransformation(extent={{-10,-10},{10,10}}, origin={-70,
            90})));
equation

  C.P = P;
  C.Q = Q;
  C.T = T;

  /* CO2 mass fraction */
  if (cardinality(ICO2) == 0) then
    ICO2.signal = Xco2;
  end if;

  C.Xco2 = ICO2.signal;

  /* H2O mass fraction */
  if (cardinality(IH2O) == 0) then
    IH2O.signal = Xh2o;
  end if;

  C.Xh2o = IH2O.signal;

  /* O2 mass fraction */
  if (cardinality(ICO2) == 0) then
    IO2.signal = Xo2;
  end if;

  C.Xo2 = IO2.signal;

  /* SO2 mass fraction */
  if (cardinality(ISO2) == 0) then
    ISO2.signal = Xso2;
  end if;

  C.Xso2 = ISO2.signal;


  Xn2 = 1 - C.Xco2 - C.Xh2o - C.Xo2 - C.Xso2;

  /* Mass flow rate */
  if (cardinality(IMassFlow) == 0) then
    IMassFlow.signal = Q0;
  end if;

  Q = IMassFlow.signal;

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
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Text(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={160,160,164},
          fillPattern=FillPattern.Solid,
          textString=
               "Q"),
        Text(
          extent={{4,100},{38,80}},
          lineColor={0,0,255},
          textString=
               "Q"),
        Text(
          extent={{0,-80},{38,-100}},
          lineColor={0,0,255},
          textString=
               "T"),
        Text(
          extent={{-114,-58},{-76,-78}},
          lineColor={0,0,255},
          textString="CO2"),
        Text(
          extent={{-114,2},{-76,-18}},
          lineColor={0,0,255},
          textString="H2O"),
        Text(
          extent={{-114,54},{-76,34}},
          lineColor={0,0,255},
          textString="O2"),
        Text(
          extent={{-108,116},{-70,96}},
          lineColor={0,0,255},
          textString="SO2")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward),
        Line(points={{40,0},{90,0},{72,10}}),
        Line(points={{90,0},{72,-10}}),
        Text(
          extent={{-40,40},{40,-40}},
          lineColor={0,0,255},
          fillColor={255,255,0},
          fillPattern=FillPattern.Backward,
          textString=
               "Q"),
        Text(
          extent={{-118,112},{-80,92}},
          lineColor={0,0,255},
          textString="SO2"),
        Text(
          extent={{-126,60},{-88,40}},
          lineColor={0,0,255},
          textString="O2"),
        Text(
          extent={{-116,4},{-84,-16}},
          lineColor={0,0,255},
          textString="H2O"),
        Text(
          extent={{-124,-60},{-86,-80}},
          lineColor={0,0,255},
          textString="CO2"),
        Text(
          extent={{-10,-84},{28,-104}},
          lineColor={0,0,255},
          textString=
               "T"),
        Text(
          extent={{-6,96},{28,76}},
          lineColor={0,0,255},
          textString=
               "Q")}),
    Window(
      x=0.09,
      y=0.2,
      width=0.66,
      height=0.69),
    Documentation(info="<html>
<p><b>Copyright &copy; EDF 2002 - 2019</b> </p>
<p><b>ThermoSysPro Version 3.2</b> </p>
</html>",
   revisions="<html>
<p><u><b>Author</b></u></p>
<ul>
<li>Baligh El Hefni </li>
</ul>
</html>"));
end SourceQX;
